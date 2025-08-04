" Code adapted from https://github.com/dracula/vim
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

call s:h('DraculaTabLineFill', s:bg, s:bglight)
call s:h('DraculaTabLineSel', s:bg, s:purple)
call s:h('DraculaTabLineNotSel', s:fg, s:bg)
call s:h('DraculaTabLineEnd', s:fg, s:comment)

call s:h('DraculaStatusModeDefault', s:bglight, s:purple, ['bold'])
call s:h('DraculaStatusModeInsert', s:bglight, s:green, ['bold'])
call s:h('DraculaStatusModeVisual', s:bglight, s:yellow, ['bold'])
call s:h('DraculaStatusGitBranch', s:fg, s:comment)
call s:h('DraculaStatusFileName', s:fg, s:bglighter)
call s:h('DraculaStatusFileType', s:fg, s:comment)



call s:h('DraculaBgLight', s:none, s:bglight)
call s:h('DraculaBgLighter', s:none, s:bglighter)
call s:h('DraculaBgDark', s:none, s:bgdark)
call s:h('DraculaBgDarker', s:none, s:bgdarker)

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
call s:h('Normal', s:fg, s:none)
call s:h('StatusLine', s:none, s:bglighter, ['bold'])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('StatusLineTerm', s:none, s:bglighter, ['bold'])
call s:h('StatusLineTermNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, ['bold'])
call s:h('CursorLine', s:none, s:subtle)

hi! link ColorColumn  DraculaBgDark
hi! link CursorColumn CursorLine
hi! link CursorLineNr DraculaYellow
hi! link DiffAdd      DraculaGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   DraculaDiffChange
hi! link DiffDelete   DraculaDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     DraculaDiffText
hi! link Directory    DraculaPurpleBold
hi! link ErrorMsg     DraculaRedInverse
hi! link FoldColumn   DraculaSubtle
hi! link Folded       DraculaBoundary
hi! link IncSearch    DraculaOrangeInverse
call s:h('LineNr', s:comment)
hi! link MoreMsg      DraculaFgBold
hi! link NonText      DraculaSubtle
hi! link Pmenu        DraculaBgDark
hi! link PmenuSbar    DraculaBgDark
hi! link PmenuSel     DraculaSelection
hi! link PmenuThumb   DraculaSelection
call s:h('PmenuMatch', s:cyan, s:bgdark)
call s:h('PmenuMatchSel', s:cyan, s:selection)
hi! link Question     DraculaFgBold
hi! link Search       DraculaSearch
call s:h('SignColumn', s:comment)
hi! link TabLine      DraculaBoundary
hi! link TabLineFill  DraculaBgDark
hi! link TabLineSel   Normal
hi! link Title        DraculaGreenBold
hi! link VertSplit    DraculaWinSeparator
hi! link Visual       DraculaSelection
hi! link VisualNOS    Visual
hi! link WarningMsg   DraculaOrangeInverse

call s:h('MatchParen', s:green, s:none, ['underline'])
call s:h('Conceal', s:cyan, s:none)

hi! link Comment DraculaComment
hi! link Underlined DraculaFgUnderline
hi! link Todo DraculaTodo

hi! link Error DraculaError
hi! link SpellBad DraculaErrorLine
hi! link SpellLocal DraculaWarnLine
hi! link SpellCap DraculaInfoLine
hi! link SpellRare DraculaInfoLine

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

hi! link PreProc DraculaPink
hi! link Include DraculaPink
hi! link Define DraculaPink
hi! link Macro DraculaPink
hi! link PreCondit DraculaPink
hi! link StorageClass DraculaPink
hi! link Structure DraculaPink
hi! link Typedef DraculaPink

hi! link Type DraculaCyanItalic

hi! link Delimiter DraculaFg

hi! link Special DraculaPink
hi! link SpecialComment DraculaCyanItalic
hi! link Tag DraculaCyan
hi! link helpHyperTextJump DraculaLink
hi! link helpCommand DraculaPurple
hi! link helpExample DraculaGreen
hi! link helpBacktick Special


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

" JSON
hi! link jsonKeyword      DraculaCyan
hi! link jsonKeywordMatch DraculaPink

" Python
hi! link pythonBuiltinObj    Type
hi! link pythonBuiltinObject Type
hi! link pythonBuiltinType   Type
hi! link pythonClassVar      DraculaPurpleItalic
hi! link pythonExClass       Type
hi! link pythonNone          Type
hi! link pythonRun           Comment

" Yaml
hi! link yamlAlias           DraculaGreenItalicUnderline
hi! link yamlAnchor          DraculaPinkItalic
hi! link yamlBlockMappingKey DraculaCyan
hi! link yamlFlowCollection  DraculaPink
hi! link yamlFlowIndicator   Delimiter
hi! link yamlNodeTag         DraculaPink
hi! link yamlPlainScalar     DraculaYellow

" -------------------------------------------------------------- Set colors for different plugins
