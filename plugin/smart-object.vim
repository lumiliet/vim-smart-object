
function! IsObject(object)
    let registerBackup = @u
    let @u=''
    silent execute 'normal "uy' . a:object
    let isRegisterEmpty = @u == ''
    let @u = registerBackup
    return !isRegisterEmpty
endfunction

function! JumpToObject(object)
    execute 'normal! '. 'f' . a:object[1]
endfunction

function! SmartObject(action, object)
    if !IsObject(a:object)
        call JumpToObject(a:object)
    endif

    execute 'normal! ' . a:action . a:object
    if a:action == 'c'
        normal! l
        startinsert
    endif
endfunction



nnore <silent> ci( :call SmartObject('c', "i(")<CR>
nnore <silent> ci) :call SmartObject('c', "i(")<CR>
nnore <silent> ca( :call SmartObject('c', "a(")<CR>
nnore <silent> ca) :call SmartObject('c', "a(")<CR>

nnore <silent> di( :call SmartObject('d', "i(")<CR>
nnore <silent> di) :call SmartObject('d', "i(")<CR>
nnore <silent> da( :call SmartObject('d', "a(")<CR>
nnore <silent> da) :call SmartObject('d', "a(")<CR>

