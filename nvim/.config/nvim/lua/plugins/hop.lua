vim.api.nvim_set_keymap("n", "<leader>hw", "<cmd>HopWord<cr>", { noremap = true, silent = true, desc = "Hop [W]ord" })
vim.api.nvim_set_keymap("n", "<leader>hc", "<cmd>HopChar1<cr>", { noremap = true, silent = true, desc = "Hop [C]har" })
vim.api.nvim_set_keymap(
  "n",
  "<leader>hC",
  "<cmd>HopChar2<cr>",
  { noremap = true, silent = true, desc = "Hop [C]har 2" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>hp",
  "<cmd>HopPattern<cr>",
  { noremap = true, silent = true, desc = "Hop [P]attern" }
)
vim.api.nvim_set_keymap("n", "<leader>hl", "<cmd>HopLine<cr>", { noremap = true, silent = true, desc = "Hop Line" })
vim.api.nvim_set_keymap(
  "n",
  "<leader>hl",
  "<cmd>HopAnywhere<cr>",
  { noremap = true, silent = true, desc = "Hop Anywhere" }
)

return {
  "smoka7/hop.nvim",
  version = "v2",
  opts = {},
}
