return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "blade-formatter",
        "css-lsp",
        "diagnostic-languageserver",

        "gofumpt",
        "delve",
        "goimports-reviser",
        -- "goimports"
        "golangci-lint-langserver",
        "golangci-lint",
        "golines",
        "gopls",
        "gotestsum",
        "templ",

        "html-lsp",
        "nginx-language-server",
        "sqlfluff",
        "yaml-language-server",
      })
    end,
  },
}
