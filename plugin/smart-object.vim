
function! SmartObject(action, object)
    execute 'normal! '. 'f' . a:object[1]
    execute 'normal! ' . a:action . a:object
    if a:action == 'c'
        normal! l
        startinsert
    endif
endfunction

nnore <buffer> <silent> ci( :call SmartObject('c', "i)")<CR>
nnore <buffer> <silent> ci) :call SmartObject('c', "i)")<CR>
nnore <buffer> <silent> ca( :call SmartObject('c', "a)")<CR>
nnore <buffer> <silent> ca) :call SmartObject('c', "a)")<CR>

nnore <buffer> <silent> di( :call SmartObject('d', "i)")<CR>
nnore <buffer> <silent> di) :call SmartObject('d', "i)")<CR>
nnore <buffer> <silent> da( :call SmartObject('d', "a)")<CR>
nnore <buffer> <silent> da) :call SmartObject('d', "a)")<CR>

