
function! SmartObject(action, object)
    let @u=''
    silent execute 'normal "uy' . a:object
    if @u == ''
        execute 'normal! '. 'f' . a:object[1]
    endif

    execute 'normal! ' . a:action . a:object
    if a:action == 'c'
        normal! l
        startinsert
    endif
endfunction

call SmartObject('d', "i(")



nnore <silent> ci( :call SmartObject('c', "i(")<CR>
nnore <silent> ci) :call SmartObject('c', "i(")<CR>
nnore <silent> ca( :call SmartObject('c', "a(")<CR>
nnore <silent> ca) :call SmartObject('c', "a(")<CR>

nnore <silent> di( :call SmartObject('d', "i(")<CR>
nnore <silent> di) :call SmartObject('d', "i(")<CR>
nnore <silent> da( :call SmartObject('d', "a(")<CR>
nnore <silent> da) :call SmartObject('d', "a(")<CR>

