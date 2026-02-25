return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "nvim-lua/plenary.nvim",
  },
  optional = true,
  opts = function(_, opts)
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    opts.sources = vim.list_extend(opts.sources or {}, {
      require("none-ls.diagnostics.ruff").with({
        filetypes = { "python" },
        extra_args = { "--select=E,F,W,I,C90" },
      }),
      require("none-ls.formatting.ruff").with({
        filetypes = { "python" },
        extra_args = { "--fix" },
      }),
      formatting.shfmt,
      formatting.prettier,
      formatting.biome,
      formatting.stylua,
      formatting.rustywind,
      formatting.scalafmt,
      formatting.sqlfluff.with({
        extra_args = { "--dialect", "postgres" }, -- change to your dialect
      }),

      formatting.biome.with({
        filetypes = { "typescriptreact", "javascriptreact", "typescript", "javascript", "json" },
        condition = function(utils)
          return utils.root_has_file({ "biome.json" })
        end,
      }),

      formatting.prettier.with({
        filetypes = { "typescriptreact", "javascriptreact", "typescript", "javascript", "json" },
        condition = function(utils)
          return utils.root_has_file({
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.config.js",
            ".prettierrc.ts",
            ".prettierrc.config.ts",
          })
        end,
      }),

      formatting.stylua.with({
        filetypes = { "lua" },
      }),

      formatting.rustywind.with({
        filetypes = { "typescriptreact", "javascriptreact" },
      }),

      null_ls.builtins.code_actions.gitsigns,
    })
  end,
}
