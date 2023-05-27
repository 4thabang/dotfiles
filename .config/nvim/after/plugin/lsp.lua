require('dap')
require('dapui').setup()
require('dap-go').setup()
require('mason').setup()
require('nvim-dap-virtual-text').setup({})

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

-- vim.o.updatetime = 250
-- vim.cmd [[
--  autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
-- ]]

local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.rs", "*.ts"},
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr}
  vim.keymap.set("n", "<Leader>hd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<Leader>hi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "<Leader>hr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<Leader>h", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<Leader>hrn", function() vim.lsp.buf.rename() end, opts)
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
lsp.ensure_installed({
  "gopls",
  "rust_analyzer",
  "tsserver",
  "eslint",
  "pyright",
})

local status, prettier = pcall(require, "prettier")
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

local cmp = require("cmp")

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


--[[
   [local status, null_ls = pcall(require, "null-ls")
   [if (not status) then return end
   [
   [null_ls.setup({
   [  sources = {
   [    null_ls.builtins.diagnostics.eslint_d.with({
   [      diagnostics_format = '[eslint] #{m}\n(#{c})'
   [    }),
   [  }
   [})
   [
   [local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
   [require("null-ls").setup({
   [    on_attach = function(client, bufnr)
   [        if client.supports_method("textDocument/formatting") then
   [            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
   [            vim.api.nvim_create_autocmd("BufWritePre", {
   [                group = augroup,
   [                buffer = bufnr,
   [                callback = function()
   [                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
   [                    vim.lsp.buf.formatting_sync()
   [                end,
   [            })
   [        end
   [    end,
   [})
   ]]

