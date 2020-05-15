" Global environment variable. {
let s:user_config_dir = stdpath("config")
let s:user_cache_dir = stdpath("cache")
" }

" Load plugin manager. {
call execute('source ' . substitute(s:user_config_dir . "/bundles.vim", " ", "\\\\ ", "g"))
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
" }

" Start of custom setting {
" Initialize directories we may need
call init#init_cache_directory()

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
color molokai
if has('termguicolors')
    set termguicolors
endif

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
nmap <leader>sl :SessionList<CR>
nmap <leader>ss :SessionSave<CR>
nmap <leader>sc :SessionClose<CR>

" Powerline
"let g:airline_powerline_fonts = 1
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='solarized'

" vim-lsc
let g:lsc_server_commands = {}
if executable($HOME . '/Workspace/llvm-project/9.x-index-db/build-release/bin/clangd')
    let clangdval = {
                \ 'command': $HOME . '/Workspace/llvm-project/9.x-index-db/build-release/bin/clangd --background-index -j=2',
                \ 'message_hooks': {
                \     'initialize': {
                \     },
                \     'textDocument/didOpen': {'metadata': {'extraFlags': ['-Wall']}},
                \ },
                \ 'suppress_stderr': v:true,
    \ }
    let g:lsc_server_commands['c'] = clangdval
    let g:lsc_server_commands['cpp'] = clangdval
endif
set omnifunc=lsc#complete#complete
let g:lsc_auto_map = {'defaults': v:true, 'Completion': 'omnifunc'}
""nmap <Leader>ld <plug>(lsp-definition)
""nmap <leader>lD <plug>(lsp-document-diagnostics)
""nmap <leader>lf <plug>(lsp-document-format)
""vmap <leader>lf <plug>(lsp-document-format)
""nmap <leader>lh <plug>(lsp-hover)
""nmap <leader>lpe <plug>(lsp-previous-error)
""nmap <leader>lne <plug>(lsp-next-error)
""nmap <leader>lpr <plug>(lsp-previous-references)
""nmap <leader>lnr <plug>(lsp-next-references)
""nmap <leader>lPd <plug>(lsp-peek-declaration)
""nmap <Leader>lr <plug>(lsp-references)
""nmap <leader>l, <plug>(lsp-rename)
""nmap <leader>ls <plug>(lsp-status)
""nmap <leader>lw <plug>(lsp-workspace-symbol)
""let g:lsp_virtual_text_enabled = 0
""let g:lsp_virtual_text_prefix = "> "
""let g:asyncomplete_auto_popup = 0
""imap <c-space> <Plug>(asyncomplete_force_refresh)
""let g:lsp_signs_enabled = 1         " enable signs
""let g:lsp_signs_error = {'text': '✗'}
""let g:lsp_signs_warning = {'text': '!'}

" }
