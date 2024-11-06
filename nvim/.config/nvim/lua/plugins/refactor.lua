-- vim.keymap.set("x", "<leader>re", ":Refactor extract ")
-- vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
--
-- vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
--
-- vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
--
-- vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
--
-- vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
-- vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- -- prompt for a refactor to apply when the remap is triggered
-- vim.keymap.set(
--     {"n", "x"},
--     "<leader>rr",
--     function() require('refactoring').select_refactor() end
-- )
-- -- Note that not all refactor support both normal and visual mode
-- --

-- load refactoring Telescope extension

-- vim.keymap.set({ "n", "x" }, "<leader>rr", function()
--   require("telescope").extensions.refactoring.refactors()
-- end)
--
return {
  --   "ThePrimeagen/refactoring.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function(_, opts)
  --     require("refactoring").setup(opts or {})
  --     require("telescope").load_extension("refactoring")
  --   end,
  --   keys = {
  --     { "x", "<leader>re", "<cmd>Refactor extract<cr>", desc = "Extract" },
  --     { "x", "<leader>rf", "<cmd>Refactor extract_to_file<cr>", desc = "Extract to File" },
  --     { "x", "<leader>rv", "<cmd>Refactor extract_var<cr>", desc = "Extract to Variable" },
  --     { "x", "<leader>ri", "<cmd>Refactor inline_var<cr>", desc = "Inline variable" },
  --     { "x", "<leader>rI", "<cmd>Refactor inline_func<cr>", desc = "Inline Function" },
  --     { "x", "<leader>rb", "<cmd>Refactor extract_block<cr>", desc = "Extract Block" },
  --     { "x", "<leader>rB", "<cmd>Refactor extract_block_to_file<cr>", desc = "Extract Block to File" },
  --     { "x", "<leader>rr", "<cmd>require('refactoring').select_refactor()<cr>", desc = "Select Refactor" },
  --   },
  --   {
  --     "folke/which-key.nvim",
  --     optional = true,
  --     opts = {
  --       defaults = {
  --         ["<leader>r"] = { name = "+refactor" },
  --       },
  --     },
  --   },
  {
    "ThePrimeagen/refactoring.nvim",
    opts = {
      -- prompt for return type
      prompt_func_return_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
      -- prompt for function parameters
      prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
      -- printf_statements = {},
      print_var_statements = {
        go = 'fmt.Printf("%s = %#v", %s)',
      },
      show_success_message = true,
    },
  },
}
