" All system-wide defaults are set in $VIMRUN:WTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
"runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
set nocompatible

" Vim5 and later versionsaaa support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set t_Co=256
colorscheme error23_Vim_Colors
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

""""""""""""""""""""""""""""""""""""""""""""""SET""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd                     " Show (partial) command in status line.
set showmatch                   " Show matching brackets.
set ignorecase                  " Do case insensitive matching
set smartcase                   " Do smart case matching
set smartindent                 " Indentation
set incsearch                   " Incremental search
set autowrite                   " Automatically save before commands like :next and :make
set showmode                    " Affiche en bas a droit le mode actif
"set hidden                     " Hide buffers when they are abandoned
set mouse=a                     " Enable mouse usage (all modes)
set number                      " Enable line numbers
set laststatus=2                " Always show status line
set confirm                     " Start dialog when command fails
set ruler                       " Show cursor position all the time
set title                       " Show info in the window title
set titlestring=HTW_VIM_IN:\ %F " Automatically set screen title
set wrapmargin=3                " Break a line
set textwidth=100               " Line leagth above witch to break a line
set tabstop=4                   " Tab spaces
"set expandtab                  " Tab to spaces
set shiftwidth=4                " Shiftwidh
set hid                         " Don't save on buffer change
set hlsearch                    " Highlihgt search
set wildmenu                    " Wildmenu
set magic                       " Regular expressions
set gfn=Monospace\ 10           " Set police
set shell=/bin/bash             " Shell settings
set foldmethod=syntax           " Code folding
set foldlevel=100               " Fold level
set foldcolumn=5                " Fold Marge
set foldnestmax=10              " Max fold level
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
set statusline=%<\CWD:\ %r%{CurDir()}%h%=Line:\ %l\ of\ %L,\ cols:\ %c%V\ (%P)

""""""""""""""""""""""""""""""""""""""""""""""Abreviations""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

:ab /** /*<CR>***********************************************************
:ab **/ ***********************************************************<CR>/

"""""""""""""""""""""""""""""""""""""""""""""map""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

:imap <tab> <c-r>=Smart_TabComplete()<CR>
":nmap <F2> :wa <cr> :TlistClose <cr> :make --silent <cr> :copen <CR> :TlistToggle <CR>
:nmap <F2> :wa <cr> :TlistClose <cr> :make --silent <cr> : copen <CR>
:nmap <F3> :set et\|retab <cr>
:nmap <F4> :set noet\|retab! <cr>
:nmap <F5> :TlistToggle <cr> :cclose <cr>
:nmap <F6> :NERDTreeToggle<cr>
:nmap <F7> :cclose <cr>
:nmap ff :set foldlevel=1 <cr>
:nmap fa :set foldlevel=100 <cr>
:nmap fs za
:nmap ù %
:nmap S :%s/ancien/nouveau/gc
:nmap nj :!srcModel.sh java <CR>
:nmap nd :!srcModel.sh <CR>
:nmap nt :read ~/Modèles/entete <CR> 
:inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
:inoremap <C-@> <C-n>

" Code
":vmap x :s/^/\/\// <cr> :s/fakzejfmlakjezfmkljaemfhazjghajhgljakrg/ <cr>
":vmap X :s/^\/\/// <cr> :s/fjmaekjffmlkjefoomkljaezmfkjamfkjamekfjma/ <cr>

" SQL
" :vmap x :s/^/-- / <cr> :s/fakzejfmlakjezfmkljaemfhazjghajhgljakrg/ <cr>
" :vmap X :s/^-- // <cr> :s/fjmaekjffmlkjefoomkljaezmfkjamfkjamekfjma/ <cr>

" BASH
:vmap x :s/^/# / <cr> :s/fakzejfmlakjezfmkljaemfhazjghajhgljakrg/ <cr>
:vmap X :s/^# // <cr> :s/fjmaekjffmlkjefoomkljaezmfkjamfkjamekfjma/ <cr>

:vmap gs :InsertGetterSetter <cr>
nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>

""""""""""""""""""""""""""""""""""""Fonctions""""""""""""""""""""""""""""""""""""""""

function! CurDir()
    let curdir = substitute(getcwd(), '/home/error23/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


function! Smart_TabComplete()
  let line = getline('.')                         " current line
  
  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

"""""""""""""""""""""""""""""""""""""Paranteses""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map auto complete of (, ", ', [, `
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap {{ {}<esc>i
inoremap { {<esc>o}<esc>O
inoremap ' ''<esc>i
inoremap " ""<esc>i
inoremap < <><esc>i
inoremap ` ``<esc>i
inoremap /* /*  */<esc>hhi

"""""""""""""""""""""""""""""""""""""""""COPE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""TAGLIST""""""""""""""""""""""""""""""""""""""""""""""""""""""

let Tlist_Close_On_Select=0
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_SingleClick=0
let Tlist_Auto_Highliht_Tag=1
let Tlist_Show_One_File=0
let Tlist_File_Fold_Auto_Close=0
let Tlist_Display_Prototype=1
let Tlist_Use_Horiz_Winodow=0
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
source ~/.vim/cscope_maps.vim
source ~/.vim/cppcomplete.vim

"""""""""""""""""""""""""""""""""""""""""""""JAVA-COMPLITION"""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("autocmd")
set omnifunc=javacomplete#Complete
set tags=cppcomplete.tags
set cfu=VjdeCompletionFun0
let g:vjde_lib_path="lib/j2ee.jar:lib/struts.jar:build/classes:cppcomplete.tags:`pwd`:../bin/*/*:*/*/*"
let g:vjde_javadoc_path='/home/error23/Documents/Biblioteka/Programacija/java/doc/api/'
let g:vjde_show_paras=1
let g:vjde_autoload_taglib=1
let g:vjde_show_preview=1
let g:no_plugin_maps=1
endif

"""""""""""""""""""""""""""""""""""""""""""""ECLIM"""""""""""""""""""""""""""""""""""""""""""""""""""""
let EclimJavaCompilerAutoDetect=0

"""""""""""""""""""""""""""""""""""""""""""""MARKDOWN""""""""""""""""""""""""""""""""""""""""""""""""""
let g:instant_markdown_autostart=1

""""""""""""""""""""""""""""""""""""""""""""""FOLDING""""""""""""""""""""""""""""""""""""""""""""""""""
let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

