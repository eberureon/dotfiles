return {
  "nvimtools/none-ls.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  optional = true,
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.formatting.prettier,
      nls.builtins.formatting.black,
      nls.builtins.formatting.biome,
      nls.builtins.diagnostics.fish,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.rustywind,
    })
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
    table.insert(
      opts.sources,
      nls.builtins.formatting.stylua.with({
        filetypes = { "lua" },
      })
    )
    table.insert(
      opts.sources,
      nls.builtins.formatting.rustywind.with({
        filetypes = { "typescriptreact", "javascriptreact" },
      })
    )
    table.insert(opts.sources, nls.builtins.code_actions.gitsigns)
  end,
}
