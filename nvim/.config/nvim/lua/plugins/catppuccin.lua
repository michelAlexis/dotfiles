return {
  -- add catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd.colorscheme 'catppuccin-frappe'
    end
  },
}
