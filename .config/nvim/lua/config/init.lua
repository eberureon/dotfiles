require('config.keymaps')
require('config.options')

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
require('lazy').setup({
  -- Game to Learn Vim
  'ThePrimeagen/vim-be-good',

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'f-person/git-blame.nvim',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {
    -- Set lualine as statusline
    -- See `:help lualine.txt`
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- enable `lukas-reineke/indent-blankline.nvim`
    -- see `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numtostr/comment.nvim', opts = {} },

  -- import plugins, configuration etc from `lua/config/plugins/*.lua`
  -- for additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'config.plugins' },
}, {})

-- [[ highlight on yank ]]
-- see `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('yankhighlight', { clear = true })
vim.api.nvim_create_autocmd('textyankpost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- the line beneath this is called `modeline`. see `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
