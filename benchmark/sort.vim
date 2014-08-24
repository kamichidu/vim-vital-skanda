let s:S= vital#of('vital').import('Skanda.Sort')

let files= split(globpath('./benchmark/fixtures/', 'elements.*'), '\%(\r\n\|\r\|\n\)')

" let helper_path= fnamemodify('./benchmark/helper/', ':p:h')
" lua << ...
" package.path= package.path .. ';' .. vim.eval('helper_path') .. '/?.lua'
"
" profiler= require 'profiler'
" io.open('profiler.tsv')
" profiler.start()
" ...

" keep order
function! s:keep_order(lhs, rhs)
    return str2nr(fnamemodify(a:lhs, ':e')) - str2nr(fnamemodify(a:rhs, ':e'))
endfunction
call sort(files, function('s:keep_order'))

" walm-up
call sort([])
call s:S.sort([])

for file in files
    let s:elements= readfile(file)

    echo 's:elements has ' . len(s:elements) . ' items'
    echo 'time required:'

    let start_time= reltime()
    call sort(copy(s:elements))
    echo '  built-in sort:    ' . reltimestr(reltime(start_time)) . ' [s]'

    let start_time= reltime()
    call s:S.sort(copy(s:elements))
    echo '  Skanda.Sort.sort: ' . reltimestr(reltime(start_time)) . ' [s]'

    unlet s:elements
endfor
" lua << ...
" profiler.stop()
" io.close()
" ...
