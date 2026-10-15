return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
      python = { "ruff_format" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      lua = { "stylua" },
      sql = { "sqlfluff" },
    })

    opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
      ["biome-check"] = {
        require_cwd = true,
        condition = function(_, ctx)
          return require("conform.util").root_file({
            "biome.json",
            "biome.jsonc",
            ".biome.json",
            ".biome.jsonc",
          })(nil, ctx)
        end,
      },
      oxfmt = {
        condition = function(_, ctx)
          return require("conform.util").root_file({
            ".oxfmtrc.json",
            ".oxfmtrc.jsonc",
            "oxfmt.config.ts",
            "vite.config.ts",
            "vite.config.js",
          })(nil, ctx)
        end,
      },
      ruff_format = {
        append_args = { "--fix" },
      },
      sqlfluff = {
        args = { "format", "--dialect", "postgres", "-" },
      },
      rustywind = {
        command = "rustywind",
        args = { "--write", "$FILENAME" },
        stdin = false,
      },
    })
  end,
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          root_dir = function(bufnr, on_dir)
            local root = vim.fs.root(bufnr, {
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs",
              "eslint.config.ts",
              "eslint.config.mts",
              "eslint.config.cts",
              ".eslintrc",
              ".eslintrc.js",
              ".eslintrc.cjs",
              ".eslintrc.yml",
              ".eslintrc.yaml",
              ".eslintrc.json",
            })
            if root then
              on_dir(root)
            end
          end,
        },
      },
    },
  },
}
