" Vim global plugin to quickly mark and find lines in your open buffers
" Last Change: 2014 May 28
" Maintainer: Konstantinos Bairaktaris <ikijob@gmail.com>
" License: This file is placed in the public domain
" Version: 0.2

if exists("g:loaded_turbomark")
    finish
endif

let g:loaded_turbomark = 1
let g:TurboMark = {}
let s:marklist = []
if !exists('g:TurboMarkListFile')
    let g:TurboMarkListFile = expand('$HOME') . "/.TurboMarkList.txt"
endif
if !exists('g:TurboMarkMax')
    let g:TurboMarkMax = 100
endif
if !exists('g:TurboMarkSearchOnOpen')
    let g:TurboMarkSearchOnOpen = 0
endif

function g:TurboMark.Init()
    if filereadable(g:TurboMarkListFile)
        let s:marklist = readfile(g:TurboMarkListFile)
    endif
endfunction

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

    let l:from = 100
    if len(s:marklist) < 100
        let l:from = len(s:marklist)
    endif
    let s:marklist = s:marklist[-l:from : ]

    call writefile(s:marklist, g:TurboMarkListFile)
endfunction

function g:TurboMark.Clear()
    let s:marklist = []
endfunction

let g:TurboMark.in_turbomark = 0

function s:close_quickfix_and_clear()
    if g:TurboMark.in_turbomark == 1
        cclose
        let g:TurboMark.in_turbomark = 0
    endif
endfunction
autocmd BufEnter * call s:close_quickfix_and_clear()

function g:TurboMark.Find()
    let l:reversed = copy(s:marklist)
    call reverse(l:reversed)
    cgetexpr l:reversed
    copen
    let g:TurboMark.in_turbomark = 1
    if g:TurboMarkSearchOnOpen == 1
        call feedkeys('/\c')
    endif
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

call g:TurboMark.Init()
