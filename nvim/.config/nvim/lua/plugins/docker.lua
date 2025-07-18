return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, {
  --       "dockerfile",
  --     })
  --   end,
  -- },
  -- {
  --   "mason-org/mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {
  --       "docker-compose-language-service",
  --       "dockerfile-language-server",
  --     })
  --   end,
  -- },
  -- {
  --   "mason-org/mason-lspconfig.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, {
  --       "dockerls",
  --       "docker_compose_language_service",
  --     })
  --   end,
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   ---@class PluginLspOpts
  --   opts = {
  --     ---@type lspconfig.options
  --     ensure_installed = {
  --       -- "dockerls",
  --       "docker_compose_language_service",
  --     },
  --   },
  -- },
  {
    "lpoto/telescope-docker.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("docker")
    end,
    keys = {
      { "<leader>OD", "<cmd>Telescope docker<cr>", desc = "d[O]cker" },
      {
        "<leader>Oc",
        "<cmd>Telescope docker containers<cr>",
        desc = "Docker [c]ontainers",
      },
      {
        "<leader>OC",
        "<cmd>Telescope docker compose<cr>",
        desc = "Docker [C]ompose",
      },
      {
        "<leader>Oi",
        "<cmd>Telescope docker images<cr>",
        desc = "Docker [i]mages",
      },
      {
        "<leader>On",
        "<cmd>Telescope docker networks<cr>",
        desc = "Docker [n]etworks",
      },
      {
        "<leader>Ov",
        "<cmd>Telescope docker volumes<cr>",
        desc = "Docker [v]olumes",
      },
      {
        "<leader>Of",
        "<cmd>Telescope docker files<cr>",
        desc = "Docker [f]iles",
      },
      {
        "<leader>Os",
        "<cmd>Telescope docker swarm<cr>",
        desc = "Docker [s]warm",
      },
      {
        "<leader>Om",
        "<cmd>Telescope docker machines<cr>",
        desc = "Docker [m]achines",
      },
      {
        "<leader>Ox",
        "<cmd>Telescope docker contexts<cr>",
        desc = "Docker conte[x]ts",
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    keys = {
      { "<leader>O", "", desc = "Docker" },
    },
  },
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          import = {
            insert_at_top = false,
            custom_languages = {
              -- Golang
              {
                regex = [[^\t(\".*\")|^import (\".*\")]],
                filetypes = { "go" },
                extensions = { "go" },
              },
            },
          },
        },
      })
      require("telescope").load_extension("import")
    end,
    keys = {
      {
        "<leader>ci",
        "<cmd>Telescope import<cr>",
        desc = "Telescope [i]mport",
      },
    },
  },
}
