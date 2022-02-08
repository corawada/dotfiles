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

colorscheme edge
set t_Co=256
set laststatus=2
filetype plugin indent on

" vim-airline
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#right = '<'
let g:airline#extensions#tabline#left = '>'
let g:airline_right_sep = '>'
let g:airline_left_sep = '<'
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab

" NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

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
" set cursorcolumn
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest

nnoremap j gj
nnoremap k gk
syntax enable

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
inoremap <silent> lll <Esc>la

" compliment
inoremap { {}<Left>
inoremap {{ {}<Right>
inoremap {<Enter> {}<Left><CR><ESC><S-0>
inoremap ( ()<Left>
inoremap (( ()<Right>
inoremap (<Enter> ()<Left><CR><ESC><S-0>
inoremap [ []<Left>
inoremap [[ []<Right>
inoremap [<Enter> []<Left><CR><ESC><S-0>

inoremap < <><Left>
inoremap << <><Right>
inoremap <<Enter> <><Left><CR><ESC><S-0>

inoremap ' ''<Left>
inoremap '' ''<Right>
inoremap " ""<Left>
inoremap "" ""<Right>

