"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File :		 	error23_Vim_Colors.vim
" Date :		 	28-02-2012
" Description :		Vim Colorscheme and Syntax highlighting
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &t_Co != 256 && ! has("gui_running")
	echomsg ""
	echomsg "please set t_Co=256 in your .vimrc"
	echomsg
	finish
endif


set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "error23_Vim_Colors"

hi Normal 					cterm=none						ctermbg=none		ctermfg=50
hi CursorColumn				cterm=reverse					ctermbg=19			ctermfg=green
hi Cursor					cterm=reverse					ctermbg=19			ctermfg=green
hi CursorLine				cterm=none						ctermbg=19			ctermfg=50
hi FoldColumn				cterm=bold						ctermbg=19			ctermfg=50
hi Folded					cterm=underline					ctermbg=19			ctermfg=50
hi Search					cterm=underline,bold			ctermbg=19			ctermfg=50
hi IncSearch				cterm=underline,bold,reverse	ctermbg=none		ctermfg=none
hi NonText					cterm=none						ctermbg=none		ctermfg=161
hi Pmenu					cterm=bold						ctermbg=darkblue	ctermfg=16
hi PmenuSbar				cterm=bold						ctermbg=19			ctermfg=green
hi PmenuSel					cterm=underline,bold,			ctermbg=19			ctermfg=none
hi PmenuThumb				cterm=none						ctermbg=1			ctermfg=green
hi SignColumn				cterm=none						ctermbg=1			ctermfg=green
hi SpecialKey				cterm=none						ctermbg=1			ctermfg=green
hi StatusLine				cterm=bold,italic				ctermbg=19			ctermfg=none
hi StatusLineNC				cterm=bold						ctermbg=darkblue	ctermfg=16
hi TabLine					cterm=bold						ctermbg=1 			ctermfg=green 
hi TabLineFill				cterm=bold						ctermbg=1 			ctermfg=green 
hi VertSplit				cterm=bold						ctermbg=1			ctermfg=16
hi Visual					cterm=inverse					ctermbg=none		ctermfg=none
hi WildMenu					cterm=bold						ctermbg=1			ctermfg=green
hi Title					cterm=underline,bold			ctermbg=none		ctermfg=105
"""""""""""""""""""""""""""""""""""""""""""""""""""SYNTAX"""""""""""""""""""""""""""""""""""""""""""""""""
hi Comment					cterm=bold						ctermbg=none		ctermfg=grey
hi Constant					cterm=bold						ctermbg=none		ctermfg=57
hi ERROR					cterm=bold,underline			ctermbg=none		ctermfg=1
hi ERRORMsg					cterm=bold,underline			ctermbg=none		ctermfg=1
hi identifier				cterm=none						ctermbg=none		ctermfg=green
hi Ignore					cterm=italic					ctermbg=none		ctermfg=darkgrey
hi LineNr					cterm=bold						ctermbg=16			ctermfg=green
hi MatchParen				cterm=bold,reverse,italic		ctermbg=green		ctermfg=19
hi Number					cterm=none						ctermbg=none		ctermfg=lightblue
hi PreProc					cterm=bold,underline			ctermbg=none		ctermfg=91
hi Special					cterm=none						ctermbg=none		ctermfg=1
hi SpecialComment			cterm=none						ctermbg=none		ctermfg=74
hi Delimiter				cterm=none						ctermbg=none		ctermfg=1
hi Statement				cterm=bold						ctermbg=none		ctermfg=green
hi Todo						cterm=bold						ctermbg=none		ctermfg=green
hi String					cterm=none						ctermbg=none		ctermfg=green
hi Type						cterm=none						ctermbg=none		ctermfg=105
hi Character				cterm=bold						ctermbg=none		ctermfg=magenta
hi Function					cterm=bold						ctermbg=none		ctermfg=lightblue
hi StorageClass				cterm=bold						ctermbg=none		ctermfg=blue
hi Operator					cterm=bold						ctermbg=none		ctermfg=74

