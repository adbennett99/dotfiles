set signcolumn=yes

sign define GitAddedLine text=+ texthl=DraculaGreen
sign define GitModifiedLine text=~ texthl=DraculaCyan
sign define GitRemovedLine text=- texthl=DraculaRed

function! PlaceGitSigns()
    let l:filename = expand('%:p')
    let l:filedir = fnamemodify(l:filename, ':h')
    let l:buffer = bufnr('%')

    execute 'sign unplace * buffer=' . l:buffer

    if !filereadable(l:filename)
        return
    endif

    if system('git -C ' . shellescape(l:filedir) . ' rev-parse --is-inside-work-tree') !~? '^true'
        return
    endif


    let l:diff_output = systemlist('git -C ' . shellescape(l:filedir) . ' diff --no-color --unified=0 -- ' . shellescape(l:filename))

    let l:sign_id = 1000
    for l:line in l:diff_output
        if l:line =~# '^@@'
            let l:hunk = matchlist(l:line, '^@@ -\(\d\+\),\?\(\d*\) +\+\(\d\+\),\?\(\d*\) @@.*')

            " len(l:hunk) should really be 5... idk why it is 10
            if len(l:hunk) == 10
                let l:old_start = str2nr(hunk[1])
                let l:old_len = empty(hunk[2]) ? 1 : str2nr(l:hunk[2])
                let l:new_start = str2nr(hunk[3])
                let l:new_len = empty(l:hunk[4]) ? 1 : str2nr(l:hunk[4])

                " Deletion
                if l:old_len > 0 && l:new_len == 0
                    execute 'sign place ' . l:sign_id . ' line=' . l:old_start . ' name=GitRemovedLine buffer=' . l:buffer
                    let l:sign_id += 1
                endif

                " Addition
                if l:old_len == 0 && l:new_len > 0
                    for l:i in range(0, l:new_len - 1)
                        execute 'sign place ' . l:sign_id . ' line=' . (l:new_start + l:i) . ' name=GitAddedLine buffer=' . l:buffer
                        let l:sign_id += 1
                    endfor
                endif

                " Modification
                if l:old_start == l:new_start
                    for l:i in range(0, l:new_len - 1)
                        execute 'sign place ' . l:sign_id. ' line=' . (l:new_start + l:i) . ' name=GitModifiedLine buffer=' . l:buffer
                        let l:sign_id += 1
                    endfor
                endif
            endif
        endif
    endfor
endfunction

augroup GitSignAutoload
    autocmd!
    autocmd BufReadPost,BufWritePost * call PlaceGitSigns()
augroup end
