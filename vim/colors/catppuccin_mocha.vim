" https://github.com/catppuccin/vim/blob/main/colors/catppuccin_mocha.vim
" Name: catppuccin_mocha.vim

set background=dark
hi clear

if exists('syntax on')
    syntax reset
endif

let g:colors_name='catppuccin_mocha'
set t_Co=256

let s:rosewater = "#F5E0DC"
let s:rosewater_cterm = 224

let s:flamingo = "#F2CDCD"
let s:flamingo_cterm = 217

let s:pink = "#F5C2E7"
let s:pink_cterm = 219

let s:mauve = "#CBA6F7"
let s:mauve_cterm = 183

let s:red = "#F38BA8"
let s:red_cterm = 211

let s:maroon = "#EBA0AC"
let s:maroon_cterm = 210

let s:peach = "#FAB387"
let s:peach_cterm = 215

let s:yellow = "#F9E2AF"
let s:yellow_cterm = 223

let s:green = "#A6E3A1"
let s:green_cterm = 114

let s:teal = "#94E2D5"
let s:teal_cterm = 117

let s:sky = "#89DCEB"
let s:sky_cterm = 117

let s:sapphire = "#74C7EC"
let s:sapphire_cterm = 81

let s:blue = "#89B4FA"
let s:blue_cterm = 117

let s:lavender = "#B4BEFE"
let s:lavender_cterm = 147

let s:text = "#CDD6F4"
let s:text_cterm = 189

let s:subtext1 = "#BAC2DE"
let s:subtext1_cterm = 146

let s:subtext0 = "#A6ADC8"
let s:subtext0_cterm = 145

let s:overlay2 = "#9399B2"
let s:overlay2_cterm = 103

let s:overlay1 = "#7F849C"
let s:overlay1_cterm = 60

let s:overlay0 = "#6C7086"
let s:overlay0_cterm = 59

let s:surface2 = "#585B70"
let s:surface2_cterm = 238

let s:surface1 = "#45475A"
let s:surface1_cterm = 237

let s:surface0 = "#313244"
let s:surface0_cterm = 236

let s:base = "#1E1E2E"
let s:base_cterm = 234

let s:mantle = "#181825"
let s:mantle_cterm = 233

let s:crust = "#11111B"
let s:crust_cterm = 232

function! s:hi(group, guisp, guifg, guibg, ctermfg, ctermbg, gui, cterm)
  let cmd = ""
  if a:guisp != ""
    let cmd = cmd . " guisp=" . a:guisp
  endif
  if a:guifg != ""
    let cmd = cmd . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    let cmd = cmd . " guibg=" . a:guibg
  endif
  if a:ctermfg != ""
    let cmd = cmd . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    let cmd = cmd . " ctermbg=" . a:ctermbg
  endif
  if a:gui != ""
    let cmd = cmd . " gui=" . a:gui
  endif
  if a:cterm != ""
    let cmd = cmd . " cterm=" . a:cterm
  endif
  if cmd != ""
    exec "hi " . a:group . cmd
  endif
endfunction

" Custom Ones to fit my full setup
call s:hi("StatusLine2", "NONE", s:text, s:surface1, s:text_cterm, s:surface1_cterm, "NONE", "NONE")
call s:hi("GitDiffAdd", "NONE", s:green, "NONE", s:green_cterm, "NONE", "NONE", "NONE")
call s:hi("GitDiffChange", "NONE", s:yellow, "NONE", s:yellow_cterm, "NONE", "NONE", "NONE")
call s:hi("GitDiffRemove", "NONE", s:red, "NONE", s:red_cterm, "NONE", "NONE", "NONE")

