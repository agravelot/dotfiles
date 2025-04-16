return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      -- invert R <-> r
      { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>fR", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>sW", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
      { "<leader>sw", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
      { "<leader>sW", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>sw", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
    },
  },
}
