return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'marilari88/neotest-vitest',
      'nvim-neotest/neotest-jest',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          -- require 'neotest-vitest' {
          --   -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
          --   filter_dir = function(name, rel_path, root)
          --     return name ~= 'node_modules'
          --   end,
          -- },
          require 'neotest-jest' {
            cwd = function(path)
              return vim.fn.getcwd()
            end,
            env = { CI = true },
            jestCommand = 'npm run test:e2e --',
            -- jestConfigFile = 'test/jest.e2e.config.js',

            -- jestCommand = require('neotest-jest.jest-util').getJestCommand(vim.fn.expand '%:p:h') .. ' --watch',
          },
        },
      }

      -- Toggle summmary
      vim.api.nvim_set_keymap(
        'n',
        '<leader>tw',
        "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ', vitestCommand = 'vitest --watch' })<cr>",
        { desc = 'Run Watch' }
      )
      vim.api.nvim_set_keymap('n', '<leader>ts', "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = 'Summary' })
      vim.api.nvim_set_keymap('n', '<leader>ta', "<cmd>lua require('neotest').run.attach()<cr>", { desc = 'Attach' })
      vim.api.nvim_set_keymap('n', '<leader>tr', "<cmd>lua require('neotest').run.run()<cr>", { desc = 'Run' })
      vim.api.nvim_set_keymap('n', '<leader>tS', "<cmd>lua require('neotest').run.stop()<cr>", { desc = 'Stop' })
      vim.api.nvim_set_keymap('n', '<leader>to', "<cmd>lua require('neotest').output.open()<cr>", { desc = 'Output open' })
      vim.api.nvim_set_keymap('n', '<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = 'Run current file' })
    end,
  },
}
