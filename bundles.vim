" Environment {

" Basics
set nocompatible        " Must be first line
set background=light     " Assume a light background

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

" Themes
Plug 'arzg/vim-corvine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" General
Plug 'tpope/vim-surround'
Plug 'tmhedberg/matchit'
Plug 'mbbill/undotree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'osyo-manga/vim-over'
Plug 'gcmt/wildfire.vim'

" General Programming
Plug 'tpope/vim-fugitive'
Plug 'mattn/gist-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'

" Debugging
Plug 'sakhnik/nvim-gdb'

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Misc
Plug 'tpope/vim-markdown'
Plug 'spf13/vim-preview'

" End plugins listing
filetype plugin on
call plug#end()

" }
