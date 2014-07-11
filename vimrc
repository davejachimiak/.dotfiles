"vundle
set nocompatible
filetype off
set shell=/bin/zsh
                                
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
Bundle 'godlygeek/tabular'
Bundle 'SuperTab'
Bundle 'Rename'
Bundle 'go.vim'
Bundle 'The-NERD-Commenter'

Bundle 'mustache/vim-mustache-handlebars'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-rbenv'
Bundle 'tpope/vim-markdown'
Bundle 'davejachimiak/chazmine'
Bundle 'vim-ruby/vim-ruby'
Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-scripts/hlint'

filetype plugin indent on

"custom
set number 
set nowrap
set cursorline
set wildmode=longest,list,full
set wildmenu
set ts=2 sw=2 expandtab

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

function! GetTestCommand()                                                                     
  if expand('%:r') =~ '_spec$'                                                                      
    return 'bundle exec rspec --color'                                                                    
  elseif expand('%') =~ '\.feature$'                                                                
    return 'bundle exec cucumber'                                                                 
  else                                                                                              
    return '0'                                                                                    
  endif                                                                                             
endfunction                                                                                           

function! RunTestCommand(...)
  let cmd = GetTestCommand()

  " if there's a command update the test command register (t)                                       
  if cmd != '0'                                                                                     
    let @t = ':!' . cmd . ' ' . expand('%') . (a:0 == 1 ? ':'.line('.') : '')                     
  endif                                                                                             

  " if the test command register isn't empty, excecute it.                                          
  if strlen(@t) > 0                                                                                 
    execute @t                                                                                    
  elseif                                                                                            
    echoerr "No test command to run"                                                              
  end                                                                                               
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
