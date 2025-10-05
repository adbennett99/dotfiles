set signcolumn=yes

sign define GitAddedLine text=+ texthl=GitDiffAdd
sign define GitModifiedLine text=~ texthl=GitDiffChange
sign define GitRemovedLine text=- texthl=GitDiffRemove

function! s:IsGitFile(filename, dir) abort
    if !filereadable(a:filename)
        return 0
    endif

    if empty(a:filename)
        return 0
    endif

    if system('git -C ' . shellescape(a:dir) . ' rev-parse --is-inside-work-tree') !~? '^true'
        return 0
    endif

    return 1
endfunction

function! s:BufferLineCount(bufnr) abort
    let l:info = getbufinfo(a:bufnr)

    if !empty(l:info) && has_key(l:info[0], 'linecount')
        return l:info[0].linecount
    endif

    " Fallback if buffer info missing
    if a:bufnr == bufnr('%')
        return line('$')
    endif

    return 0
endfunction

function! GitSignsUpdate() abort

    let l:buf = bufnr('%')

    " Skip unsuitable buffers
    if !buflisted(l:buf) | return | endif
    if getbufvar(l:buf, '&buftype') !=# '' | return | endif
    if getbufvar(l:buf, '&modifiable') == 0 | return | endif
    if empty(bufname(l:buf)) | return | endif

    let l:file = expand("%:p")
    let l:dir = fnamemodify(l:file, ':h')

    " Clear everything in current buffer
    execute 'sign unplace * buffer=' . l:buf
    let g:num_added_lines=0
    let g:num_removed_lines=0
    let g:num_modified_lines=0

    " If the file is tracked by git, get its diff.
    " note: this will always be the file on disk, so not necessarily the file in the buffer
    let l:isGitFile = s:IsGitFile(l:file, l:dir)
    if !l:isGitFile
        return
    endif

    let l:diff = systemlist('git -C ' . shellescape(l:dir) . ' diff --no-color --unified=0 -- ' . shellescape(l:file))

    let l:lastline = s:BufferLineCount(l:buf)
    if l:lastline <= 0
        return
    endif

    " Parse the diff
    let l:id = 1000
    for l:line in l:diff
        if l:line =~# '^@@'
            " matchlist indices:
            " 1: oldStart, 3: oldCount, 4: newStart, 6: newCount
            let l:m = matchlist(l:line, '^@@\s\+-\(\d\+\)\(,\(\d\+\)\)\?\s\++\(\d\+\)\(,\(\d\+\)\)\?\s\+@@')
            if len(l:m) >= 7
                let l:oldStart = str2nr(l:m[1])
                let l:oldCount = len(l:m[3]) ? str2nr(l:m[3]) : 1
                let l:newStart = str2nr(l:m[4])
                let l:newCount = len(l:m[6]) ? str2nr(l:m[6]) : 1

                if l:oldCount > 0 && l:newCount == 0
                    " Pure deletion: place a single delete sign at the line after deletion (clamped)
                    let l:place = l:newStart
                    if l:place < 1
                        let l:place = 1
                    endif

                    if l:place > l:lastline
                        let l:place = l:lastline
                    endif

                    execute 'sign place ' . l:id . ' line=' . l:place . ' name=GitRemovedLine buffer=' . l:buf
                    let g:num_removed_lines += l:oldCount
                    let l:id += 1
                elseif l:oldCount == 0 && l:newCount > 0
                    " Pure addition: mark added lines
                    for l:lnum in range(l:newStart, l:newStart + l:newCount - 1)
                        execute 'sign place ' . l:id . ' line=' . l:lnum . ' name=GitAddedLine buffer=' . l:buf
                        let g:num_added_lines += 1
                        let l:id += 1
                    endfor
                else
                    " Change (both sides non-zero): mark new lines in the changed block as 'change'
                    for l:lnum in range(l:newStart, l:newStart + l:newCount - 1)
                        execute 'sign place ' . l:id . ' line=' . l:lnum . ' name=GitModifiedLine buffer=' . l:buf
                        let g:num_modified_lines += 1
                        let l:id += 1
                    endfor
                endif
            endif
        endif
    endfor
endfunction

augroup GitSignAutoload
    autocmd!
    autocmd BufReadPost,BufWritePost * call GitSignsUpdate()
augroup end

function! ShowGitBlame()
    let l:file = expand("%:p")
    let l:dir = fnamemodify(l:file, ':h')
    let l:view = winsaveview()

    let l:isGitFile = s:IsGitFile(l:file, l:dir)
    if !l:isGitFile
        return
    endif

    let l:blame = systemlist('git -C ' . shellescape(l:dir) . ' blame --line-porcelain ' . shellescape(l:file))

    let l:blame_output = []
    let l:blame_output_formatted = []
    let l:commit_hash = ''
    let l:author = ''

    for l:line in l:blame
        if l:line =~ '^[0-9a-f]\{40\}'
            if l:commit_hash != ''
                call add(l:blame_output, [l:commit_hash[:10], l:author])
            endif
            let l:commit_hash = matchstr(l:line, '^\([0-9a-f]\{40\}\)')
            let l:author = ''
            let l:summary = ''
        elseif l:line =~ '^author '
            let l:author = substitute(l:line, '^author', '', '')
        endif
    endfor

    if l:commit_hash != ''
        call add(l:blame_output, [l:commit_hash[:10], l:author])
    endif

    let l:longest_name = ''
    for l:bo in l:blame_output
        if len(l:bo[1]) > len(l:longest_name)
            let l:longest_name = l:bo[1]
        endif
    endfor

    for l:bo in l:blame_output
        let l:padd_buf = 0
        if len(l:bo[1]) < len(l:longest_name)
            let l:padd_buf = len(l:longest_name) - len(l:bo[1])
        endif

        let l:name = repeat(' ', l:padd_buf) . l:bo[1]
        call add(l:blame_output_formatted, l:bo[0] . ' ' . l:name)
    endfor

    execute 'vertical leftabove 35new'
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal nobuflisted
    setlocal nowrap
    setlocal noswapfile
    setlocal modifiable

    file GitBlame

    call setline(1, l:blame_output_formatted)
    setlocal nomodifiable

    call winrestview(l:view)

    wincmd p
    call winrestview(l:view)
    setlocal scrollbind cursorbind

    wincmd p
    setlocal scrollbind cursorbind

    set scrollopt=hor,ver
endfunction

nnoremap <Leader>gb :call ShowGitBlame()<CR>
