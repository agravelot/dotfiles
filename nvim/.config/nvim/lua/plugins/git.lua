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
    "mason-org/mason.nvim",
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
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      lazygit = {
        -- your lazygit configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        styles = {
          float = {
            width = 1,
            height = 1,
          },
        },
      },
    },
  },
  {
    "johnseth97/gh-dash.nvim",
    lazy = true,
    keys = {
      {
        "<leader>gd",
        function()
          require("gh_dash").toggle()
        end,
        desc = "Toggle gh-dash popup",
      },
    },
    opts = {
      keymaps = {}, -- disable internal mapping
      border = "rounded", -- or 'double'
      width = 1,
      height = 1,
      autoinstall = true,
    },
  },
}
