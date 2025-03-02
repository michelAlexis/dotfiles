return {
  "nvimtools/none-ls.nvim",
  config = function()
    local nls = require("null-ls")
    nls.setup({
      sources = {
        -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.prettier,
        -- nls.builtins.diagnostics.eslint_d,
      },
    })
  end,
}
