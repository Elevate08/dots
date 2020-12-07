" lua <<EOF
" local mapper = function(mode, key, result)
"     vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua "..result.."<cr>", {noremap = true, silent = true})
" end
" local on_attach = function(_, bufnr)
"     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
"     require'completion'.on_attach()
" end
" 
" require'lspconfig'.pyls.setup{on_attach=on_attach_vim}
" EOF
" 
" autocmd BufEnter python lua require'completion'.on_atach()
" 
" let g:completion_enable_fuzzy_match = 1
" let g:diagnostic_enable_virtual_text = 1
" 
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" set completeopt=menuone,noinsert,noselect

" let python_highlight_all = 1
" call matchadd('ColorColumn', '\%81v', 80)
" set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
" set wildignore=*/__pycache__/*,*.pyc
nnoremap <buffer> <F5> :w<cr>:exec '!clear'<cr>:exec '!python3' shellescape(expand('%:p'), 1)<cr>
" function! PyInclude(fname)
"     let parts = split(a:frame, ' import ') " (1) [conf.metrics] (2) [conv, conversion]
"     if len(parts) >1
"         let r = parts[1] "conversion"
"         let joined = join([l, 4], ',') "conv.conversion
"         let fp = substitute(joined, '\.', '/', 'g') . '.py'
"         let found = glob(fp, 1)
"         if len(found)
"             return found
"         endif
"     endif
"     return substitute(l, '\.', '/', 'g') . '.py'
" endfunction
" setlocal includeexpr=PyInclude(v:fname)
" setlocal define=^\\s*\\<\\(def\\\|class\\)\\>
" nnoremap <buffer> <F6> :w<cr>:exec '!surf http://127.0.0.1:8000'<cr>
