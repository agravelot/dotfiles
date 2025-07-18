return {
  {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR 'ibhagwan/fzf-lua',
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        ssh_aliases = { ["work.github.com"] = "github.com" }, -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`. The key part will be interpreted as an anchored Lua pattern.
      })
    end,
    keys = {
      { "<leader>gu", "<cmd>Octo<cr>", desc = "Open Octo" },
      { "<leader>guh", "<cmd>Octo pr list<cr>", desc = "Open PR list" },
      { "<leader>guf", "<cmd>Octo issue list<cr>", desc = "Open Issue list" },
      { "<leader>gup", "<cmd>Octo pr create<cr>", desc = "Create PR" },
      { "<leader>gui", "<cmd>Octo issue create<cr>", desc = "Create Issue" },
    },
  },
}
