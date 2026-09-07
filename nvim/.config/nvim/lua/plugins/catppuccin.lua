return {
  -- add catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd.colorscheme 'catppuccin-frappe'

    -- Display the space and tabs
    local catppuccin_palette = require('catppuccin.palettes').get_palette()
    vim.opt.list = true
    vim.opt.listchars = {
        space = '·',
        tab = '│ ',
        trail = '·',
    }
    vim.api.nvim_set_hl(0, 'Whitespace', {
        fg = catppuccin_palette.overlay0,
    })
    end
  },
}
