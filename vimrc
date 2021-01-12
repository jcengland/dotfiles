set nocompatible
call plug#begin('~/.vim/plugged')

" tpope plugins 
Plug 'tpope/vim-fugitive' " Vim git integration 
Plug 'tpope/vim-vinegar'  " Ease of use with Netrw 
Plug 'tpope/vim-surround' " Help with surrounding things 
Plug 'tpope/vim-unimpaired' " Lots of toggles for things 
Plug 'tpope/vim-repeat'     " Allow vim repeat to work with other things 
Plug 'tpope/vim-markdown'   " Might not need this 
Plug 'tpope/vim-commentary' " easy code commenting

Plug 'morhetz/gruvbox'      " colorscheme 
Plug 'scrooloose/syntastic' " static analysis/linting
Plug 'mhinz/vim-signify'    " show changes to a file in the gutter 
Plug 'godlygeek/tabular'    " aligning tool
Plug 'honza/vim-snippets' " collection of snippets 
Plug 'nelstrom/vim-markdown-folding'  " folding rules for markdown 
Plug 'jcengland/vim-git-session'      " save vim session for branches 
Plug 'junegunn/fzf.vim'               " fzf fuzzy finder 
Plug 'junegunn/fzf', { 'do': './install --bin' }  "install for fzf 
Plug 'rodjek/vim-puppet'          " puppet plugin 
Plug 'SirVer/ultisnips'           " snippet engine
Plug 'ervandew/supertab'          " Supertab completion
Plug 'dhruvasagar/vim-table-mode' " Table mode
Plug 'Yggdroot/indentLine'        " Show lines for indention
Plug 'vimwiki/vimwiki'            " Personal Wiki
Plug 'mattn/calendar-vim'         " Calendar works with vim wiki
Plug 'davidhalter/jedi-vim'       " Python help
Plug 'mbbill/undotree'            " Tracking undo


call plug#end()

" Install Plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

colorscheme gruvbox
syn on

set relativenumber
set number
set splitbelow
set splitright
set hidden
set tabstop=2
set shiftwidth=2
set expandtab
set path+=**
set wildmenu
set wildmode=list:full
set bg=dark

" Status line
set statusline=%f\ -\ FileType:\ %y
set statusline+=%{fugitive#statusline()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set laststatus=2

set tags=./tags;


" Syntatsic Settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_puppet_checkers=['puppetlint', 'puppet-lint']
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_sh_checkers = ['shellcheck', 'sh']
let g:syntastic_puppet_puppetlint_args='--no-80chars-check'
let g:syntastic_yaml_yamllint_args='-d "{rules: {line-length: disable}}"'
let g:syntastic_loc_list_height=3

" Shellcheck Options
let $SHELLCHECK_OPTS='-e SC1090'

" Let leader
let mapleader=" "

" Remap jk in insert mode to escape
inoremap jk <esc>
" Yank to the end of the line
nnoremap Y y$

" Turn off the arrow keys in normal mode
nnoremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Use control direction keys to switch between pane/splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Leader Commands
" splits and vertical splits
nnoremap <leader>v <ESC>:vs<CR>
nnoremap <leader>s <ESC>:sp<CR>
nnoremap <leader>o <ESC>:only<CR>
" Zoom commands
nnoremap <leader>z <C-w>\|<C-w>_
nnoremap <leader>u <C-w>=
" Open and close quickfixlist
nnoremap <leader>c <ESC>:copen<CR>
nnoremap <leader><leader>c <ESC>:cclose<CR>
" Poor mans buffer menu
"nnoremap <leader>b :buffers<CR>:buffer<Space>

" fzf shortcuts
nnoremap <leader>b :Buffer<CR>
nnoremap <leader>g :Gfiles<CR>

" search and command buffers
noremap <leader>C q:
nnoremap <leader>: q:
nnoremap <leader>S q/

" quiting and saving
nnoremap <leader>q :q<cr>
nnoremap <leader>Z :wq<cr>
nnoremap <leader>w :w<cr>

" TableMode 
nnoremap <leader>T :TableModeToggle<CR>

" Fugitive leaders
nnoremap <leader>gw <ESC>:Gwrite<CR>
nnoremap <leader>gc <ESC>:Gcommit<CR>
nnoremap <leader>gp <ESC>:Gpush<CR>
nnoremap <leader>gb <EsC>:Gblame<CR>
nnoremap <leader>gg <ESC>:Ggrep 
nnoremap <leader>gs <ESC>:G<CR>  

" Split resizing with arrows
nnoremap <Up> <ESC>:res +5<CR>
noremap <Down> <ESC>:res -5<CR> 
noremap <Left> <ESC>:vert res +5<CR>
noremap <Right> <ESC>:vert res -5<CR>

" vim git session
command Gss call SaveCurrentSession()
command Gos call OpenCurrentSession()

" fzf settings
set rtp+=~/.fzf

let g:indentLine_enabled = 0

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

let g:table_mode_corner='|'

