local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

local plugins = {
  "preservim/nerdcommenter",
  "tpope/vim-fugitive",
  { "fatih/vim-go", build = ":GoUpdateBinaries" },
  "Chiel92/vim-autoformat",
  "airblade/vim-gitgutter",
  "nvim-tree/nvim-web-devicons",
  "tpope/vim-surround",
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },

-- Themes/Colorscheme
  "nvim-lualine/lualine.nvim",
  { "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons"
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end
  },

-- Navigation
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-fzy-native.nvim",
  "kyazdani42/nvim-tree.lua",

-- Languages
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "nvim-treesitter/playground",
  { "folke/neodev.nvim", opts = {}},
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  { "hrsh7th/cmp-path", branch = "main" },
  { "hrsh7th/cmp-buffer", branch = "main" },
  "hrsh7th/vim-vsnip",
  {
    "chikko80/error-lens.nvim",
    event = "BufRead",
    dependencies = {
        "nvim-telescope/telescope.nvim"
    },
    opts = {},
  },
  {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
    }
  },

-- Debugging
  "mfussenegger/nvim-dap",
  "leoluz/nvim-dap-go",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "nvim-telescope/telescope-dap.nvim",
  { "mxsdev/nvim-dap-vscode-js", dependencies = {"mfussenegger/nvim-dap"} },

-- JavaScript, TypeScript, React
  "jose-elias-alvarez/null-ls.nvim",
  "MunifTanjim/prettier.nvim",

-- Misc.
  "mbbill/undotree",
  { "mg979/vim-visual-multi", branch = "master" },
  "onsails/lspkind-nvim",
  "andweeb/presence.nvim",
}

require("lazy").setup(plugins, opts)
