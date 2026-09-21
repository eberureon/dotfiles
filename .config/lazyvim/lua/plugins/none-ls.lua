return {
  "nvimtools/none-ls.nvim",
  event = "LazyFile",
  dependencies = {
    "mason.nvim",
    "nvimtools/none-ls-extras.nvim",
    "nvim-lua/plenary.nvim",
  },
  init = function()
    LazyVim.on_very_lazy(function()
      -- register the formatter with LazyVim
      LazyVim.format.register({
        name = "none-ls.nvim",
        priority = 200, -- set higher than conform, the builtin formatter
        primary = true,
        format = function(buf)
          return LazyVim.lsp.format({
            bufnr = buf,
            filter = function(client)
              return client.name == "null-ls"
            end,
          })
        end,
        sources = function(buf)
          local ret = require("null-ls.sources").get_available(vim.bo[buf].filetype, "NULL_LS_FORMATTING") or {}
          return vim.tbl_map(function(source)
            return source.name
          end, ret)
        end,
      })
    end)
  end,
  opts = function(_, opts)
    local nls = require("null-ls")
    local formatting = nls.builtins.formatting
    opts.root_dir = opts.root_dir
      or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
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
      formatting.stylua,
      formatting.rustywind,
      formatting.sqlfluff.with({
        extra_args = { "--dialect", "postgres" }, -- change to your dialect
      }),

      formatting.biome.with({
        filetypes = { "typescriptreact", "javascriptreact", "typescript", "javascript", "json", "html" },
        condition = function(utils)
          return utils.root_has_file({ "biome.json", "biome.jsonc" })
        end,
      }),

      formatting.prettier.with({
        filetypes = { "typescriptreact", "javascriptreact", "typescript", "javascript", "json", "html" },
        condition = function(utils)
          return utils.root_has_file({
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
          })
        end,
      }),

      formatting.stylua.with({
        filetypes = { "lua" },
      }),

      nls.builtins.code_actions.gitsigns,
    })
  end,
}
