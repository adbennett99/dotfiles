" -------------------------------------------------------------- Mode Maps
function! ModeName()
    let l:mode_map = {
        \ 'n'  : 'NORMAL',
        \ 'v'  : 'VISUAL',
        \ 'V'  : 'V-LINE',
        \ "\<C-v>": 'V-BLOCK',
        \ 'i'  : 'INSERT',
        \ 'c'  : 'COMMAND',
        \ }

    return get(l:mode_map, mode(), mode())
endfunction

function! ModeHighlight()
    let l:highlight_map = {
        \ 'n'  : 'DiffText',
        \ 'i'  : 'DiffAdd',
        \ 'v'  : 'DiffChange',
        \ 'V'  : 'DiffChange',
        \ "\<C-v>" : 'DiffChange',
        \}
    return '%#' . get(l:highlight_map, mode(), 'StatusLine') . '#'
endfunction

" -------------------------------------------------------------- Status Line
function! BuildStatusLine()
    let s = ''
    let s .= ModeHighlight() . ' ' . ModeName() . ' '

    let l:branch = GetGitBranch()
    if l:branch != ''
        let s .= '%#StatusLine2#'
        let s .= ' ⎇  ' . substitute(l:branch, '\n', '', '')
        let s .= ' +' . g:num_added_lines . ' -' . g:num_removed_lines . ' ~' . g:num_modified_lines . ' '
    endif

    let s .= '%#StatusLine#'
    let s .= ' %F%m%=%{&filetype} '

    let s .= '%#StatusLine2#'
    let s .= ' %{&fileencoding?&fileencoding:&encoding} '

    let s .= ModeHighlight()
    let s .= ' In: %l/%L (%c) '

    return s
endfunction

let &statusline = "%!BuildStatusLine()"

" -------------------------------------------------------------- Tab Line
function! BuildTabLine()
    let s = ''
    for i in range(1, bufnr('$'))
        if bufexists(i) && buflisted(i)
            let s .= (i == bufnr('%') ? '%#TabLineSel#' : '%#TabLine#')
            let s .= ' ' . bufname(i)

            if getbufvar(i, '&modified')
                let s .= '[+]'
            endif

            let s .= ' '
        endif
    endfor
    let s .= '%#TabLineFill#%='
    let s .= '%#TabLineSel# buffers '
    return s
endfunction

let &tabline = "%!BuildTabLine()"
