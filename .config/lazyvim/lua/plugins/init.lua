return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      -- { "<leader>sr", false },
      -- {
      --   "<leader>sR",
      --   function()
      --     local grug = require("grug-far")
      --     local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
      --     grug.open({
      --       transient = true,
      --       prefills = {
      --         filesFilter = ext and ext ~= "" and "*." .. ext or nil,
      --       },
      --     })
      --   end,
      --   mode = { "n", "v" },
      --   desc = "Search and Replace",
      -- },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      -- { "<leader>sR", false },
      -- {
      --   "<leader>sr",
      --   function()
      --     Snacks.picker.resume()
      --   end,
      --   mode = "n",
      --   desc = "Resume",
      -- },
    },
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
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "prettierd",
      },
    },
  },
}
