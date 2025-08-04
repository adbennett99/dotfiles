" -------------------------------------------------------------- Dracula color palette
let s:fg        = 253

let s:bglighter = 238
let s:bglight   = 237
let s:bg        = 236
let s:bgdark    = 235
let s:bgdarker  = 234

let s:comment   = 61
let s:selection = 239
let s:subtle    = 238

let s:cyan      = 117
let s:green     = 84
let s:orange    = 215
let s:pink      = 212
let s:purple    = 141
let s:red       = 203
let s:yellow    = 228

let s:none      = 'NONE'

" -------------------------------------------------------------- Highlight groups
function! s:h(scope, fg, ...) " bg, attr_list, special
    let l:fg = copy(a:fg)
    let l:bg = get(a:, 1, 'NONE')

    let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
    let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

    let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'ctermfg=' . l:fg,
        \ 'ctermbg=' . l:bg,
        \ 'cterm=' . l:attrs
        \]

    execute join(l:hl_string, ' ')
endfunction

call s:h('DraculaBgLight', s:none, s:bglight)
call s:h('DraculaBgLighter', s:none, s:bglighter)
call s:h('DraculaBgDark', s:none, s:bgdark)
call s:h('DraculaBgDarker', s:none, s:bgdarker)

call s:h('DraculaTabFill', s:bg, s:bglight)
call s:h('DraculaTabSel', s:bg, s:purple)
call s:h('DraculaTab', s:fg, s:bg)
call s:h('DraculaTabEnder', s:fg, s:comment)

call s:h('DraculaStatusModeDefault', s:bglight, s:purple, ['bold'])
call s:h('DraculaStatusModeInsert', s:bglight, s:green, ['bold'])
call s:h('DraculaStatusModeVisual', s:bglight, s:yellow, ['bold'])
call s:h('DraculaStatusFileName', s:fg, s:bglighter)
call s:h('DraculaStatusFileType', s:bglighter, s:comment)

call s:h('DraculaFg', s:fg)
call s:h('DraculaFgUnderline', s:fg, s:none, ['underline'])
call s:h('DraculaFgBold', s:fg, s:none, ['bold'])
call s:h('DraculaFgStrikethrough', s:fg, s:none, ['strikethrough'])

call s:h('DraculaComment', s:comment)
call s:h('DraculaCommentBold', s:comment, s:none, ['bold'])

call s:h('DraculaSelection', s:none, s:selection)

call s:h('DraculaSubtle', s:subtle)

call s:h('DraculaCyan', s:cyan)
call s:h('DraculaCyanItalic', s:cyan, s:none, ['italic'])

call s:h('DraculaGreen', s:green)
call s:h('DraculaGreenBold', s:green, s:none, ['bold'])
call s:h('DraculaGreenItalic', s:green, s:none, ['italic'])
call s:h('DraculaGreenItalicUnderline', s:green, s:none, ['italic', 'underline'])

call s:h('DraculaOrange', s:orange)
call s:h('DraculaOrangeBold', s:orange, s:none, ['bold'])
call s:h('DraculaOrangeItalic', s:orange, s:none, ['italic'])
call s:h('DraculaOrangeBoldItalic', s:orange, s:none, ['bold', 'italic'])
call s:h('DraculaOrangeInverse', s:bg, s:orange)

call s:h('DraculaPink', s:pink)
call s:h('DraculaPinkItalic', s:pink, s:none, ['italic'])

call s:h('DraculaPurple', s:purple)
call s:h('DraculaPurpleBold', s:purple, s:none, ['bold'])
call s:h('DraculaPurpleItalic', s:purple, s:none, ['italic'])

call s:h('DraculaRed', s:red)
call s:h('DraculaRedInverse', s:fg, s:red)

call s:h('DraculaYellow', s:yellow)
call s:h('DraculaYellowItalic', s:yellow, s:none, ['italic'])

call s:h('DraculaError', s:red, s:none, [], s:red)

call s:h('DraculaErrorLine', s:none, s:none, ['undercurl'])
call s:h('DraculaWarnLine', s:none, s:none, ['undercurl'])
call s:h('DraculaInfoLine', s:none, s:none, ['undercurl'])

call s:h('DraculaTodo', s:cyan, s:none, ['bold', 'inverse'])
call s:h('DraculaSearch', s:green, s:none, ['inverse'])
call s:h('DraculaBoundary', s:comment, s:bgdark)
call s:h('DraculaWinSeparator', s:comment, s:bgdark)
call s:h('DraculaLink', s:cyan, s:none, ['underline'])

call s:h('DraculaDiffText', s:bg, s:orange)
call s:h('DraculaInlayHint', s:comment, s:bgdark)

" -------------------------------------------------------------- Bindings
hi! link Constant DraculaPurple
hi! link String DraculaYellow
hi! link Character DraculaPink
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier DraculaFg
hi! link Function DraculaGreen

hi! link Statement DraculaPink
hi! link Conditional DraculaPink
hi! link Repeat DraculaPink
hi! link Label DraculaPink
hi! link Operator DraculaPink
hi! link Keyword DraculaPink
hi! link Exception DraculaPink

hi! link Type DraculaCyanItalic

hi! link Delimiter DraculaFg

" -------------------------------------------------------------- Set colors for different file types
" Vim
hi! link vimAutoCmdSfxList     Type
hi! link vimAutoEventList      Type
hi! link vimEnvVar             Constant
hi! link vimFunction           Function
hi! link vimHiBang             Keyword
hi! link vimOption             Type
hi! link vimSetMod             Keyword
hi! link vimSetSep             Delimiter
hi! link vimUserAttrbCmpltFunc Function
hi! link vimUserFunc           Function


" -------------------------------------------------------------- Set colors for different plugins
" StatusBar/TabLine
hi! link TabLineFill   DraculaTabFill
hi! link TabLineSel    DraculaTabSel
hi! link TabLineNotSel DraculaTab
hi! link TabLineEnd    DraculaTabEnder
