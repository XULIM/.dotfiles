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

call plug#begin()
    Plug 'owickstrom/vim-colors-paramount'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'jasonccox/vim-wayland-clipboard'
call plug#end()

set background=dark
colorscheme paramount

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    " setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [d <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]d <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_document_highlight_enabled = 0
let g:lsp_diagnostics_enabled = 0
