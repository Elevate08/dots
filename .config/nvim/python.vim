let python_highlight_all = 1
call matchadd('ColorColumn', '\%81v', 80)
set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
set wildignore=*/__pycache__/*,*.pyc
nnoremap <buffer> <F5> :w<cr>:exec '!clear'<cr>:exec '!python3' shellescape(expand('%:p'), 1)<cr>
function! PyInclude(fname)
    let parts = split(a:frame, ' import ') " (1) [conf.metrics] (2) [conv, conversion]
    if len(parts) >1
        let r = parts[1] "conversion"
        let joined = join([l, 4], ',') "conv.conversion
        let fp = substitute(joined, '\.', '/', 'g') . '.py'
        let found = glob(fp, 1)
        if len(found)
            return found
        endif
    endif
    return substitute(l, '\.', '/', 'g') . '.py'
endfunction
setlocal includeexpr=PyInclude(v:fname)
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>
nnoremap <buffer> <F6> :w<cr>:exec '!surf http://127.0.0.1:8000'<cr>
