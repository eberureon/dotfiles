local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

return {
  'nvimtools/none-ls.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local nls = require 'null-ls'
    nls.setup {
      sources = {
        nls.builtins.formatting.stylua.with {
          filetypes = { 'lua' },
        },
        nls.builtins.formatting.rustywind.with {
          filetypes = { 'typescriptreact', 'javascriptreact' },
        },
        nls.builtins.formatting.biome.with {
          filetypes = { 'typescriptreact', 'javascriptreact', 'typescript', 'javascript', 'json' },
          condition = function(utils)
            return utils.root_has_file { 'biome.json' }
          end,
        },
        nls.builtins.formatting.prettier.with {
          filetypes = { 'typescriptreact', 'javascriptreact', 'typescript', 'javascript', 'json' },
          condition = function(utils)
            return utils.root_has_file { '.prettierrc' }
          end,
        },
        nls.builtins.formatting.black.with {
          filetypes = { 'python' },
        },
        -- nls.builtins.formatting.biome.with {
        --   args = {
        --     'check',
        --     '--apply-unsafe',
        --     '--organize-imports-enabled=true',
        --     '--skip-errors',
        --     '$FILENAME',
        --   },
        -- },
        nls.builtins.code_actions.gitsigns,
        -- Java
        nls.builtins.diagnostics.checkstyle.with {
          extra_args = { '-c', '/google_checks.xml' }, -- or "/sun_checks.xml" or path to self written rules
        },
        nls.builtins.formatting.google_java_format.with {
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
