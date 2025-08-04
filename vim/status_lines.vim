" Based on https://github.com/vim-airline/vim-airline
" -------------------------------------------------------------- Theme
" Dracula Color Palette
let s:white        = "231"
let s:gray         = "239"
let s:dark_gray    = "235"
let s:light_purple = "141"
let s:dark_purple  = "61"
let s:cyan         = "117"
let s:green        = "84"
let s:orange       = "215"
let s:red          = "203"
let s:purple       = "135"
let s:pink         = "212"
let s:yellow       = "228"
let s:black        = "16"

execute 'highlight StatusModeDefault ctermfg='. s:black . ' ctermbg=' . s:light_purple
execute 'highlight StatusModeInsert ctermfg='. s:black . ' ctermbg=' . s:green
execute 'highlight StatusModeVisual ctermfg='. s:black . ' ctermbg=' . s:yellow

execute 'highlight FileName ctermfg='. s:white . ' ctermbg=' . s:gray
execute 'highlight FileType ctermfg='. s:white . ' ctermbg=' . s:dark_purple
execute 'highlight FileLoc ctermfg='. s:black . ' ctermbg=' . s:light_purple

execute 'highlight TabLineSel ctermfg='. s:black . ' ctermbg=' . s:light_purple
execute 'highlight TabLineNotSel ctermfg='. s:white . ' ctermbg=' . s:gray
execute 'highlight TabLineFill ctermfg=' . s:dark_gray . ' ctermbg=' . s:dark_gray
execute 'highlight TabLineEnd ctermfg='. s:white . ' ctermbg=' . s:dark_purple

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
        \ 'n'  : 'StatusModeDefault',
        \ 'i'  : 'StatusModeInsert',
        \ 'v'  : 'StatusModeVisual',
        \ 'V'  : 'StatusModeVisual',
        \ "\<C-v>" : 'StatusModeVisual',
        \}
  return '%#' . get(l:highlight_map, mode(), 'StatusModeDefault') . '#'
endfunction

function! BuildStatusLine()
    let s = ''
    let s .= ModeHighlight() . ModeName()

    let s .= '%#FileName#'
    let s .= ' %f%='

    let s .= '%#FileType#'
    let s .= ' %{&filetype} '

    let s .= '%#FileLoc#'
    let s .= ' In: %l/%L (%c)'

    return s
endfunction

set laststatus=2

let &statusline = BuildStatusLine()

" -------------------------------------------------------------- Tab Line
function! BuildTabLine()
  let s = ''
  for i in range(1, bufnr('$'))
    if bufexists(i) && buflisted(i)
      let s .= (i == bufnr('%') ? '%#TabLineSel#' : '%#TabLineNotSel#')
      let s .= ' ' . bufname(i) . ' '
    endif
  endfor
  let s .= '%#TabLineFill#%='
  let s .= '%#TabLineEnd# buffers '
  return s
endfunction

set showtabline=2
let &tabline = BuildTabLine()
