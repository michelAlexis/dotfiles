-- Set lead to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20'


-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
vim.opt.colorcolumn = "100"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 50

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
