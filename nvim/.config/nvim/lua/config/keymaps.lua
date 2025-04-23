-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Move lines up and down, without changing the cursor position
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "yc", "yygcc", { remap = true, desc = "yank and comment" })
-- vim.keymap.set("n", "<leader>yC", function()
--   vim.cmd("normal! yy") -- Yank current line
--   vim.cmd("normal gcc") -- Comment it (plugin mapping)
-- end, { desc = "yank and comment", silent = true })

-- local nvim_tmux_nav = require("nvim-tmux-navigation")
-- vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
-- vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
-- vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
-- vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
-- vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
-- vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
--

-- Change package version
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.api.nvim_set_keymap(
      "n",
      "<leader>np",
      "<cmd>lua require('package-info').change_version()<cr>",
      { silent = true, noremap = true, desc = "Npm change package version" }
    )
  end,
})

vim.api.nvim_set_keymap(
  "n",
  "<leader>gw",
  "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
  { silent = true, noremap = true, desc = "Git [W]orktree" }
)

vim.keymap.set("n", "<leader>qq", ":q<CR>", { silent = true, noremap = true, desc = "Quit" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.keymap.set(
      "n",
      "<leader>cy",
      ":lua require('crd').init()<CR>",
      { silent = true, noremap = true, desc = "[y]aml schema import", buffer = true }
    )
  end,
})

-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>gw",
--   "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
--   { silent = true, noremap = true, desc = "Git [W]orktree" }
-- )
-- vim.keymap.set("n", "yC", "yygccp", { remap = true, desc = "Duplicate and comment" })
-- vim.keymap.set("n", "yC", "yygccp", { desc = "Duplicate and [c]omment", silent = true, noremap = true })
