return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
      python = { "ruff_format" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      lua = { "stylua" },
      sql = { "sqlfluff" },
      typescriptreact = { "biome", "prettierd", "eslint_d", "rustywind" },
      javascriptreact = { "biome", "prettierd", "eslint_d", "rustywind" },
      typescript = { "biome", "prettierd", "eslint_d", "rustywind" },
      javascript = { "biome", "prettierd", "eslint_d", "rustywind" },
      json = { "biome", "prettierd" },
      html = { "biome", "prettierd" },
      vue = { "prettierd", "eslint_d", "rustywind" },
      svelte = { "prettierd", "eslint_d", "rustywind" },
      astro = { "prettierd", "eslint_d", "rustywind" },
      css = { "rustywind" },
      scss = { "rustywind" },
    })

    opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
      ruff_format = {
        extra_args = { "--fix" },
      },
      sqlfluff = {
        args = { "format", "--dialect", "postgres", "-" },
      },
      biome = {
        condition = function(_, ctx)
          return require("conform.util").root_file({ "biome.json", "biome.jsonc" })(nil, ctx)
        end,
      },
      prettierd = {
        condition = function(_, ctx)
          return require("conform.util").root_file({
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.cjs",
            ".prettierrc.js",
            ".prettierrc.config.js",
            ".prettierrc.mjs",
            ".prettierrc.ts",
            ".prettierrc.config.ts",
            ".prettierrc.cts",
            ".prettierrc.mts",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
            "prettier.config.ts",
            "prettier.config.cts",
            "prettier.config.mts",
          })(nil, ctx)
        end,
      },
      eslint_d = {
        condition = function(_, ctx)
          return require("conform.util").root_file({
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
          })(nil, ctx)
        end,
      },
      rustywind = {
        command = "rustywind",
        args = { "--write", "$FILENAME" },
        stdin = false,
      },
    })
  end,
}
