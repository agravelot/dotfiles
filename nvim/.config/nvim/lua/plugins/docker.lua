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
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {
  --       "docker-compose-language-service",
  --       "dockerfile-language-server",
  --     })
  --   end,
  -- },
  -- {
  --   "williamboman/mason-lspconfig",
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
    -- :Telescope docker containers
    -- :Telescope docker images
    -- :Telescope docker networks
    -- :Telescope docker volumes
    -- :Telescope docker contexts
    -- :Telescope docker swarm
    -- :Telescope docker machines
    -- :Telescope docker compose
    -- :Telescope docker files
    keys = {
      { "<leader>DD", "<cmd>Telescope docker<cr>", desc = "[D]ocker" },
      {
        "<leader>Dc",
        "<cmd>Telescope docker containers<cr>",
        desc = "Docker [c]ontainers",
      },
      {
        "<leader>DC",
        "<cmd>Telescope docker compose<cr>",
        desc = "Docker [C]ompose",
      },
      {
        "<leader>Di",
        "<cmd>Telescope docker images<cr>",
        desc = "Docker [i]mages",
      },
      {
        "<leader>Dn",
        "<cmd>Telescope docker networks<cr>",
        desc = "Docker [n]etworks",
      },
      {
        "<leader>Dv",
        "<cmd>Telescope docker volumes<cr>",
        desc = "Docker [v]olumes",
      },
      {
        "<leader>Df",
        "<cmd>Telescope docker files<cr>",
        desc = "Docker [f]iles",
      },
      {
        "<leader>Ds",
        "<cmd>Telescope docker swarm<cr>",
        desc = "Docker [s]warm",
      },
      {
        "<leader>Dm",
        "<cmd>Telescope docker machines<cr>",
        desc = "Docker [m]achines",
      },
      {
        "<leader>Dx",
        "<cmd>Telescope docker contexts<cr>",
        desc = "Docker conte[x]ts",
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>D"] = { name = "+Docker" },
      },
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
