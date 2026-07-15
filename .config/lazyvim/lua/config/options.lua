-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_ts_lsp = "tsgo"
vim.g.lazyvim_prettier_needs_config = true

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
