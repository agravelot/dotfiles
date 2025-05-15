return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "mason-org/mason.nvim" },
    ---@class PluginLspOpts
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "typos_lsp",
      })
    end,
    config = function()
      require("lspconfig").typos_lsp.setup({
        -- cmd = { "typos-lsp" },
        -- filetypes = { "markdown", "tex" },
        -- root_dir = require("lspconfig").util.root_pattern(".git", ".git/", "package.json"),
        init_options = {
          diagnosticSeverity = "Hint",
        },
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "typos-lsp",
      })
    end,
  },
}
