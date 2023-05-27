"HerringtonDarkholme/yats.vim vim-plug

"------------------Start of Plugins-------------------"
"call plug#begin('~/.vim/plugged')
"-------------------Existing Plugins------------------"

"Plug 'wakatime/vim-wakatime'
"Plug 'preservim/nerdcommenter'
"Plug 'tpope/vim-fugitive'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'Chiel92/vim-autoformat'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'sakshamgupta05/vim-todo-highlight'
"Plug 'yggdroot/indentline'
"Plug 'tpope/vim-eunuch'
"Plug 'airblade/vim-gitgutter'
"Plug 'ryanoasis/vim-devicons'
"Plug 'tpope/vim-surround'

"-----------------Themes/Colorschemes-----------------"

"Plug 'sainnhe/gruvbox-material'
"Plug 'ghifarit53/tokyonight-vim'
"Plug 'cocopon/iceberg.vim'

"Plug 'nvim-lualine/lualine.nvim'
"Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

"-------------------Lua/0.5.0-------------------------"

 "Navigation
"Plug 'nvim-lua/popup.nvim'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-telescope/telescope-fzy-native.nvim'
"Plug 'kyazdani42/nvim-tree.lua'
"Plug 'kyazdani42/nvim-web-devicons'

 "Languages
"Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/playground'
"Plug 'tjdevries/nlua.nvim'
"Plug 'nvim-lua/lsp_extensions.nvim'
"Plug 'rust-lang/rust.vim'
"Plug 'jiangmiao/auto-pairs'
"Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
"Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
"Plug 'hrsh7th/cmp-path', {'branch': 'main'}
"Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
"Plug 'simrat39/rust-tools.nvim'
"Plug 'hrsh7th/vim-vsnip'

 "Debugging
"Plug 'mfussenegger/nvim-dap'
"Plug 'leoluz/nvim-dap-go'
"Plug 'rcarriga/nvim-dap-ui'
"Plug 'theHamsta/nvim-dap-virtual-text'
"Plug 'nvim-telescope/telescope-dap.nvim'
"Plug 'mxsdev/nvim-dap-vscode-js'

 "JavaScript, TypeScript, React
"Plug 'jose-elias-alvarez/null-ls.nvim'
"Plug 'MunifTanjim/prettier.nvim'

 "Solidity Language Plugin
"Plug 'tomlion/vim-solidity'

 "Misc.
"Plug 'mbbill/undotree'
"Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"Plug 'onsails/lspkind-nvim'
"Plug 'andweeb/presence.nvim'

"------------------End of Plugins---------------------"
"call plug#end()
"-----------------------------------------------------"

" set
set nu rnu
set nowrap
set textwidth=0
set wrapmargin=0
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab
set autoindent
set sw=2
set go-=T
set go-=m
set ls=2
set scrolloff=12
set signcolumn=yes
set colorcolumn=80
set nohlsearch
set incsearch
set mouse=
set ignorecase
set smartcase
set ttimeoutlen=100
set encoding=UTF-8
set hidden
set lazyredraw

set background=dark
set termguicolors

set backupdir=$HOME/.vim/tmp/backup/
set undodir=$HOME/.vim/tmp/undo/
set directory=$HOME/.vim/tmp/swap/
set backup
set noswapfile

set rtp+=/usr/local/opt/fzf

" let
let mapleader = " "
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Rust let commands
let g:rustfmt_autosave = 1

let g:prettier#autoformat = 0

let g:one_allow_italics=1

" Remap Escape Key
inoremap jj <Esc>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>
nnoremap <C-s> ysw
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
noremap <Leader>k :Autoformat<CR>
nmap <Leader>d :bd<CR>
nmap <Leader>bd :bp\|bd #<CR>
nnoremap <Leader>o o<Esc>
nnoremap <Leader>p O<Esc>
nnoremap <Leader>P :Prettier<CR>
nnoremap <silent><Leader>w :w<CR>
nnoremap <Leader>y "*y
vnoremap <Leader>y "*y
nnoremap <Leader>ut :UndotreeToggle<CR>
nnoremap <Leader>t :terminal<CR>
nnoremap <Leader>q :q<CR>
nnoremap <silent> gb :BufferLinePick<CR>
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gp :Git push<CR>
nmap <Leader>G :G<CR>
nmap <Leader>md <Plug>MarkdownPreviewToggle

" augroup
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

set termguicolors " This variable must be enabled for colors to be applied properly

if has('termguicolors')
  set termguicolors
endif

"colorscheme iceberg
let g:airline_theme='gruvbox'

source ~/.go.vimrc
