let s:dest_dir= expand('<sfile>:p:h')

let s:rng= vital#of('vital').import('Random.Xor128')
let s:elements_sizes= [
\         0,
\        10,
\       100,
\       200,
\       300,
\       400,
\       500,
\       600,
\       700,
\       800,
\       900,
\      1000,
\     10000,
\    100000,
\]

" clean-up
let old_files= split(globpath(s:dest_dir, 'elements.*'), '\%(\r\n\|\r\|\n\)')

for file in old_files
    call delete(file)
endfor

for size in s:elements_sizes
    call writefile(map(range(1, size), 's:rng.rand()'), s:dest_dir . '/elements.' . size)
endfor