call s:hi("Normal", "NONE", s:text, s:base, s:text_cterm, s:base_cterm, "NONE", "NONE")
call s:hi("Visual", "NONE", "NONE", s:surface1, "NONE", s:surface1_cterm, "bold", "bold")
call s:hi("Conceal", "NONE", s:overlay1, "NONE", s:overlay1_cterm, "NONE", "NONE", "NONE")
call s:hi("ColorColumn", "NONE", "NONE", s:surface0, "NONE", s:surface0_cterm, "NONE", "NONE")
call s:hi("Cursor", "NONE", s:base, s:rosewater, s:base_cterm, s:rosewater_cterm, "NONE", "NONE")
call s:hi("lCursor", "NONE", s:base, s:rosewater, s:base_cterm, s:rosewater_cterm, "NONE", "NONE")
call s:hi("CursorIM", "NONE", s:base, s:rosewater, s:base_cterm, s:rosewater_cterm, "NONE", "NONE")
call s:hi("CursorColumn", "NONE", "NONE", s:mantle, "NONE", s:mantle_cterm, "NONE", "NONE")
call s:hi("CursorLine", "NONE", "NONE", s:surface0, "NONE", s:surface0_cterm, "NONE", "NONE")
call s:hi("Directory", "NONE", s:blue, "NONE", s:blue_cterm, "NONE", "NONE", "NONE")
call s:hi("DiffAdd", "NONE", s:base, s:green, s:base_cterm, s:green_cterm, "NONE", "NONE")
call s:hi("DiffChange", "NONE", s:base, s:yellow, s:base_cterm, s:yellow_cterm, "NONE", "NONE")
call s:hi("DiffDelete", "NONE", s:base, s:red, s:base_cterm, s:red_cterm, "NONE", "NONE")
call s:hi("DiffText", "NONE", s:base, s:blue, s:base_cterm, s:blue_cterm, "NONE", "NONE")
call s:hi("EndOfBuffer", "NONE", "NONE", "NONE", "NONE", "NONE", "NONE", "NONE")
call s:hi("ErrorMsg", "NONE", s:red, "NONE", s:red_cterm, "NONE", "bolditalic"    , "bold,italic")
call s:hi("VertSplit", "NONE", s:crust, "NONE", s:crust_cterm, "NONE", "NONE", "NONE")
call s:hi("Folded", "NONE", s:blue, s:surface1, s:blue_cterm, s:surface1_cterm, "NONE", "NONE")
call s:hi("FoldColumn", "NONE", s:overlay0, s:base, s:overlay0_cterm, s:base_cterm, "NONE", "NONE")
call s:hi("SignColumn", "NONE", s:surface1, s:base, s:surface1_cterm, s:base_cterm, "NONE", "NONE")
call s:hi("IncSearch", "NONE", s:surface1, s:pink, s:surface1_cterm, s:pink_cterm, "NONE", "NONE")
call s:hi("CursorLineNR", "NONE", s:lavender, "NONE", s:lavender_cterm, "NONE", "NONE", "NONE")
call s:hi("LineNr", "NONE", s:surface1, "NONE", s:surface1_cterm, "NONE", "NONE", "NONE")
call s:hi("MatchParen", "NONE", s:peach, "NONE", s:peach_cterm, "NONE", "bold", "bold")
call s:hi("ModeMsg", "NONE", s:text, "NONE", s:text_cterm, "NONE", "bold", "bold")
call s:hi("MoreMsg", "NONE", s:blue, "NONE", s:blue_cterm, "NONE", "NONE", "NONE")
call s:hi("NonText", "NONE", s:overlay0, "NONE", s:overlay0_cterm, "NONE", "NONE", "NONE")
call s:hi("Pmenu", "NONE", s:overlay2, s:surface0, s:overlay2_cterm, s:surface0_cterm, "NONE", "NONE")
call s:hi("PmenuSel", "NONE", s:text, s:surface1, s:text_cterm, s:surface1_cterm, "bold", "bold")
call s:hi("PmenuSbar", "NONE", "NONE", s:surface1, "NONE", s:surface1_cterm, "NONE", "NONE")
call s:hi("PmenuThumb", "NONE", "NONE", s:overlay0, "NONE", s:overlay0_cterm, "NONE", "NONE")
call s:hi("Question", "NONE", s:blue, "NONE", s:blue_cterm, "NONE", "NONE", "NONE")
call s:hi("QuickFixLine", "NONE", "NONE", s:surface1, "NONE", s:surface1_cterm, "bold", "bold")
call s:hi("Search", "NONE", s:pink, s:surface1, s:pink_cterm, s:surface1_cterm, "bold", "bold")
call s:hi("SpecialKey", "NONE", s:subtext0, "NONE", s:subtext0_cterm, "NONE", "NONE", "NONE")
call s:hi("SpellBad", "NONE", s:base, s:red, s:base_cterm, s:red_cterm, "NONE", "NONE")
call s:hi("SpellCap", "NONE", s:base, s:yellow, s:base_cterm, s:yellow_cterm, "NONE", "NONE")
call s:hi("SpellLocal", "NONE", s:base, s:blue, s:base_cterm, s:blue_cterm, "NONE", "NONE")
call s:hi("SpellRare", "NONE", s:base, s:green, s:base_cterm, s:green_cterm, "NONE", "NONE")
call s:hi("StatusLine", "NONE", s:text, s:mantle, s:text_cterm, s:mantle_cterm, "NONE", "NONE")
call s:hi("StatusLineNC", "NONE", s:surface1, s:mantle, s:surface1_cterm, s:mantle_cterm, "NONE", "NONE")
call s:hi("StatusLineTerm", "NONE", s:text, s:mantle, s:text_cterm, s:mantle_cterm, "NONE", "NONE")
call s:hi("StatusLineTermNC", "NONE", s:surface1, s:mantle, s:surface1_cterm, s:mantle_cterm, "NONE", "NONE")
call s:hi("TabLine", "NONE", s:surface1, s:mantle, s:surface1_cterm, s:mantle_cterm, "NONE", "NONE")
call s:hi("TabLineFill", "NONE", "NONE", s:mantle, "NONE", s:mantle_cterm, "NONE", "NONE")
call s:hi("TabLineSel", "NONE", s:green, s:surface1, s:green_cterm, s:surface1_cterm, "NONE", "NONE")
call s:hi("Title", "NONE", s:blue, "NONE", s:blue_cterm, "NONE", "bold", "bold")
call s:hi("VisualNOS", "NONE", "NONE", s:surface1, "NONE", s:surface1_cterm, "bold", "bold")
call s:hi("WarningMsg", "NONE", s:yellow, "NONE", s:yellow_cterm, "NONE", "NONE", "NONE")
call s:hi("WildMenu", "NONE", "NONE", s:overlay0, "NONE", s:overlay0_cterm, "NONE", "NONE")
call s:hi("Comment", "NONE", s:overlay0, "NONE", s:overlay0_cterm, "NONE", "NONE", "NONE")
call s:hi("Constant", "NONE", s:peach, "NONE", s:peach_cterm, "NONE", "NONE", "NONE")
call s:hi("Identifier", "NONE", s:flamingo, "NONE", s:flamingo_cterm, "NONE", "NONE", "NONE")
call s:hi("Statement", "NONE", s:mauve, "NONE", s:mauve_cterm, "NONE", "NONE", "NONE")
call s:hi("PreProc", "NONE", s:pink, "NONE", s:pink_cterm, "NONE", "NONE", "NONE")
call s:hi("Type", "NONE", s:blue, "NONE", s:blue_cterm, "NONE", "NONE", "NONE")
call s:hi("Special", "NONE", s:pink, "NONE", s:pink_cterm, "NONE", "NONE", "NONE")
call s:hi("Underlined", "NONE", s:text, s:base, s:text_cterm, s:base_cterm, "underline", "underline")
call s:hi("Error", "NONE", s:red, "NONE", s:red_cterm, "NONE", "NONE", "NONE")
call s:hi("Todo", "NONE", s:base, s:flamingo, s:base_cterm, s:flamingo_cterm, "bold", "bold")

