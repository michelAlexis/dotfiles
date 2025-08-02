-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Global ctrl+s to save
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>dl", function()
  local ok, loc = pcall(vim.fn.getloclist, 0, { winid = 1, size = 1 })
  if not ok or loc.size == 0 then
    vim.notify("No location list available", vim.log.levels.WARN)
    return
  end
  if loc.winid > 0 then
    vim.cmd("lclose")
  else
    vim.cmd("lopen")
  end
end, { desc = "Toggle Location List" })

-- Quickfix list
vim.keymap.set("n", "<leader>ll", function()
  local qf_winid = vim.fn.getqflist({ winid = 1 }).winid
  if qf_winid > 0 then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end, { desc = "Toggle Quickfix List" })
vim.keymap.set("n", "<leader>ln", "cnext", { desc = "Quickfix: Next" })
vim.keymap.set("n", "<leader>lp", "cprev", { desc = "Quickfix: Previous" })
