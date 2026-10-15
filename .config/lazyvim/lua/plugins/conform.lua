return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
      python = { "ruff_format" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      lua = { "stylua" },
      sql = { "sqlfluff" },
      javascript = { "oxfmt", "eslint_d" },
      javascriptreact = { "oxfmt", "eslint_d" },
      typescript = { "oxfmt", "eslint_d" },
      typescriptreact = { "oxfmt", "eslint_d" },
      angular = { "eslint_d" },
      htmlangular = { "eslint_d" },
      json = { "prettierd" },
      html = { "prettierd" },
      astro = { "prettierd", "eslint_d", "rustywind" },
      css = { "rustywind" },
      scss = { "rustywind" },
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
            "oxfmt.config.js",
            "oxfmt.config.mjs",
            "oxfmt.config.cjs",
            "oxfmt.config.ts",
            "oxfmt.config.mts",
            "oxfmt.config.cts",
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
}
