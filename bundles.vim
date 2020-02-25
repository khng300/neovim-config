" Environment {

" Basics
set nocompatible        " Must be first line
set background=dark     " Assume a dark background

" Setup Plugin Support
" The next three lines ensure that the ~/.vim/bundle/ system works
filetype off
let g:home_path=$HOME . '/.config/nvim/config'
let g:plugin_path=g:home_path . '/bundles'
exec 'source' . ' ' . g:home_path . '/vim-plug/plug.vim'

" }

" Plugins {

" Begin plugins listing
call plug#begin(g:plugin_path)

" Deps
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
if executable('ag')
        Plug 'mileszs/ack.vim'
        let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
elseif executable('ack-grep')
        let g:ackprg="ack-grep -H --nocolor --nogroup --column"
        Plug 'mileszs/ack.vim'
elseif executable('ack')
        Plug 'mileszs/ack.vim'
endif

" General
Plug 'altercation/vim-colors-solarized'
Plug 'spf13/vim-colors'
Plug 'tpope/vim-surround'
Plug 'spf13/vim-autoclose'

Plug 'vim-scripts/sessionman.vim'
Plug 'tmhedberg/matchit'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'bling/vim-bufferline'
Plug 'flazz/vim-colorschemes'
Plug 'mbbill/undotree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/restore_view.vim'
"Plug 'mhinz/vim-signify'
Plug 'osyo-manga/vim-over'
Plug 'gcmt/wildfire.vim'

" General Programming
Plug 'tpope/vim-fugitive'
Plug 'mattn/gist-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'

" LSP
Plug 'natebosch/vim-lsc'

" Misc
Plug 'tpope/vim-markdown'
Plug 'spf13/vim-preview'

" End plugins listing
filetype plugin on
call plug#end()

" }
