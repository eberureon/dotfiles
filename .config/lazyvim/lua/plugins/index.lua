return {
  {
    "gbprod/yanky.nvim",
    keys = {
      -- disable keymap in favor of a custom keymap
      { "<leader>p", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sR", false },
      {
        "<leader>sr",
        function()
          Snacks.picker.resume()
        end,
        desc = "Search Resume",
      },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<leader>sr", false },
    },

    -- properly setup lspconfig,treesitter, mason and typescript.nvim.
    { import = "lazyvim.plugins.extras.lang.typescript" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "graphql",
      })
    end,
  },
}
