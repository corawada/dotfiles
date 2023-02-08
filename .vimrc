" ########################### DEIN SETTINGS ################################# 
source $VIMRUNTIME/defaults.vim

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim' 
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " toml file
  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy':0})

  " end settings
  call dein#end()
  call dein#save_state()
endif

" plugin installation check
if dein#check_install()
  call dein#install()
endif

" plugin remove check
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif

"########################### PLUGINS ################################# 
" plugins settings 

colorscheme mpyceberg
set t_Co=256
set laststatus=2
filetype plugin indent on

" netrw
filetype plugin on
let g:netrw_liststyle=1
let g:netrw_banner=0
let g:netrw_sizestyle='H'
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1

" vim-airline
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#right = '<'
let g:airline#extensions#tabline#left = '>'
let g:airline_right_sep = '>'
let g:airline_left_sep = '<'
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab

" session path for vsession?
let s:session_path = expand('~/.vim/sessions')

if !isdirectory(s:session_path)
  call mkdir(s:session_path, "p")
endif

" ###################### DEFAULT SETTINGS ############################

" settings
set fenc=utf-8
set encoding=utf-8
set nobackup
set noswapfile
set autoread
set showcmd

" views
set number
set cursorline
syntax on
set foldmethod=indent

" set cursorcolumn
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest

nnoremap j gj
nnoremap k gk

" Tab
set expandtab
set tabstop=2
set shiftwidth=2

" search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 操作
inoremap <silent> jj <Esc>

" 自動実行
filetype on

augroup vimrc
    " Remove all autocommands in this group
    autocmd!

    " <F5> key execution
    " autocmd FileType java        nmap <buffer> <F5> :!javac -encoding UTF-8 % && java %<<CR>
    " autocmd FileType javascript  nmap <buffer> <F5> :!node %<CR>
    " autocmd FileType php         nmap <buffer> <F5> :!php %<CR>
    autocmd FileType python      nmap <buffer> <F5> :!python3 %<CR>
    " autocmd FileType ruby        nmap <buffer> <F5> :!ruby %<CR>
    autocmd FileType go          nmap <buffer> <F5> :!go run %<CR>
    " autocmd FileType groovy      nmap <buffer> <F5> :!groovy %<CR>
    autocmd FileType vim         nmap <buffer> <F5> :source %<CR>

    autocmd BufNewFile,BufRead *.blade.php set syntax=html
    autocmd BufNewFile,BufRead *.blade.php set filetype=html
augroup END

autocmd BufNewFile,BufRead *.ejs  set filetype=html

" 矢印無効
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"----------------------------------------------------------
" カラースキーム編集用
"----------------------------------------------------------
" ハイライトグループを知るコマンド:SyntaxInfoを実装
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

