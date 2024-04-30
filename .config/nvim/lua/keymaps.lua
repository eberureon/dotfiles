-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map('n', '<leader>ex', vim.cmd.Ex, { desc = 'Exit to netrw' })

-- Go to next / previous item in quickfixlist / locationlist
map('n', '<C-j>', '<cmd>cnext<CR>zz')
map('n', '<C-k>', '<cmd>cprev<CR>zz')
map('n', '<leader>k', '<cmd>lnext<CR>zz')
map('n', '<leader>j', '<cmd>lprev<CR>zz')

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for moving highlighted Block
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Remain cursor in middle while half page jumping
map('n', '<C-d>', '<C-d>zz')
map('n', 'C-u>', '<C-u>zz')

-- paste word without loosing current copied word
-- This deletes the highlighted word into the void register and then pastes
map('x', '<leader>p', [["_dP]], { desc = 'Copy without loosing current word' })
map({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without loosing current word' })
map('n', '<leader>rs', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = '[R]eplace word from current Cursor' })

-- next greatest remap ever : asbjornHaland
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'Copy current Line to system clipboard' })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
