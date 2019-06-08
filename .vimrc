set nocompatible
filetype off

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'leafgarland/typescript-vim'
Plug 'sickill/vim-monokai/'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/limelight.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ervandew/supertab'
call plug#end()


if has('gui_running')
    set guifont=Meslo\ LG\ S\ DZ\ Regular\ for\ Powerline
endif

set term=xterm-256color
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set backspace=2
set number
syntax enable
colorscheme monokai

"Configure indents
autocmd Filetype javascript,html,css,smarty setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype php setlocal ts=4 sts=4 sw=4 expandtab omnifunc=phpcomplete_extended#CompletePHP
autocmd Filetype c,c++,java setlocal ts=4 sts=4 sw=4 expandtab

"Autocomplete options
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"Indent lines settings
let g:indent_guides_auto_colors=0
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
hi IndentGuidesEven ctermbg=238
hi IndentGuidesOdd ctermbg=236

"Multi cursor settings
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
filetype plugin indent on

" powerline
set rtp+=/usr/local/lib/python3.6/site-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256

"Custom mappings
map <C-n> :NERDTreeToggle<CR>
map <C-o> :NERDTree %<CR>
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>
map q :q<CR>
map W :w<CR>
map <F4> mzgg=G`z

