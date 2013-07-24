" Vim global plugin to quickly mark and find lines in your open buffers
" Last Change: 2013 Jul 24
" Maintainer: Konstantinos Bairaktaris <ikijob@gmail.com>
" License: This file is placed in the public domain

if exists("g:loaded_turbomark")
    finish
endif
let g:loaded_turbomark = 1

let g:TurboMark = {}
let s:marklist = []

function g:TurboMark.Mark()
    let filepath = expand("%")
    let linenumber = line(".")
    let line = getline(".")
    let quickfix_entry = filepath . ":" . linenumber . ":" . line
    let place = index(s:marklist, quickfix_entry)
    if place != -1
        call remove(s:marklist, place)
    endif
    call add(s:marklist, quickfix_entry)
endfunction

function g:TurboMark.Clear()
    let s:marklist = []
endfunction

function g:TurboMark.Find()
    call reverse(s:marklist)
    let reversed = copy(s:marklist)
    call reverse(s:marklist)
    execute "cgetexpr reversed"
    execute "copen"
    call feedkeys('/')
endfunction

command TurboMark call g:TurboMark.Mark()
command TurboClear call g:TurboMark.Clear()
command TurboFind call g:TurboMark.Find()

if !hasmapto('TurboMark')
    nmap <silent> m :TurboMark<CR>
endif
if !hasmapto('TurboFind')
    nmap <silent> ' :TurboFind<CR>
endif
