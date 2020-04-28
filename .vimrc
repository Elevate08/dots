" General settings
syntax on
filetype plugin indent on

" Colors
    colorscheme slate
    set background=dark
    
" Environment
    set number
    set relativenumber
    set nocompatible
    set path+=**
    set autoread
    set spelllang=en_us
    set spell
    set wildmenu
    set encoding=UTF-8
    set backspace=indent,eol,start  " Make sure backspace works
    set noruler
    set confirm
    set autoindent
    set smartindent
    set cursorline
    set ic
    set fdm=syntax                  " Folding on Syntax

    " Tabs
        set tabstop=4
        set expandtab
        set shiftwidth=4
        set softtabstop=4

    " Highlighting
        set showmatch
        set hlsearch is
        highlight ColorColumn ctermbg=red
        nnoremap <C-l> :nohl<CR><C-1>:echo "Search Cleared"<CR>

    " Global Keybindings
        nnoremap H 0
        nnoremap L $
        nnoremap J G
        nnoremap K gg
        map <C-s> :source ~/.config/nvim/init.vim<CR>

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

" Python Configurations
    let python_highlight_all = 1
    autocmd FileType python
        \       call matchadd('ColorColumn', '\%81v', 80) |
        \       nnoremap <buffer> <F5> :w<cr>:exec '!clear'<cr>:exec '!python3' shellescape(expand('%:p'), 1)<cr>

" Yaml Configurations
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Netrw Configurations
    " File Explorer
    let g:netrw_banner=0        " disable annoying banner
    let g:netrw_browse_split=4  " open in prior window
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
