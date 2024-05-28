return {
  {
    "williamboman/mason-lspconfig",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    ---@class PluginLspOpts
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "typos_lsp",
      })
    end,
  },
}
