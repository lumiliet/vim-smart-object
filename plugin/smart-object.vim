
function! IsObject(object)
    let registerBackup = @u
    let @u=''
    silent execute 'normal! "uy' . a:object
    let isRegisterEmpty = @u == ''
    let @u = registerBackup
    return !isRegisterEmpty
endfunction

function! JumpToObject(object)
    execute 'normal! '. 'f' . a:object[1]
endfunction

function! GetPosition()
    return {'line': line('.'), 'col': col('.')}
endfunction

function! PositionEquals(left, right)
    return (a:left.line == a:right.line && a:left.col == a:right.col)
endfunction

function! SmartObject(action, object)
    if !IsObject(a:object)
        let startPosition = GetPosition()
        call JumpToObject(a:object)
        let endPosition = GetPosition()

        if PositionEquals(startPosition, endPosition)
            return
        endif
    endif

    execute 'normal! ' . a:action . a:object
    if a:action == 'c'
        normal! l
        startinsert
    endif
endfunction

function! VisualObject(object)
    call SmartObject('v', a:object)
endfunction


function! AddMapping(action, opening, closing)
    execute "nnore <silent> " . a:action . "i" . a:opening . " :call SmartObject('" . a:action . "', 'i" . a:opening . "')<CR>"
    execute "nnore <silent> " . a:action . "i" . a:closing . " :call SmartObject('" . a:action . "', 'i" . a:opening . "')<CR>"
    execute "nnore <silent> " . a:action . "a" . a:opening . " :call SmartObject('" . a:action . "', 'a" . a:opening . "')<CR>"
    execute "nnore <silent> " . a:action . "a" . a:closing . " :call SmartObject('" . a:action . "', 'a" . a:opening . "')<CR>"
endfunction

let s:pairs = [ ['(', ')'], ['[', ']'] ]
let s:actions = ['c','d']

function! AddMappings()
    for action in s:actions
        for pair in s:pairs
            call AddMapping(action, pair[0], pair[1])
        endfor
    endfor
endfunction

call AddMappings()
