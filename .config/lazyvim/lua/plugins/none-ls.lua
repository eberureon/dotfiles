return {
  "nvimtools/none-ls.nvim",
  optional = true,
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.sources = opts.sources or {}
    table.insert(
      opts.sources,
      nls.builtins.formatting.biome.with({
        filetypes = { "typescriptreact", "javascriptreact", "typescript", "javascript", "json" },
        condition = function(utils)
          return utils.root_has_file({ "biome.json" })
        end,
      })
    )
    table.insert(
      opts.sources,
      nls.builtins.formatting.prettier.with({
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
      })
    )
  end,
}
