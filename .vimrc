" General settings
syntax on
filetype plugin indent on

" Colors
    colorscheme slate
    set background=dark
    
" Environment
    set mouse=a
    set nu
    set relativenumber
    set path+=**
    set noerrorbells
    set autoread
    set spelllang=en_us
    " set spell
    set wildmenu
    set encoding=UTF-8
    set backspace=indent,eol,start  " Make sure backspace works
    set nowrap
    set noswapfile
    set nobackup
    set undodir=~/.cache/vim/undo
    set undofile
    set incsearch
    set noruler
    set confirm
    set smartindent
    set ic
    set fdm=syntax                  " Folding on Syntax

    set colorcolumn=80

    " Popup Menu Theme
    highlight Pmenu ctermbg=black ctermfg=yellow
    highlight PmenuSel ctermbg=yellow ctermfg=black
    highlight PmenuSbar ctermbg=yellow ctermfg=white
    highlight PmenuThumb ctermbg=black ctermfg=white

    " Tabs
        set tabstop=4
        set expandtab
        set shiftwidth=4
        set softtabstop=4

    " Highlighting
        set showmatch
        set hlsearch is
        
        highlight ColorColumn ctermbg=9
        " highlight ColorColumn ctermbg=red
        nnoremap <C-l> :nohl<CR>:echo "Search Cleared"<CR>

    " Global Keybindings
        nnoremap H 0
        nnoremap L $
        nnoremap J G
        nnoremap K gg
        map <C-s> :source ~/.config/nvim/init.vim<CR>
        tnoremap <Esc> <C-\><C-n>

    " Status-Line
        set statusline=             " Initialize Status Line
        set statusline+=\ %M        " Modified Flag
        set statusline+=\ %y        " Type of File
        set statusline+=\ %r        " Read Only Flag [RO]
        set statusline+=\ %F        " Full Path to file
        set statusline+=%=          " Right side settings
        set statusline+=\ %c:%l/%L  " Column, Line, Total Lines
        set statusline+=\ [%n]      " Buffer Number

    " Autocomplete
        " In Insert Mode
            " - ^x^n for JUST this file
            " - ^x^f for filenames (works with our path trick!)
            " - ^x^] for tags only
            " - ^n for anything specified by the 'complete' option

    " Snippets
        " If you ever find a need, see example below
            " nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>
            " type :,html to read in .skeleton.html file
            " go down 3 lines, forward a word, find > and append after

" Tags
    command! MakeTags !ctags -R .
    " How To Use
        " ^] - jump to tag under cursor
        " g^] - search for tag
        " ^t - go up a tag

" Plugins
call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
" Plug 'git@github.com:kien/ctrlp.vim.git'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let mapleader = " "

let g:ctrlp_use_caching = 0

" COC Syntax highlighting for JSON Config File
autocmd FileType json syntax match Comment +\/\/.\+$+

" Python Configurations
autocmd FileType python source $XDG_CONFIG_HOME/nvim/python.vim

" Yaml Configurations
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Netrw Configurations
    " File Explorer
    let g:netrw_banner=0        " disable annoying banner
    let g:netrw_browse_split=2  " open in prior window
    let g:netrw_winsize = 25
    let g:netrw_altv=1          " open splits to the right
    let g:netrw_liststyle=3     " tree view
    let g:netrw_list_hide=netrw_gitignore#Hide()
    let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
    " :edit "a folder"
    " h = horizontal split
    " v = vertial split
    " t = tab

" Misc
    " Return to the same line you left off at
    augroup line_return
        au!
        au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \       execute 'normal! g`"zvzz' |
            \ endif
    augroup END

" Remaps
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <leader>+ :vertical resize +5<cr>
nnoremap <silent> <leader>- :vertical resize -5<cr>

" Neovim LSP Custom Settings
lua  require('lua_config')
let g:completion_enable_fuzzy_match = 1
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
