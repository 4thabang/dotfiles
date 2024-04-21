local dap = require('dap')
local dapui = require('dapui')
local dap_go = require('dap-go')
local mason = require('mason')
local dap_virtual_text = require('nvim-dap-virtual-text')
local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local dapjs = require('dap-vscode-js')
local lspkind = require("lspkind")

dapui.setup()
dap_go.setup()
dap_virtual_text.setup({})
mason.setup()

lspconfig.eslint.setup {
  experimental = {
    useFlatConfig = true
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll"
    })
  end,
  settings = {
    workingDirectory = { mode = 'location' },
    eslint = {
      rootPath = vim.fn.getcwd(),
      workingDirectories = {
        vim.fn.getcwd(),
        vim.fn.getcwd() .. "/apps/nuxt"
      }
    }
  },
}

vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.shortmess = "c"
vim.opt.updatetime = 300

-- Debugging Adapter Protocol Keymap
vim.keymap.set("n", "<Leader>c", "<cmd>lua require('dap').continue()<CR>")
vim.keymap.set("n", "<Leader>so", "<cmd>lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<Leader>si", "<cmd>lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<Leader>sto", "<cmd>lua require('dap').step_out()<CR>")
vim.keymap.set("n", "<Leader>b", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set("n", "<Leader>tui", "<cmd>lua require('dapui').toggle()<CR>")

-- Hover diagnostics - Disable if not needed
vim.o.updatetime = 250 -- Time to hover before displaying
vim.cmd [[
autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
]]

local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.rs", "*.ts"},
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr}
  vim.keymap.set("n", "<Leader>hd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<Leader>hi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "<Leader>hr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<Leader>h", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<Leader>hrn", function() vim.lsp.buf.rename() end, opts)
end)

-- (Optional) Configure lua language server for neovim
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
lsp.ensure_installed({
  "gopls",
  "rust_analyzer",
  "tsserver",
  "eslint",
  "pyright",
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

dapjs.setup({
  node_path = '/Users/thabang/.nvm/versions/node/v18.14.2/bin/node',
  log_file_path = '/dev/null',
  log_file_level = 0,
  log_console_level = 0,
  debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
  debugger_cmd = { "js-debug-adapter" },
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    }
  }
end
