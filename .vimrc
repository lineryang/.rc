" Author: Corinne Horn (chorn804@gmail.com)
" Description: This file combines basic commands found in
" http://vim.wikia.com/wiki/Example_vimrc, and useful bundles from Vundle.

" Vundle stuff
set nocompatible
filetype off        " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle required!
Bundle 'gmarik/vundle'
filetype plugin indent on

" Bundles
" Bundle 'croaky/vim-colors-github'
Bundle 'altercation/vim-colors-solarized'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'bling/vim-airline'
Bundle 'mileszs/ack.vim'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'git://github.com/davidhalter/jedi-vim'
" Bundle 'derekwyatt/vim-scala'
" Bundle 'w0ng/vim-github-theme'
" Bundle 'Lokaltog/powerline'


" Colors, indents, and line wrap (for now, no macvim...)
set bg=dark
colorscheme solarized-corinne
set tw=80
set formatoptions+=t

" Macvim (GUI vim)
" let g:indent_guides_auto_colors = 0
" let g:indent_guides_start_level = 2
" let g:indent_guides_guide_size = 1
" let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_color_change_percent=3
"
"
" let g:solarized_bold=1
" let g:solarized_italic=1
" let g:solarized_underline=1
"
" if has('gui_macvim')                  " if has('gui_running')
"     " best code font ever
"     set guifont=Source\ Code\ Pro:h12 " ???
"     set transparency=0
"
"     " color scheme
"     colorscheme solarized
"     set bg=light
" else
"     colorscheme solarized
"     set bg=dark
" endif

" Basics
set backspace=indent,eol,start
let mapleader=','                              " set leader to ,
syn on                                         " syntax highlighting
set nu                                         " line numbers
set tabstop=4                                  " size of tab
set softtabstop=4                              " size of spaces-tabs
set shiftwidth=4                               " shift size
set autoindent                                 " indent at same level as previous line
set expandtab                                  " tabs are spaces, not tabs
set scrolloff=3                                " minimum lines to keep above/below cursor
set showmatch                                  " show matching brace when highlighting it
set showcmd                                    " show command in last line of screen
" set formatoptions=rq
set mouse=a                                    " mouse in terminal vim
set nowrap                                     " text doesn't autowrap
set pastetoggle=<F2>
set clipboard=unnamed                          " vim buffer and system clipboard are shared
set t_Co=256                                   " 256 terminal colors
set nospell                                    " no spellcheck
set hidden                                     " lets you open other buffers without saving the current one
set wildmenu                                   " shows list instead of just autocompleting
set wildignore=*.swp,*.bak,*.pyc
set incsearch                                  " find as you search
set hlsearch                                   " highlight search
set ignorecase                                 " ignore search case
set foldmethod=indent                          " fold based on indents in code
set smartcase
"set list
"set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set termencoding=utf-8
set encoding=utf-8
set history=1000
set undolevels=1000
set laststatus=2                               " always show statusbar. useful when using powerline

" Airline configuration
let g:airline#extensions#tabline#enabled = 1

" Centralize backups
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif
set exrc  " allow for external .vimrc files (local)
set secure " disable unsafe commands in them

" Map ,y to [copy to windows clipboard] and ,p to [paste from windows clipboard]
" Allows for copying/pasting between vim instances
" XXX Still needs to be fixed
vmap <Leader>y y:new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/reg.txt<CR>
nmap <Leader>y :new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/reg.txt<CR>
map <Leader>p :sview ~/reg.txt<CR>"zdddG:q!<CR>:call setreg('"', @", @z)<CR>p

" Map ,cc to compile latex file, and ,co to compile latex file and open
nmap <Leader>cc :!pdflatex %<CR><CR>
nmap <Leader>co :!pdflatex %<CR><CR> :!open %:r.pdf<CR><CR>

" Map ,cm to commenting blocks of comments (dependent on file type).
" Map ,xm to removing blocks of comments
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
vmap <Leader>cm :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
vmap <Leader>xm :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>


" environment expansions for latex (only works on .tex files)
" bal[space, enter, comma] write the wrappers for align
" bfig[space, enter, comma] write the wrappers for a figure
autocmd BufNewFile,BufRead *.tex :ab bal \begin{align*}<CR>\end{align*}
autocmd BufNewFile,BufRead *.tex :ab bfig \begin{figure}[htb!]<CR>\centering<CR>\includegraphics[width=5in]{}<CR>\caption{}<CR>\end{figure}
" This one is specialized for me
autocmd BufNewFile,BufRead *.tex :ab bpap \documentclass[12pt]{article}<CR>\usepackage{fullpage,graphicx,psfrag,url,amsmath}<CR>\input defs<CR><CR>\title{}<CR>\author{Corinne Horn}<CR>\date{\today}<CR>\bibliographystyle{alpha}<CR><CR>\begin{document}<CR>\maketitle<CR><CR>\end{document}
autocmd BufNewFile,BufRead *.tex :ab bdoc \documentclass[12pt]{article}<CR>\usepackage{fullpage,graphicx,psfrag,url,amsmath}<CR><CR>\begin{document}<CR><CR>\end{document}
autocmd BufNewFile,BufRead *.tex :ab btab \begin{table}<CR>\centering<CR>\begin{tabular}{}<CR><CR><CR>\end{tabular}<CR>\caption{}<CR>\end{table}

" More complicated VIM settings...

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" fast buffer switching
nnoremap <leader>n :bn<CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" code folding shortcuts

" noh more easily
nnoremap <leader><space> :noh<cr>

" Tabularize
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
nmap <Leader>a" :Tabularize /"<CR>
vmap <Leader>a" :Tabularize /"<CR>
nmap <Leader>a/ :Tabularize //<CR>
vmap <Leader>a/ :Tabularize //<CR>
nmap <Leader>a[ :Tabularize /[<CR>
vmap <Leader>a[ :Tabularize /[<CR>
nmap <Leader>a] :Tabularize /]<CR>
vmap <Leader>a] :Tabularize /]<CR>
nmap <Leader>a% :Tabularize /%<CR>
nmap <Leader>a% :Tabularize /%<CR>
vmap <Leader>a; :Tabularize /;<CR>
vmap <Leader>a; :Tabularize /;<CR>
