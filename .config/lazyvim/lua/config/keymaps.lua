-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for moving highlighted Block
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<leader>sf", LazyVim.pick("files"), { desc = "Search Files (Root Dir)" })

-- paste word without loosing current copied word
-- This deletes the highlighted word into the void register and then pastes
map("x", "<leader>p", [["_dP]], { desc = "Paste without loosing current word" })
map("v", "<leader>d", [["_d]], { desc = "Delete without loosing current word" })
map("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Word from current Cursor" })
