return {
  "nvimtools/none-ls.nvim",
  config = function()
    local nls = require("null-ls")
    local sources = {
      nls.builtins.formatting.stylua,
    }

    -- Check if Prettier config or package.json with prettier is present
    local has_prettier_config = function()
      local config_files = {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettierrc.yaml",
        ".prettierrc.yml",
        ".prettierrc.toml",
        "prettier.config.js",
        "prettier.config.cjs",
      }
      for _, file in ipairs(config_files) do
        if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. file) == 1 then
          return true
        end
      end
      return false
    end

    local has_prettier_dependency = function()
      local package_json = vim.fn.getcwd() .. "/package.json"
      if vim.fn.filereadable(package_json) == 1 then
        local content = vim.fn.readfile(package_json)
        local ok, json = pcall(vim.fn.json_decode, table.concat(content, "\n"))
        if ok and json then
          local deps = vim.tbl_extend("force", json.dependencies or {}, json.devDependencies or {})
          return deps["prettier"] ~= nil
        end
      end
      return false
    end

    if has_prettier_config() or has_prettier_dependency() then
      table.insert(sources, nls.builtins.formatting.prettier)
    end

    nls.setup({ sources = sources })
  end,
}
