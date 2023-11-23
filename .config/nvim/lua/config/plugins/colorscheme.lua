return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function ()
    require('catppuccin').setup({
      flavor = 'frappe',
      background = {
        light = "latte",
        dark = "frappe",
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        which_key = true,
      }
    })
    vim.cmd.colorscheme 'catppuccin'
  end
}
