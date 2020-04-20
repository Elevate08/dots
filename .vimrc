" Plugin Load:
    " Plugins located at $HOME/.vim/bundle/
    " execute pathogen#infect()

" General Settings:
syntax on
filetype plugin indent on
set fdm=syntax

    " Colors:
        colorscheme slate
        set background=dark
        let g:airline_theme='raven'

    " Environment:
        set number
        set relativenumber
        set nocompatible
        set path+=**
        set wildmenu

    " Tabs:
        set ts=4
        set expandtab
        set shiftwidth=4

    " Highlighting:
        set showmatch
        set hlsearch
        highlight ColorColumn ctermbg=red
        nnoremap <C-l> :nohl<CR><C-1>:echo "Search Cleared"<CR>

    " Global Keybindings:
        nnoremap H 0
        nnoremap L $
        nnoremap J G
        nnoremap K gg

    " Autocomplete:
        " In Insert Mode:
            " - ^x^n for JUST this file
            " - ^x^f for filenames (works with our path trick!)
            " - ^x^] for tags only
            " - ^n for anything specified by the 'complete' option

    " Snippets:
        " If you ever find a need, see example below
            " nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a
            " type :,html to read in .skeleton.html file
            " go down 3 lines, forward a word, find > and append after

" Tags:
    command! MakeTags !ctags -R .
    " How To Use:
        " ^] - jump to tag under cursor
        " g^] - search for tag
        " ^t - go up a tag

" Python Configurations:
    let python_highlight_all = 1
    autocmd FileType    python
        \       call matchadd('ColorColumn', '\%81v', 80) |
        \       nnoremap <buffer> <F5> :w<cr>:exec '!clear'<cr>:exec '!python3' shellescape(expand('%:p'), 1)<cr>

" Yaml Configurations:
    au BufRead,BufNewFile *.yaml set filetype=yaml.ansible
    let g:ansible_unindent_after_newline = 1 |
    let g:ansible_attribute_highlight = "ob" |
    let g:ansible_name_highlight = 'd'

" Netrw Configurations:
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

" Misc:
    " Last Change Here
    set backspace=indent,eol,start

    " Return to the same line you left off at
    augroup line_return
        au!
        au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \       execute 'normal! g`"zvzz' |
            \ endif
    augroup END
