let g:mapleader=" "
let &t_ut=""

set clipboard=unnamedplus,unnamed

function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction
nmap <leader>j :call GotoJump()<CR>

nmap <leader>te :Ex<CR>
nmap <leader>f :e <C-d>

syntax on
set laststatus=2
set scrolloff=4
set timeoutlen=100

set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=0 expandtab

set ruler
set showmatch
set autoindent
set textwidth=80

set incsearch
nmap <leader>nh :noh<CR>

set wildmenu
set wildmode=longest,list
set path=.,,**
set number
set relativenumber

augroup InitNetrw
    autocmd!
    autocmd VimEnter * if expand("%") == "" | :Ex | endif
augroup end

filetype plugin on
set omnifunc=syntaxcomplete#Complete
" tag file for all header files in /usr/include /usr/local/include
set tags+=~/.vim/systags

call plug#begin()
    Plug 'epheien/termdbg'
    Plug 'owickstrom/vim-colors-paramount'
    Plug 'jasonccox/vim-wayland-clipboard'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

set background=dark
colorscheme paramount
