# TurboMark - Mark and find lines in your open buffers on steroids

## Overview

This plugin intends to replace the functionality of the *m* and *'* keys that
Vim provides in normal mode. By using this plugin, you don't need to memorize a
register for each line you mark, you just mark it with *m*. Marked lines go
into a list which is displayed by using the *'* mapping. Upon pressing *'*, the
quickfix window opens, populated with the already marked lines and the editor
is automatically entered into search mode. This way, you can immediately type
part of the line you've previously marked, hit double-enter (the first is to
exit search-mode) and you're exactly where you want to be.

## Installation

Just paste the package's contents into into your .vim directory.

## Installing with [Pathogen](https://github.com/tpope/vim-pathogen)

1. `cd ~/.vim/bundle`
2. `git clone git://github.com/kbairak/TurboMark.git`

## Usage

- Press *m* to mark a line.
- Press *'* to open the quickfix window in search mode, to quickly find the
  marked line you want.

## Customization

You can override the default mappings in your .vimrc, like this:

    nmap <silent> mm :TurboMark<CR>
    nmap <silent> '' :TurboFind<CR>
