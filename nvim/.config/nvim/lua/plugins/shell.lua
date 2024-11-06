return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "fish",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- "bash-language-server",
        "beautysh",
      })
    end,
  },
  {
    "williamboman/mason-lspconfig",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    ---@class PluginLspOpts
    opts = {
      ensure_installed = {
        "bashls",
      },
    },
  },
}
