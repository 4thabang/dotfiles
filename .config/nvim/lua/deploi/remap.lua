vim.g.mapleader = " "

-- Insert
vim.keymap.set("i", "jj", "<Esc>")

-- Normal Mode
vim.keymap.set("n", "<Tab>", vim.cmd.bnext)
vim.keymap.set("n", "<S-Tab>", vim.cmd.bprev)
vim.keymap.set("n", "<C-s>", "ysw") -- Vim Surround Single Word Wrap
vim.keymap.set("n", "<Leader>+", "<cmd> vertical resize +5")
vim.keymap.set("n", "<Leader>-", "<cmd>vertical resize -5")

vim.keymap.set("n", "<Leader>k", vim.cmd.Autoformat)
vim.keymap.set("n", "<Leader>d", vim.cmd.bd)
vim.keymap.set("n", "<Leader>bd", "<cmd>bp\\|bd #")
vim.keymap.set("n", "<Leader>o", "o<Esc>")
vim.keymap.set("n", "<Leader>p", "O<Esc>")

vim.keymap.set("n", "<Leader>P", vim.cmd.Prettier)
vim.keymap.set("n", "<Leader>w", vim.cmd.w)
vim.keymap.set("n", "<Leader>y", "\"*y")
vim.keymap.set("n", "<Leader>ut", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<Leader>q", vim.cmd.q)

vim.keymap.set("n", "gb", vim.cmd.BufferLinePick, { silent = true })

vim.keymap.set("n", "<Leader>gc", "<cmd>Git commit")
vim.keymap.set("n", "<Leader>gp", "<cmd>Git push")
vim.keymap.set("n", "<Leader>G", vim.cmd.G)

vim.keymap.set("n", "<Leader>n", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<Leader>nf", vim.cmd.NvimTreeFindFile)

-- Visual Mode
vim.keymap.set("v", "<Leader>y", "\"*y")
