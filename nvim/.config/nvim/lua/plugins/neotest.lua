return {
  -- {
  --   "nvim-neotest/neotest",
  --   keys = {
  --     {
  --       "<leader>tl",
  --       function()
  --         require("neotest").run.run_last()
  --       end,
  --       desc = "Run Last Test",
  --     },
  --     {
  --       "<leader>tL",
  --       function()
  --         require("neotest").run.run_last({ strategy = "dap" })
  --       end,
  --       desc = "Debug Last Test",
  --     },
  --     {
  --       "<leader>tw",
  --       "<cmd>lua require('neotest').run.run()<cr>",
  --       desc = "Run Watch",
  --     },
  --   },
  -- },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    keys = {
      {
        "<leader>tw",
        "<cmd>lua require('neotest').run.run({ jestCommand = 'node_modules/.bin/jest --watch ' })<cr>",
        -- "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
        desc = "Run Watch",
      },
    },
    opts = function(_, opts)
      -- TODO conditional if jest or vitest
      opts.adapters = opts.adapters or {}
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          -- jestCommand = "npm run test --",
          -- jestConfigFile = "test/jest-e2e.json",
          -- env = { CI = true },
          jest_test_discovery = false,
          discovery = {
            enabled = true,
          },
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )
      -- table.insert(opts.adapters, require("neotest-vitest"))
      -- table.insert(opts.adapters, require("neotest-golang"))
      -- table.insert(
      --   opts.adapters,
      --   require("neotest-go")({
      --     experimentral = {
      --       test_table = true,
      --     },
      --   })
      -- )
    end,
  },
}
