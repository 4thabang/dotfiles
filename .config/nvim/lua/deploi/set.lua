local set = vim.opt

set.nu = true
set.rnu = true

set.wrap = false
set.textwidth = 0
set.wrapmargin = 0
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.smarttab = false
set.autoindent = true
set.sw = 2
set.go = "T"
set.go = "m"
set.ls = 2
set.scrolloff = 12
set.signcolumn = "yes"
set.colorcolumn = "80"
set.hlsearch = false
set.incsearch = true
set.mouse = nil
set.ignorecase = true
set.smartcase = true
set.ttimeoutlen = 100
set.encoding = "UTF-8"
set.hidden = true
set.lazyredraw = true

set.background = "dark"
set.termguicolors = true

set.backupdir = os.getenv("HOME") .. "/.vim/tmp/backup/"
set.undodir = os.getenv("HOME") .. "/.vim/tmp/undo/"
set.directory = os.getenv("HOME") .. "/.vim/tmp/swap/"
set.backup = true
set.swapfile = false

set.termguicolors = true
