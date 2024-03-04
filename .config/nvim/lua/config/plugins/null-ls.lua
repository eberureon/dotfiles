local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
  'nvimtools/none-ls.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function ()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.biome,
        -- or if you like to live dangerously like me:
        -- null_ls.builtins.formatting.biome.with({
        --   args = {
        --     'check',
        --     '--apply-unsafe',
        --     '--formatter-enabled=true',
        --     '--organize-imports-enabled=true',
        --     '--skip-errors',
        --     '$FILENAME',
        --   },
        -- }),
        null_ls.builtins.code_actions.gitsigns,
      },
      on_attach = function(client, bufnr)
        -- auto formatting on save
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end
    })
  end,
}

