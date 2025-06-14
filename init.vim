" Global environment variable. {
let s:user_config_dir = stdpath("config")
let s:user_cache_dir = stdpath("cache")
" }

" Warning echo helper {
function! s:print_warning(msg)
    echohl WarningMsg
    echo "Warning: " . a:msg
    echohl None
endfunction
" }

" Initialize Directories {
function! init#init_cache_directory()
    let tmpfiles_dir = s:user_cache_dir . '/tmpfiles'
    if !isdirectory(tmpfiles_dir)
        call mkdir(tmpfiles_dir, "p")
    endif

    " Set up netrw_home
    let l:netrw_home = tmpfiles_dir  . '/netrw_home'
    if !isdirectory(l:netrw_home)
        call mkdir(l:netrw_home)
    endif
    let g:netrw_home = l:netrw_home

    let dir_list = {
                \ 'backupdir': 'backup',
                \ 'viewdir': 'views',
                \ 'directory': 'swap',
                \ 'undodir': 'undo',
                \ }
    for [settingname, dirname] in items(dir_list)
        let directory = tmpfiles_dir . '/' . dirname
        if !isdirectory(directory)
            call mkdir(directory)
        endif
        if !isdirectory(directory)
            call s:print_warning("Unable to create backup directory: " . directory)
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            call execute("set " . settingname . "=" . directory)
        endif
    endfor
endfunction

" Initialize directories we may need
call init#init_cache_directory()

" }

" Start of plugin manager section {
packadd minpac

function! PackInit() abort
    " Themes
    call minpac#add('arzg/vim-corvine')
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('vim-airline/vim-airline-themes')

    " General
    call minpac#add('tpope/vim-surround')
    call minpac#add('tmhedberg/matchit')
    call minpac#add('mbbill/undotree')
    call minpac#add('nathanaelkane/vim-indent-guides')
    call minpac#add('osyo-manga/vim-over')
    call minpac#add('gcmt/wildfire.vim')
    call minpac#add('vim-scripts/restore_view.vim')

    " General Programming
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('mattn/gist-vim')
    call minpac#add('scrooloose/nerdcommenter')
    call minpac#add('godlygeek/tabular')

    " LSP
    call minpac#add('prabirshrestha/vim-lsp')
    call minpac#add('prabirshrestha/asyncomplete.vim')
    call minpac#add('prabirshrestha/asyncomplete-lsp.vim')

    " Misc
    call minpac#add('tpope/vim-markdown')
    call minpac#add('spf13/vim-preview')
endfunction

if !exists('g:loaded_minpac')
    finish
endif

" Define user commands for updating/cleaning the plugins.
command! PackUpdate call minpac#update()
command! PackClean  call minpac#clean()
command! PackStatus call minpac#status()
command! ConfigReload source $MYVIMRC

call minpac#init()
call PackInit()

if empty(minpac#getpluglist())
    finish
endif

" }

" Start of custom setting {

" Backspace
set backspace=2

" Use mouse
set mouse=a

" Set leader key
let mapleader = '\'

" Numberline option
set nu
set relativenumber

" Syntax
syntax on

" Coloring
nnoremap <Leader>c :set cursorline!<CR>
if has('termguicolors')
    set termguicolors
endif
set background=light     " Assume a light background
color corvine_light

" hi-lighter
set cursorline
set incsearch
nmap <silent> <leader>/ :nohlsearch<CR>

" GUI options setting
if has('gui_running')
    set guioptions-=T "remove toolbar
    " :set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
endif

" statusline setting
if has('statusline')
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    set laststatus=2
endif

" Search options
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present

" Ruler
set ruler        " show the cursor position all the time
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
set showcmd                 " Show partial commands in status line and

" Key mapping

" Setting up the directories
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

" Format
set noexpandtab
set cindent
set autoindent
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set list

set tabstop=8
set shiftwidth=8

" Session List
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize

" Powerline
"let g:airline_powerline_fonts = 1
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='solarized'

" vim-lsp2
"let s:ccls_lsppath = $HOME . '/my-install/ccls/bin/ccls'
"let s:ccls_init_options = {}
"if executable(s:ccls_lsppath)
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'ccls',
"        \ 'cmd': {server_info->[s:ccls_lsppath]},
"        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
"        \ 'initialization_options': s:ccls_init_options,
"        \ })
"endif
" vim-lsp
let s:clangd_lsppath = '/opt/utils/local/llvm20/bin/clangd'
"let s:clangd_lsppath = '/usr/local/bin/clangd20'
let s:clangd_init_options = {}
if executable(s:clangd_lsppath)
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->[s:clangd_lsppath, '--background-index', '-j=24', '-header-insertion=never']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ 'initialization_options': s:clangd_init_options,
        \ })
endif

let g:lsp_virtual_text_enabled = 0
let g:lsp_signs_enabled = 0
"let g:lsp_signs_error = {'text': '✗'}
"let g:lsp_signs_warning = {'text': '!'}
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal completeopt-=preview
    setlocal keywordprg=:LspHover

    "let g:lsp_log_verbose = 1
    "let g:lsp_log_file = expand('/tmp/lsp.log')

    nmap <buffer> <C-]> <plug>(lsp-definition)
    nmap <buffer> <C-W>] <plug>(lsp-peek-definition)
    nmap <buffer> <C-W><C-]> <plug>(lsp-peek-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> <C-n> <plug>(lsp-next-reference)
    nmap <buffer> <C-p> <plug>(lsp-previous-reference)
    nmap <buffer> gI <plug>(lsp-implementation)
    nmap <buffer> go <plug>(lsp-document-symbol)
    nmap <buffer> gS <plug>(lsp-workspace-symbol)
    nmap <buffer> ga <plug>(lsp-code-action)
    nmap <buffer> gR <plug>(lsp-rename)
    nmap <buffer> gm <plug>(lsp-signature-help)

endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" }
