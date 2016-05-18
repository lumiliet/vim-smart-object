
function! s:IsObject(object)
    let registerBackup = @u
    let @u=''
    silent execute 'normal! "uy' . a:object
    let isRegisterEmpty = @u == ''
    let @u = registerBackup
    return !isRegisterEmpty
endfunction

function! s:JumpToObject(object)
    let startPosition = s:GetPosition()
    execute 'normal! '. 'f' . a:object[1]
    let endPosition = s:GetPosition()

    if s:PositionEquals(startPosition, endPosition)
        return 0
    else 
        return 1
    endif
endfunction

function! s:GetPosition()
    return {'line': line('.'), 'col': col('.')}
endfunction

function! s:PositionEquals(left, right)
    return (a:left.line == a:right.line && a:left.col == a:right.col)
endfunction

function! s:PlaceCursorInObject(object)
    if !s:IsObject(a:object)
        return s:JumpToObject(a:object)
    endif
    return 1
endfunction

function! SmartObject(action, object)
    if s:PlaceCursorInObject(a:object)
        call feedkeys(a:action . a:object, 'n')
    endif
endfunction


function! s:AddMapping(action, opening, closing)
    execute "nnore <silent> " . a:action . "i" . a:opening . " :call SmartObject('" . a:action . "', 'i" . a:opening . "')<CR>"
    execute "nnore <silent> " . a:action . "i" . a:closing . " :call SmartObject('" . a:action . "', 'i" . a:opening . "')<CR>"
    execute "nnore <silent> " . a:action . "a" . a:opening . " :call SmartObject('" . a:action . "', 'a" . a:opening . "')<CR>"
    execute "nnore <silent> " . a:action . "a" . a:closing . " :call SmartObject('" . a:action . "', 'a" . a:opening . "')<CR>"
endfunction

function! s:InitializaSettings()
    if !exists('g:smart_object_commands')
        let g:smart_object_commands = 'c,d,y'
    endif

    if !exists('g:smart_object_blocks')
        let g:smart_object_blocks = '(),[],{}'
    endif

    let s:actions = split(g:smart_object_commands, ',')

    let blocks = split(g:smart_object_blocks, ',')
    let s:pairs = []
    for i in range(0, len(blocks) - 1)
        call add(s:pairs, blocks[i])
    endfor
endfunction

call s:InitializaSettings()

function! s:AddMappings()
    for action in s:actions
        for pair in s:pairs
            call s:AddMapping(action, pair[0], pair[1])
        endfor
    endfor
endfunction

call s:AddMappings()
