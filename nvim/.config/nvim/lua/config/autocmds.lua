-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- always open quickfix window automatically.
-- this uses cwindows which will open it only if there are entries.
-- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
--   group = vim.api.nvim_create_augroup("AutoOpenQuickfix", { clear = true }),
--   pattern = { "[^l]*" },
--   command = "cwindow",
-- })

-- vim.api.nvim_add_user_command("CopyRelPath", "call setreg('+', expand('%'))", {})
--

local function file_exists_in_root(filename)
  local cwd = vim.fn.getcwd()
  local path = cwd .. "/" .. filename
  return vim.fn.filereadable(path) == 1
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    if file_exists_in_root("crd.yaml") then
      vim.keymap.set(
        "n",
        "<leader>cy",
        ":lua require('crd').init()<CR>",
        { silent = true, noremap = true, desc = "Close buffer", buffer = true }
      )
    end
  end,
})
