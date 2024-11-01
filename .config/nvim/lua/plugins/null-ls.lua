local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

return {
  'nvimtools/none-ls.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua.with {
          filetypes = { 'lua' },
        },
        null_ls.builtins.formatting.rustywind.with {
          filetypes = { 'typescriptreact', 'javascriptreact' },
        },
        null_ls.builtins.formatting.biome.with {
          filetypes = { 'typescriptreact', 'javascriptreact', 'typescript', 'javascript', 'json' },
          condition = function(utils)
            return utils.root_has_file { 'biome.json' }
          end,
        },
        null_ls.builtins.formatting.prettier.with {
          filetypes = { 'typescriptreact', 'javascriptreact', 'typescript', 'javascript', 'json' },
          condition = function(utils)
            return utils.root_has_file { '.prettierrc' }
          end,
        },
        null_ls.builtins.formatting.black.with {
          filetypes = { 'python' },
        },
        -- null_ls.builtins.formatting.biome.with {
        --   args = {
        --     'check',
        --     '--apply-unsafe',
        --     '--organize-imports-enabled=true',
        --     '--skip-errors',
        --     '$FILENAME',
        --   },
        -- },
        null_ls.builtins.code_actions.gitsigns,
        -- Java
        null_ls.builtins.diagnostics.checkstyle.with {
          extra_args = { '-c', '/google_checks.xml' }, -- or "/sun_checks.xml" or path to self written rules
        },
        null_ls.builtins.formatting.google_java_format.with {
          filetypes = { 'java' },
        },
      },
      on_attach = function(client, bufnr)
        -- auto formatting on save
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { bufnr = bufnr }
            end,
          })
        end
      end,
    }
  end,
}
