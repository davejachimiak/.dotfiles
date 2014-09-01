"vundle
set nocompatible
filetype off
set shell=/bin/bash
                                
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'godlygeek/tabular'
Plugin 'SuperTab'
Plugin 'Rename'
Plugin 'jnwhiteh/vim-golang'
Plugin 'The-NERD-Commenter'

Plugin 'mustache/vim-mustache-handlebars'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-rbenv'
Plugin 'tpope/vim-markdown'
Plugin 'davejachimiak/chazmine'
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-scripts/hlint'

call vundle#end()
filetype plugin indent on

"custom
set number 
set nowrap
set cursorline
set wildmode=longest,list,full
set wildmenu
set ts=2 sw=2 expandtab

let g:testRunner=0

"statusline
set laststatus=2
set statusline=
set statusline+=%1*\ %<%F
set statusline+=%2*\ %=\ row:%l/%L\ (%p%%)
set statusline+=%3*\ col:%c

"mappings
let mapleader=' '

imap jj <Esc>
cnoremap jj <Esc>

noremap <C-l> <C-W>l
noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k

noremap <leader>v :vsplit <C-R>=expand('%:p:h').'/'<cr>
noremap <leader>s :split <C-R>=expand('%:p:h').'/'<cr>
noremap <leader>e :e <C-R>=expand('%:p:h').'/'<cr>

nmap <leader>l :call RunTestCommand(line('.'))<CR>
nmap <leader>a :call RunTestCommand()<CR>         

command! AsyncTests execute s:asyncTests()
command! NoAsyncTests execute s:noAsyncTests()

function! s:asyncTests()
  let g:testRunner=1
  execute ':silent :echo "Async Tests Engaged!"'
endfunction

function! s:noAsyncTests()
  let g:testRunner=0
  execute 'echo "Synchronous Tests Engaged!"'
endfunction

function! GetTestCommand()                                                                     
  if !empty(glob("./.zeus.sock"))
    let cmdPrefix = "zeus "
  else
    let cmdPrefix = "bundle exec "
  endif

  if expand('%:r') =~ '_spec$'                                                                      
    return cmdPrefix . 'rspec --color'                                                                    
  elseif expand('%') =~ '\.feature$'                                                                
    return 'bundle exec cucumber'                                                                 
  else                                                                                              
    return '0'                                                                                    
  endif                                                                                             
endfunction                                                                                           

function! RunTestCommand(...)
  let cmd = GetTestCommand()
  let cmdWithFile = cmd . ' ' . expand('%') . (a:0 == 1 ? ':'.line('.') : '')

  " save files before running tests
  execute ":wa"

  " if there's a command update the test command register (t)                                       
  if cmd != '0'
    if g:testRunner
      let @t = ':silent !echo "' . cmdWithFile . '" > test-commands'
    else
      let @t = ':!' . cmdWithFile
    endif
  endif                             

  " if the test command register isn't empty, excecute it.                                          
  if strlen(@t) > 0                                
    execute @t

    if g:testRunner
      execute "redraw!"
    endif
  else
    echoerr "No test command to run"
  endif
endfunction

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
 
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

"colorscheme
syntax on
set t_Co=256
colorscheme Tomorrow-Night-Eighties
