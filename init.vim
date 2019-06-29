set nocompatible
filetype off

syntax on
colorscheme genericdc
"colorscheme yaflandia

" Show line numbers
set number

" Keep 3 lines after/before the cursor
set so=3

" Allow unsaved buffers in background, but not netrw (dir listing)
set nohidden
augroup netrw_buf_hidden_fix
    autocmd!
    " Set all non-netrw buffers to bufhidden=hide
    autocmd BufWinEnter *
                \  if &ft != 'netrw'
                \|     set bufhidden=hide
                \| endif
augroup end

" Search down into subfolders
set path+=**

" Horizontal line
" au WinLeave * set nocursorline nocursorcolumn
" au WinEnter * set cursorline cursorcolumn
set cursorline

" Insert spaces instead of tabs
set tabstop=4 shiftwidth=4 expandtab

syntax on

" 256 colors
let &t_Co=256

" Color columns 80+
let &colorcolumn=81

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'
Plugin 'darsto/lightline.vim'
Plugin 'darsto/coc.nvim'
Plugin 'darsto/fzf.vim'
Plugin 'm-pilia/vim-ccls'
Plugin 'ap/vim-buftabline'

call vundle#end()
filetype plugin indent on

" plug fzf for fuzzy search
set rtp+=~/proj/fzf

" Hide -- INSERT --
set noshowmode

" Enable mouse integration
set mouse=a

map [b :bp<CR>
map ]b :bn<CR>

map [t :tabp<CR>
map ]t :tabn<CR>

" set the terminal title
set title

" bash-like completion
set wildmode=longest,list

" highlight search results
set hlsearch

" c folding from c.vim
set foldmethod=syntax

" unfold by default
"autocmd FileType * exe "normal zR"

" highlight word under cursor
nnoremap <C-/> *#
inoremap <C-/> <C-o>*<C-o>#

" Go to mark
"nnoremap k `

" More friendly C-Arrow word navigation
nnoremap <C-Left> <C-S-Left>
nnoremap <C-Right> <C-S-Right>

nnoremap <C-S-Down> <C-D>
nnoremap <C-S-Up> <C-U>

" Cancel highlighting
nnoremap <silent> <C-G> :noh<CR>

" Enter will insert empty line after cursor
"nnoremap <CR> $<S-A><CR>

" Insert empty line before selected line
"inoremap <C-L> <C-o>^<CR>
"nnoremap <C-P> ^i<CR><C-c>

" Insert empty line after selected line
"inoremap <C-L> <C-o>$<Right><CR>
"nnoremap <C-L> $<S-A><CR>

" Show buffer list and wait to select one
nnoremap gb :ls<CR>:b<Space>

" Entering normal mode
nnoremap ; :

" Backspace/delete will switch to insert mode
nnoremap <BS> i<BS>
nnoremap <DEL> i<DEL>

nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

set updatetime=300

set signcolumn=yes

set foldlevel=99

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-Space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gt :call CocAction('workspaceSymbols')<cr>

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')

  autocmd FileType yggdrasil exe "set signcolumn=no"
augroup end

let g:yggdrasil_no_default_maps = 1
au FileType yggdrasil nmap <silent> <buffer> <space> <Plug>(yggdrasil-toggle-node)
au FileType yggdrasil nmap <silent> <buffer> <CR> <Plug>(yggdrasil-execute-node)
au FileType yggdrasil nmap <silent> <buffer> <Right> <Plug>(yggdrasil-open-node)
au FileType yggdrasil nmap <silent> <buffer> <Left> <Plug>(yggdrasil-close-node)
au FileType yggdrasil nmap <silent> <buffer> q :q<CR>

let g:lightline = {
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ ] ],
      \ },
      \ }

