local function find_node_path()
  local paths = {
    "/opt/homebrew/Cellar/node/25.2.1/bin/node",
    "/opt/homebrew/bin/node",
    "/usr/local/bin/node",
    "/usr/bin/node",
  }

  for _, path in ipairs(paths) do
    if vim.loop.fs_stat(path) then
      return path
    end
  end

  return "node"
end

return {
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      copilot_node_command = find_node_path(), -- solution bypass volta shims
    },
  },
}
