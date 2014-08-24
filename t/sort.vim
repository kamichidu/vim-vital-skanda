filetype plugin indent off
set runtimepath+=./.vim-test/vital.vim/
filetype plugin indent on

runtime plugin/*.vim
source .vim-test/vital.vim/autoload/vital.vim
source .vim-test/vital.vim/autoload/vital/__latest__.vim

describe 'Skanda.Sort'
    describe 'sort'
        it 'sorts empty elements'
            let S= vital#of('vital').import('Skanda.Sort')

            Expect S.sort([]) ==# []

            let actually= S.sort([], 'lhs >= rhs')
            Expect actually ==# []
        end

        it 'sorts elements'
            let S= vital#of('vital').import('Skanda.Sort')

            " number
            Expect S.sort([3, 2, 1, 4, 5]) ==# [1.0, 2.0, 3.0, 4.0, 5.0]

            let actually= S.sort([3, 2, 1, 4, 5], 'lhs >= rhs')
            Expect actually ==# [5.0, 4.0, 3.0, 2.0, 1.0]

            " string
            Expect S.sort(['c', 'b', 'a', 'e', 'd']) ==# ['a', 'b', 'c', 'd', 'e']

            let actually= S.sort(['c', 'b', 'a', 'e', 'd'], 'lhs >= rhs')
            Expect actually ==# ['e', 'd', 'c', 'b', 'a']

            " dictionary
            " stable sort
            let actually= S.sort([
            \   {'k': 3, 'o': 0},
            \   {'k': 2, 'o': 1},
            \   {'k': 1, 'o': 2},
            \   {'k': 1, 'o': 3},
            \   {'k': 2, 'o': 4},
            \   {'k': 4, 'o': 5},
            \   {'k': 5, 'o': 6},
            \], 'lhs.k <= rhs.k')
            Expect actually ==# [
            \   {'k': 1.0, 'o': 2.0},
            \   {'k': 1.0, 'o': 3.0},
            \   {'k': 2.0, 'o': 1.0},
            \   {'k': 2.0, 'o': 4.0},
            \   {'k': 3.0, 'o': 0.0},
            \   {'k': 4.0, 'o': 5.0},
            \   {'k': 5.0, 'o': 6.0},
            \]

            " list
            " stable sort
            let actually= S.sort([
            \   [3, 0],
            \   [2, 1],
            \   [1, 2],
            \   [1, 3],
            \   [2, 4],
            \   [4, 5],
            \   [5, 6],
            \], 'lhs[1] <= rhs[1]')
            Expect actually ==# [
            \   [1.0, 2.0],
            \   [1.0, 3.0],
            \   [2.0, 1.0],
            \   [2.0, 4.0],
            \   [3.0, 0.0],
            \   [4.0, 5.0],
            \   [5.0, 6.0],
            \]
        end
    end
end
