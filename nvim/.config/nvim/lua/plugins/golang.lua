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
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        gofmt = "gofumpt", -- gofmt through gopls: alternative is gofumpt, goimports, golines, gofmt, etc
        trouble = true,
        luasnip = true,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    keys = {
      { "<leader>cta", "<cmd>GoAddTag<cr>", desc = "Add Tag" },
      { "<leader>cta", "<cmd>GoRmTag<cr>", desc = "Remove Tag" },
      { "<leader>cR", "<cmd>GoRename<cr>", desc = "Rename 2" },
      { "<leader>cfs", "<cmd>GoFillStruct<cr>", desc = "Fill Struct" },
      { "<leader>cfS", "<cmd>GoFillSwitch<cr>", desc = "Fill Switch" },
      { "<leader>cv", "<cmd>GoVet<cr>", desc = "Run Go Vet" },
      { "<leader>cL", "<cmd>GoLint<cr>", desc = "Run Linter" },
      { "<leader>cD", "<cmd>GoDoc<cr>", desc = "Show Documentation" },
      { "<leader>ci", "<cmd>GoImpl<cr>", desc = "Implement" },
    },
  },
}
