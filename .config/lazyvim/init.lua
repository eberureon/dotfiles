if vim.g.vscode then
  -- VSCode extension
  require("config.lazy")
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
