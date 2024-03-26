return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      -- Show hidden files
      -- opts.filesystem.filtered_items.hide_dotfiles = false
      opts.window.width = 25
      opts.filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          always_show = {
            ".gitignored",
            ".env",
            ".env*",
          },
        },
      }
    end,
  },
}
