" Based on https://github.com/vim-airline/vim-airline
" -------------------------------------------------------------- Status Line
function! ModeName()
    let l:mode_map = {
        \ 'n'  : 'NORMAL',
        \ 'no' : 'OPERATOR PENDING',
        \ 'v'  : 'VISUAL',
        \ 'V'  : 'V-LINE',
        \ "\<C-v>": 'V-BLOCK',
        \ 's'  : 'SELECT',
        \ 'S'  : 'S-LINE',
        \ "\<C-s>": 'S-BLOCK',
        \ 'i'  : 'INSERT',
        \ 'ic' : 'INSERT',
        \ 'ix' : 'INSERT',
        \ 'R'  : 'REPLACE',
        \ 'Rv' : 'V-REPLACE',
        \ 'c'  : 'COMMAND',
        \ 'cv' : 'VIM EX',
        \ 'ce' : 'EX',
        \ 'r'  : 'PROMPT',
        \ 'rm' : 'MORE',
        \ 'r?' : 'CONFIRM',
        \ '!'  : 'SHELL',
        \ 't'  : 'TERMINAL'
        \ }

    return get(l:mode_map, mode(), mode())
endfunction

function! ModeHighlight()
    let l:highlight_map = {
        \ 'n'  : 'DraculaStatusModeDefault',
        \ 'i'  : 'DraculaStatusModeInsert',
        \ 'v'  : 'DraculaStatusModeVisual',
        \ 'V'  : 'DraculaStatusModeVisual',
        \ "\<C-v>" : 'DraculaStatusModeVisual',
        \}
    return '%#' . get(l:highlight_map, mode(), 'DraculaStatusModeDefault') . '#'
endfunction

function! GetGitInfo()
    let l:dir = expand('%:p:h')
    while !isdirectory(l:dir . '/.git') && l:dir != '/'
        let l:dir = fnamemodify(l:dir, ':h')
    endwhile

    if !isdirectory(l:dir . '/.git')
        return ''
    endif
    
    let l:line = readfile(l:dir . '/.git/HEAD')[0]
    let l:branch = split(line, '/')[-1]

    if exists('g:num_added_lines') && (g:num_added_lines > 0 || g:num_removed_lines > 0 || g:num_modified_lines > 0)
        let l:git_info = '+' . g:num_added_lines . ' -' . g:num_removed_lines . ' ~' . g:num_modified_lines . ' '
    else
        let l:git_info = ''
    endif

    return ' ⎇  ' . substitute(l:branch, '\n', '', '') . ' ' . l:git_info
endfunction

function! BuildStatusLine()
    let s = ''
    let s .= ModeHighlight() . ' ' . ModeName() . ' '

    let s .= '%#DraculaStatusGitBranch#'
    let s .= GetGitInfo()

    let s .= '%#DraculaStatusFileName#'
    let s .= ' %F%m%=%{&filetype} '

    let s .= '%#DraculaStatusFileEncoding#'
    let s .= ' %{&fileencoding?&fileencoding:&encoding} '

    let s .= ModeHighlight()
    let s .= ' In: %l/%L (%c) '

    return s
endfunction

set laststatus=2
let &statusline = "%!BuildStatusLine()"

" -------------------------------------------------------------- Tab Line
function! BuildTabLine()
    let s = ''
    for i in range(1, bufnr('$'))
        if bufexists(i) && buflisted(i)
            let s .= (i == bufnr('%') ? '%#DraculaTabLineSel#' : '%#DraculaTabLineNotSel#')
            let s .= ' ' . bufname(i)

            if getbufvar(i, '&modified')
                let s .= '[+]'
            endif

            let s .= ' '
        endif
    endfor
    let s .= '%#DraculaTabLineFill#%='
    let s .= '%#DraculaTabLineEnd# buffers '
    return s
endfunction

set showtabline=2
let &tabline = "%!BuildTabLine()"
