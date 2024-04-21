"syntax enable
filetype plugin indent on

set completeopt=menuone,noinsert,noselect
set shortmess+=c
set updatetime=300

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Language Server Protocol Keymap
nnoremap <leader>rh :RustHoverActions<CR>
nnoremap <leader>hd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>hi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>hr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>h :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>hrn :lua vim.lsp.buf.rename()<CR>

" Debugging Adapter Protocol Keymap
nnoremap <leader>c :lua require'dap'.continue()<CR>
nnoremap <leader>so :lua require'dap'.step_over()<CR>
nnoremap <leader>si :lua require'dap'.step_into()<CR>
nnoremap <leader>sto :lua require'dap'.step_out()<CR>
nnoremap <leader>b :lua require'dap'.toggle_breakpoint()<CR>

" Debugging Adapter Protocol UI Keymap
nnoremap <silent><leader>tui :lua require'dapui'.toggle()<CR>

lua <<EOF
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Debugging Adapter Protocol
local dap = require('dap')
require('dap-go').setup()
require('nvim-dap-virtual-text').setup()
require('dapui').setup()

-- Language Server Protocol
local nvim_lsp = require'lspconfig'

nvim_lsp.pyright.setup{}

nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

--[[ #### Commented out incase I need it again.
nvim_lsp.rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {
      workspace = {
        symbol = {
          search = {
            kind = "all_symbols"
          }
        }
      }
    },
  }
}
]]--


nvim_lsp.gopls.setup {
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

require'nvim-treesitter.configs'.setup{
  highlight = {
    enable = true
  }
}

require("nvim-tree").setup({
  filters = {
    custom = {},
    dotfiles = true,
  },
  
  open_on_tab = true,
  disable_netrw = false,
  hijack_netrw = false,

  actions = {
    open_file = {
      quit_on_open = true,
    },
  },

  update_focused_file = {
    enable = true,
  },

  view = {
    width = 40,
    side = "left",
  },

  renderer = {
    highlight_git = true,
    add_trailing = true,
    group_empty = true,
    root_folder_modifier = ":~",
    indent_markers = {
      enable = true,
    },

  icons = {
    show = {
      file = true,
      folder = true,
      git = true,
    },

    glyphs = {
      default = '',                                                              
      symlink = '',                                                              
      git = {                                                                    
        unstaged = "✗",                                                           
        staged = "✓",                                                             
        unmerged = "",                                                           
        renamed = "➜",                                                            
        untracked = "★"                                                           
      },                                                                         
      folder = {                                                                  
        default = "",                                                            
        open = "",                                                               
        empty = "",                                                              
        empty_open = "",                                                         
        symlink = "",                                                            
        symlink_open = "", 
      },
    },
  },
}})

local function open_nvim_tree(data)

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not no_name and not directory then
    return
  end

  -- change to the directory
  if directory then
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

nvim_lsp.yamlls.setup{}

nvim_lsp.bashls.setup{}

nvim_lsp.tsserver.setup{}

nvim_lsp.eslint.setup{}

nvim_lsp.tailwindcss.setup{}

nvim_lsp.luau_lsp.setup{}

nvim_lsp.vimls.setup{}

local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.diagnostics.fish
  }
})

local status, prettier = pcall(require, "prettierd")
if (not status) then return end

prettier.setup {
  bin = 'prettierd',
  filetypes = {
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "scss",
    "less"
  }
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})
EOF

lua <<EOF
local cmp = require'cmp'
local lspkind = require("lspkind")

cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  formatting = {
    format = lspkind.cmp_format({

    mode = 'symbol',

    before = function(entry, vim_item)
      -- vim_item.kind = lspkind.presets.default[vim_item.kind]
      vim_item.menu = ({
            nvim_lsp = "[LSP]",
            look = "[Dict]",
            buffer = "[Buffer]",
          })[entry.source.name]
      return vim_item
    end
    }) 
  },

  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },


  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF
