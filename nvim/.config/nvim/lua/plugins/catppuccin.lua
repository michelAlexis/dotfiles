return {
  -- add catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "frappe",
    },
    config = function ()
      vim.cmd.colorscheme 'catppuccin'
    end
  },
}
