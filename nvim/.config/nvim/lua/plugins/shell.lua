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
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- "bash-language-server",
        "beautysh",
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "mason-org/mason.nvim" },
    ---@class PluginLspOpts
    opts = {
      ensure_installed = {
        "bashls",
      },
    },
  },
}
