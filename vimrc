""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'https://github.com/croaker/mustang-vim'
Plugin 'snipMate'
Plugin 'SuperTab'
Plugin 'https://github.com/scrooloose/nerdtree'
Plugin 'https://github.com/jistr/vim-nerdtree-tabs'
Plugin 'LaTeX-Suite-aka-Vim-LaTeX'
Plugin 'beloglazov/vim-online-thesaurus'
Plugin 'https://github.com/bfrg/vim-cpp-modern'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default vim options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on
" Show line numbers
set number
" Stop tab after 2 columns
set tabstop=4
" Shift 2 columns when using the indent operations "<<" and ">>"
set shiftwidth=4
" Use spaces instead of tabs
set expandtab
" Set text width to 80 columns
"set textwidth=80
" Automatic indention on newline
set autoindent
" Enable parsing lines at begin and end of file
set modeline
" Parse only two lines
set modelines=2
" Enable ruler (line and column number of the cursor position)
set ruler
" Set shortcut for toggle paste mode
set pastetoggle=<F10>
" Highlight search matches
set hlsearch
" Highlight cursor line
set cursorline
" Add column line at 81
if exists('+colorcolumn')
  set colorcolumn=81
else
  " Fallback if not supported
  hi OverLength cterm=NONE ctermbg=darkred guibg=#FFD9D9
  match OverLength /\%>80v.\+/
endif
" Enable backspace
set bs=2
" Enable spell checking
set spell
" Enable English and German dictionary
set spelllang=en
" Specify file for remembering self defined words
if has('win32') || has ('win64')
  set spellfile=~/vimfiles/spell/self.add
else
  set spellfile=~/.vim/spell/self.add
endif
" Disable spell for certain file types
au FileType diff set nospell
" Unfold everything when open a file
au BufRead * normal zR
" Set color scheme
try
  colorscheme mustang
  set t_Co=265
  " Set highlight colors
  hi CursorLine cterm=NONE ctermbg=236 gui=NONE guibg=#303030
  hi CursorLineNr cterm=bold ctermfg=250 gui=bold guifg=#bcbcbc
  hi ColorColumn cterm=NONE ctermbg=237 gui=NONE guibg=#3a3a3a
  hi OverLength cterm=NONE ctermbg=237 gui=NONE guibg=#3a3a3a
  hi SpellBad cterm=undercurl ctermfg=167 ctermbg=234 gui=undercurl guifg=#d75f5f guibg=#1c1c1c
  hi Folded cterm=NONE ctermbg=237 gui=NONE guibg=#3a3a3a
  hi DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=white
  hi DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black
  hi DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black
  hi DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black
  hi Search cterm=NONE ctermbg=LightRed
catch
  " Do nothing
endtry

" Set GUI size and font
if winwidth(0) < 85
  set columns=85
endif

" Yank with 'yy' and append with 'YY' ('y' and 'Y' in visual mode)
nnoremap yy "xyy
nnoremap YY "Xyy
vnoremap y "xy
vnoremap Y "Xy

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim options for an full featured IDE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map 'jump forward' in jump list to C-P before overwriting Tab
nnoremap <C-P> <Tab>
" Mapping for switching to next window
map <Tab> <C-W><C-W>
" Mapping for switching to previous window
map <S-Tab> <C-W>W
" Open quickfix window as the bottommost one
autocmd! FileType qf wincmd J
" On vim IDE start focus file buffer
autocmd VimEnter * wincmd l
" Set special options for Java
autocmd FileType java call SetupJavaOptions()
function SetupJavaOptions()
  " Indent four four four four spaces
  set tabstop=4
  set shiftwidth=4
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_auto_trigger = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_key_list_select_completion = ['<C-Space>', '<Down>', '<Enter>']
let g:ycm_key_list_previous_completion = ['<C-S-Space>', '<Up>']
let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_clangd_binary_path = trim(system('brew --prefix llvm')).'/bin/clangd'
nnoremap <C-G> :YcmCompleter GoTo<CR>
nnoremap <C-H> :YcmCompleter GoToDeclaration<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SuperTab settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show the same instance of the NERDTree on every tab and find current file
nnoremap <C-N> :NERDTreeTabsToggle<CR>:wincmd l<CR>:NERDTreeTabsFind<CR>
" Hide information text "Press ? for help"
let g:NERDTreeMinimalUI = 1
" Use simple characters instead of arrows
let g:NERDTreeDirArrows = 1
" Do not open NERDTree on startup in GVim
let g:nerdtree_tabs_open_on_gui_startup = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-LaTeX settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REQUIRED. This makes vim invoke Latex-Suite when you open a TeX file.
filetype plugin on
" IMPORTANT: win32 users will need to have 'shellslash' set so that LaTeX
" can be called correctly.
set shellslash
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" OPTIONAL: This enables automatic indentation as you type.
filetype indent on
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
" Enable pdf target
let g:Tex_DefaultTargetFormat = 'pdf'
" Set compilation command (uses makefile if there is one in current directory
" otherwise it calls pdflatex and it does makeindex/bibtex if neccessary)
let g:Tex_CompileRule_pdf = 'if [ -f Makefile ]; then make; else pdflatex --interaction=nonstopmode --shell-escape $*; if [ -f $*.ist ]; then makeindex -s $*.ist -t $*.glg -o $*.gls $*.glo; makeindex -s $*.ist -t $*.alg -o $*.acr $*.acn; fi; if grep bibdata $*.aux; then bibtex $*; fi; pdflatex --interaction=nonstopmode --shell-escape $*; pdflatex --interaction=nonstopmode --shell-escape $*; fi'
" Disable builtin feature for using makefiles
let g:Tex_UseMakefile = 0
" Use german quotation marks
"let g:Tex_SmartQuoteOpen = "\"`"
"let g:Tex_SmartQuoteClose = "\"'"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove trailing whitespaces
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wrap
set linebreak
" note trailing space at end of next line
set showbreak=>\ \ \
"autocmd FileType tex <buffer> :%s/\s\+$//e
autocmd FileType c,cpp,java,php,tex,pl,cc,cl,py,vhd autocmd BufWritePre <buffer> %s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" esc to work in :term mode 
" http://vimcasts.org/episodes/neovim-terminal-mappings/ 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
tnoremap <Esc> <C-\><C-n>
" put terminal below
set splitbelow

" change size of the terminal
"set termsize=10x0
"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   vim-cpp-modern
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable function highlighting (affects both C and C++ files)
"let g:cpp_no_function_highlight = 1

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
"let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" powerline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=/Users/akifoezkan/Library/Python/3.9/lib/python/site-packages/powerline/bindings/vim
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"key mappings 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" option + right => move word by word
:map f w
