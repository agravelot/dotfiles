return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- auto_install = true,
      ensure_installed = {
        "bash",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- "bash-language-server",
        "beautysh",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      ensure_installed = {
        "bashls",
      },
    },
  },
}
