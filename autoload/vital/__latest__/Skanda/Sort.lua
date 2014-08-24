local public= {lua= {}, vim= {}}
local vital= _G[vital_context].lua

local function merge(list1, list2, comparator)
    local result= {}
    local a, b= list1[1], list2[1]
    local j, k= 1, 1

    while true do
        if comparator(a, b) then
            table.insert(result, a)
            j= j + 1
            if not (j <= #list1) then
                break
            end
            a= list1[j]
        else
            table.insert(result, b)
            k= k + 1
            if not (k <= #list2) then
                break
            end
            b= list2[k]
        end
    end
    while j <= #list1 do
        table.insert(result, list1[j])
        j= j + 1
    end
    while k <= #list2 do
        table.insert(result, list2[k])
        k= k + 1
    end
    return result
end

local function merge_sort(list, comparator)
    if #list <= 1 then
        return list
    end

    local first= {}
    for i= 1, math.floor(#list / 2) do
        table.insert(first, list[i])
    end

    local second= {}
    for i= math.floor(#list / 2 + 1), #list do
        table.insert(second, list[i])
    end

    return merge(
        merge_sort(first, comparator),
        merge_sort(second, comparator),
        comparator
    )
end

function public.lua.sort(list, comparator)
    return merge_sort(list, comparator)
end

function public.vim.sort(list, expr)
    local comparator= load('return function(lhs, rhs) return ' .. expr .. ' end')()
    return vital.from_lua(public.lua.sort(vital.to_lua(list), comparator))
end

_G[skanda_context]= public
