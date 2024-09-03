-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  opts = {},

  config = function()
    -- document existing key chains
    local wk = require 'which-key'

    wk.add {
      { '<leader>c',  group = 'Code' },
      { '<leader>c_', hidden = true },
      { '<leader>d',  group = 'Document / Debug' },
      { '<leader>d_', hidden = true },
      { '<leader>g',  group = 'Git' },
      { '<leader>g_', hidden = true },
      { '<leader>gt',  group = '[G]it Toggle' },
      { '<leader>gt_',  hidden = true },
      { '<leader>h',  group = 'More [G]it' },
      { '<leader>h_', hidden = true },
      { '<leader>r',  group = '[R]ename' },
      { '<leader>r_', hidden = true },
      { '<leader>s',  group = '[S]earch' },
      { '<leader>s_', hidden = true },
      { '<leader>w',  group = '[W]orkspace' },
      { '<leader>w_', hidden = true },
    }
  end,
}
