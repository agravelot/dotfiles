return {
  { -- scrollbar with information
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    init = function()
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        desc = "User: Define `SatelliteQuickfix` hlgroup",
        callback = function()
          vim.api.nvim_set_hl(0, "SatelliteQuickfix", { link = "DiagnosticSignInfo" })
        end,
      })
    end,
    opts = {
      winblend = 10, -- little transparency, since hard to see in many themes otherwise
      handlers = {
        cursor = { enable = false },
        marks = { enable = false }, -- prevents buggy mark mappings
        quickfix = { enable = true },
      },
    },
  },
}
