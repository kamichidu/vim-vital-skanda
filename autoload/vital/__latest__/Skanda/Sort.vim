let s:save_cpo= &cpo
set cpo&vim

let s:sfile= expand('<sfile>:p')

function! s:_vital_loaded(V)
    let s:Lua= a:V.import('Lua.Prelude')
    let s:LuaP= s:Lua.lua_namespace()

    if has('lua')
        execute printf('lua skanda_context= "%s"', s:sfile)
        call luaeval('dofile(_A)', substitute(s:sfile, '\.vim', '.lua', ''))
    else
        throw "Vital.Skanda.Sort: You don't have if_lua."
    endif
endfunction

function! s:_vital_depends()
    return ['Lua.Prelude']
endfunction

function! s:sort(list, ...)
    return luaeval('_G[_A[0]].vim.sort(_A[1], _A[2])', [s:sfile, a:list, get(a:000, 0, 'lhs <= rhs')])
endfunction

let &cpo= s:save_cpo
unlet s:save_cpo
