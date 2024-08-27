return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map({ 'n', 'v' }, ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Jump to next hunk' })

      map({ 'n', 'v' }, '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Jump to previous hunk' })

      -- Actions
      -- visual mode
      map('v', '<leader>gs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Stage git hunk' })
      map('v', '<leader>gr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Reset git hunk' })
      -- normal mode
      map('n', '<leader>gs', gs.stage_hunk, { desc = '[G]it stage hunk' })
      map('n', '<leader>gr', gs.reset_hunk, { desc = '[G]it reset hunk' })
      map('n', '<leader>gS', gs.stage_buffer, { desc = '[G]it Stage buffer' })
      map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
      map('n', '<leader>gR', gs.reset_buffer, { desc = '[G]it Reset buffer' })
      map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview [G]it hunk' })
      map('n', '<leader>gb', function()
        gs.blame_line { full = false }
      end, { desc = '[G]it blame line' })
      map('n', '<leader>gd', gs.diffthis, { desc = '[G]it diff against index' })
      map('n', '<leader>gD', function()
        gs.diffthis '~'
      end, { desc = '[G]it diff against last commit' })

      -- Toggles
      map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = 'Toggle [G]it blame line' })
      map('n', '<leader>gtd', gs.toggle_deleted, { desc = 'Toggle [G]it show deleted' })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select [G]it hunk' })
    end,
  },
}
