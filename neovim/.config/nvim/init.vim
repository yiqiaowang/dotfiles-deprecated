" ------------------------------------------------------------------------------
" Bootstrap
" ------------------------------------------------------------------------------
" {{{

" Automatically install vim-plug if it does not exist
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------
" {{{
call plug#begin('~/.local/share/nvim/vim-plug')

" cosmetics
Plug 'mhinz/vim-startify'                   " nice startup page
Plug 'Yggdroot/indentline'                  " highlight indent levels
Plug 'danishprakash/vim-yami'
Plug 'yiqiaowang/statusline'                " statusline

" utilites
Plug 'christoomey/vim-tmux-navigator'       " tmux
Plug 'junegunn/fzf', {
	\ 'dir': '~/.fzf',
        \ 'do': './install
        \   --no-fish --no-bash
        \   --64 --key-bindings
        \   --completion
        \   --update-rc'
        \ }                   	            " fuzzyfinder
Plug 'junegunn/fzf.vim'                     " fzf integration
Plug 'justinmk/vim-dirvish'                 " netrw replacement
Plug 'tpope/vim-commentary'                 " comment helper
Plug 'tpope/vim-repeat'                     " repeat plugin maps
Plug 'tpope/vim-surround'                   " quoting/paren etc. helper
Plug 'tpope/vim-unimpaired'                 " bracket mappings
Plug 'simeji/winresizer'                    " resize windows

" language support
Plug 'sheerun/vim-polyglot'                 " language pack
Plug 'liuchengxu/vista.vim'                 " modern tagline
Plug 'neoclide/coc.nvim', {
	\ 'branch': 'release'
	\ } 				    " language server & completion
call plug#end()
" }}}

" ------------------------------------------------------------------------------
" General Key Mappings & Global Configuration
" ------------------------------------------------------------------------------
" {{{

" Leader mappings
let mapleader="\<space>"
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>d :bp\|bd #<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :GFiles<cr>
nnoremap <leader>h :History<cr>
nnoremap <leader>r :Rg<cr>
nnoremap <silent> <leader>w :wa<cr>
nnoremap <silent> <leader>c :noh<cr>
nnoremap <bs> <c-^>
nnoremap <leader>= mfggVG=`fzz

" Make Y more consistent
nnoremap Y y$

" Trim whitespace
nnoremap <silent> <F9> :let _s=@/ <Bar> :%s/\s\+$//e <Bar>
            \ :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Folding
set foldmethod=marker   
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Set pythonx version
set pyxversion=3

" Syntax Highlighting
syntax on

" Line numbers
set number

" Try to show paragraph's last line
set display+=lastline

" Always show sign column
set signcolumn=yes

" Keep lines above and below cursor
set scrolloff=1

" Theme
set termguicolors
colorscheme yami

" Allow multiple unsaved buffers
set hidden

" Natural splits
set splitbelow
set splitright

" Correctly setup tab and space behavior
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" round to nearest multiple of shiftwidth
set shiftround

" Saner line joins
set formatoptions+=j

" Use system clipboard
set clipboard=unnamedplus

" Don't update screen during macro and script execution
set lazyredraw

" Searching stuff
set ignorecase
set smartcase
set incsearch

set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c
" }}}

" ------------------------------------------------------------------------------
" General Key Mappings & Global Configuration
" ------------------------------------------------------------------------------
" {{{

" [PLUGIN] coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>


" [PLUGIN] Indentline
let g:indentLine_char = '▏'

" [PLUGIN] statusline
let g:eleline_powerline_fonts = 1 
let g:statusline_yiqiao = 1

" [PLUGIN] dirvish
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" [PLUGIN] fzf.vim
let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" GFiles command with preview window
command! -bang -nargs=? -complete=dir GFiles
            \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

" Command for git grep
command! -bang -nargs=* GGrep
            \ call fzf#vim#grep(
            \   'git grep --line-number '.shellescape(<q-args>), 0,
            \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
" [PLUGIN] signify
let g:signify_vcs_list = ['git']

" }}}
