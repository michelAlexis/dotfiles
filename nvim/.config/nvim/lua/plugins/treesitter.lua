return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup()

    require('nvim-treesitter').install({
      'lua',
      'javascript',
      'typescript',
      'tsx',
      'svelte',
      'vim',
      'vimdoc',
      'markdown',
      'markdown_inline',
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'lua',
        'javascript',
        'typescript',
        'typescriptreact',
        'svelte',
        'vim',
        'markdown',
      },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
