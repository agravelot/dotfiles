return {
  -- {
  --   "nvim-cmp",
  --   dependencies = { "hrsh7th/cmp-buffer", "davidsierradz/cmp-conventionalcommits" },
  --   opts = function(_, opts)
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, { name = "conventionalcommits" })
  --   end,
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitignore",
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "gh",
        "actionlint",
        "commitlint",
        "gitlint",
      })
    end,
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "telescope.nvim" },
    config = function()
      require("telescope").load_extension("git_worktree")
    end,
  },
}