call s:hi("String", "NONE", s:green, "NONE", s:green_cterm, "NONE", "NONE", "NONE")
call s:hi("Character", "NONE", s:teal, "NONE", s:teal_cterm, "NONE", "NONE", "NONE")
call s:hi("Number", "NONE", s:peach, "NONE", s:peach_cterm, "NONE", "NONE", "NONE")
call s:hi("Boolean", "NONE", s:peach, "NONE", s:peach_cterm, "NONE", "NONE", "NONE")
call s:hi("Float", "NONE", s:peach, "NONE", s:peach_cterm, "NONE", "NONE", "NONE")
call s:hi("Function", "NONE", s:blue, "NONE", s:blue_cterm, "NONE", "NONE", "NONE")
call s:hi("Conditional", "NONE", s:red, "NONE", s:red_cterm, "NONE", "NONE", "NONE")
call s:hi("Repeat", "NONE", s:red, "NONE", s:red_cterm, "NONE", "NONE", "NONE")
call s:hi("Label", "NONE", s:peach, "NONE", s:peach_cterm, "NONE", "NONE", "NONE")
call s:hi("Operator", "NONE", s:sky, "NONE", s:sky_cterm, "NONE", "NONE", "NONE")
call s:hi("Keyword", "NONE", s:pink, "NONE", s:pink_cterm, "NONE", "NONE", "NONE")
call s:hi("Include", "NONE", s:pink, "NONE", s:pink_cterm, "NONE", "NONE", "NONE")
call s:hi("StorageClass", "NONE", s:yellow, "NONE", s:yellow_cterm, "NONE", "NONE", "NONE")
call s:hi("Structure", "NONE", s:yellow, "NONE", s:yellow_cterm, "NONE", "NONE", "NONE")
call s:hi("Typedef", "NONE", s:yellow, "NONE", s:yellow_cterm, "NONE", "NONE", "NONE")
call s:hi("debugPC", "NONE", "NONE", s:crust, "NONE", s:crust_cterm, "NONE", "NONE")
call s:hi("debugBreakpoint", "NONE", s:overlay0, s:base, s:overlay0_cterm, s:base_cterm, "NONE", "NONE")

hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link SpecialChar Special
hi link Tag Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special
hi link Exception Error
hi link StatusLineTerm StatusLine
hi link StatusLineTermNC StatusLineNC
hi link Terminal Normal
hi link Ignore Comment

" Set terminal colors for playing well with plugins like fzf
let g:terminal_ansi_colors = [
  \ s:surface1, s:red, s:green, s:yellow, s:blue, s:pink, s:teal, s:subtext1,
  \ s:surface2, s:red, s:green, s:yellow, s:blue, s:pink, s:teal, s:subtext0
\ ]
