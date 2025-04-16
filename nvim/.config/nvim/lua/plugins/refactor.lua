-- vim.keymap.set("x", "<leader>re", ":Refactor extract ")
-- vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
--
-- vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
--
-- vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
--
-- vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
--
-- vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
-- vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- -- prompt for a refactor to apply when the remap is triggered
-- vim.keymap.set(
--     {"n", "x"},
--     "<leader>rr",
--     function() require('refactoring').select_refactor() end
-- )
-- -- Note that not all refactor support both normal and visual mode
-- --

-- load refactoring Telescope extension

-- vim.keymap.set({ "n", "x" }, "<leader>rr", function()
--   require("telescope").extensions.refactoring.refactors()
-- end)
--
return {
  --   "ThePrimeagen/refactoring.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function(_, opts)
  --     require("refactoring").setup(opts or {})
  --     require("telescope").load_extension("refactoring")
  --   end,
  --   keys = {
  --     { "x", "<leader>re", "<cmd>Refactor extract<cr>", desc = "Extract" },
  --     { "x", "<leader>rf", "<cmd>Refactor extract_to_file<cr>", desc = "Extract to File" },
  --     { "x", "<leader>rv", "<cmd>Refactor extract_var<cr>", desc = "Extract to Variable" },
  --     { "x", "<leader>ri", "<cmd>Refactor inline_var<cr>", desc = "Inline variable" },
  --     { "x", "<leader>rI", "<cmd>Refactor inline_func<cr>", desc = "Inline Function" },
  --     { "x", "<leader>rb", "<cmd>Refactor extract_block<cr>", desc = "Extract Block" },
  --     { "x", "<leader>rB", "<cmd>Refactor extract_block_to_file<cr>", desc = "Extract Block to File" },
  --     { "x", "<leader>rr", "<cmd>require('refactoring').select_refactor()<cr>", desc = "Select Refactor" },
  --   },
  --   {
  --     "folke/which-key.nvim",
  --     optional = true,
  --     opts = {
  --       defaults = {
  --         ["<leader>r"] = { name = "+refactor" },
  --       },
  --     },
  --   },
  {
    "ThePrimeagen/refactoring.nvim",
    opts = {
      -- prompt for return type
      prompt_func_return_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
      -- prompt for function parameters
      prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
      -- printf_statements = {},
      print_var_statements = {
        go = 'fmt.Printf("%s = %#v", %s)',
      },
      show_success_message = true,
    },
  },
  {
    "Wansmer/treesj",
    keys = {
      -- {
      --   "<leader>rs",
      --   "<cmd>TSJSplit<cr>",
      --   desc = "Split",
      -- },
      -- {
      --   "<leader>rj",
      --   "<cmd>TSJJoin<cr>",
      --   desc = "Join",
      -- },
      {
        "<leader>rt",
        "<cmd>TSJToggle<cr>",
        desc = "Toggle Split/Join Selection",
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    opts = {
      use_default_keymaps = false,
    },
    config = function(_, opts)
      require("treesj").setup(opts)
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    keys = {
      { "<leader>L", "", desc = "󰐪 Log" },
    },
  },
  { -- quickly add log statements
    "chrisgrieser/nvim-chainsaw",
    cmd = "ChainSaw",
    opts = {
      marker = "🖨️",
      logStatements = {
        objectLog = {
          lua = 'print("%s %s: " .. hs.inspect(%s))', -- Hammerspoon
          typescript = "new Notice(`%s %s: ${%s}`, 0)", -- Obsidian
          -- re-purposing `objectLog` for debugging via AppleScript notification
          zsh = [[osascript -e "display notification \"%s $%s\" with title \"%s\""]],
        },
        clearLog = {
          lua = "hs.console.clearConsole() -- %s", -- Hammerspoon
        },
        sound = {
          lua = 'hs.sound.getByName("Sosumi"):play() -- %s', -- Hammerspoon
          nvim_lua = 'vim.system({"osascript", "-e", "beep"}) -- %s', -- macOS only
        },
      },
    },
    keys = {
			-- stylua: ignore start
			{"<leader>Ll", function() require("chainsaw").variableLog() end, mode = {"n", "x"}, desc = "󰀫 variable" },
			{"<leader>Lo", function() require("chainsaw").objectLog() end, mode = {"n", "x"}, desc = "⬟ object" },
			{"<leader>La", function() require("chainsaw").assertLog() end, mode = {"n", "x"}, desc = "⁉️ assert" },
			{"<leader>Lt", function() require("chainsaw").typeLog() end, mode = {"n", "x"}, desc = "󰜀 type" },
			{"<leader>Lm", function() require("chainsaw").messageLog() end, desc = "󰦨 message" },
			{"<leader>Le", function() require("chainsaw").emojiLog() end, desc = "󰞅 emoji" },
			{"<leader>Ls", function() require("chainsaw").sound() end, desc = "󰂚 sound" },
			{"<leader>Lp", function() require("chainsaw").timeLog() end, desc = "󱎫 performance" },
			{"<leader>Ld", function() require("chainsaw").debugLog() end, desc = "󰃤 debugger" },
			{"<leader>L<down>", function() require("chainsaw").stacktraceLog() end, desc = " stacktrace" },
			{"<leader>Lk", function() require("chainsaw").clearLog() end, desc = "󰃢 clear console" },
			{"<leader>Lr", function() require("chainsaw").removeLogs() end, desc = "󰅗 remove logs" },
      -- stylua: ignore end
    },
  },
  -- { -- signature hints
  --   "ray-x/lsp_signature.nvim",
  --   -- event = "BufReadPre",
  --   -- opts = {
  --   --   hint_prefix = " 󰏪 ",
  --   --   floating_window = false,
  --   --   always_trigger = true,
  --   -- },
  --   event = "InsertEnter",
  --   opts = {
  --     hint_prefix = " 󰏪 ",
  --     hint_scheme = "Todo",
  --     bind = true,
  --     handler_opts = {
  --       border = "rounded",
  --     },
  --   },
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end,
  -- },
  -- { -- CodeLens
  --   "Wansmer/symbol-usage.nvim",
  --   event = "LspAttach",
  --   opts = {
  --     request_pending_text = false, -- remove "loading…"
  --     references = { enabled = true, include_declaration = false },
  --     definition = { enabled = false },
  --     implementation = { enabled = false },
  --     vt_position = "signcolumn",
  --     vt_priority = 5, -- below the gitsigns default of 6
  --     hl = { link = "Comment" },
  --     text_format = function(symbol)
  --       if not symbol.references or symbol.references == 0 then
  --         return
  --       end
  --       if symbol.references < 2 and vim.bo.filetype == "css" then
  --         return
  --       end
  --       if symbol.references > 99 then
  --         return ""
  --       end
  --
  --       local refs = tostring(symbol.references)
  --       local altDigits = { "󰎡", "󰎤", "󰎧", "󰎪", "󰎭", "󰎱", "󰎳", "󰎶", "󰎹", "󰎼" }
  --       for i = 0, #altDigits - 1 do
  --         refs = refs:gsub(tostring(i), altDigits[i + 1])
  --       end
  --       return refs
  --     end,
  --     -- available kinds: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
  --     kinds = {
  --       vim.lsp.protocol.SymbolKind.File,
  --       vim.lsp.protocol.SymbolKind.Function,
  --       vim.lsp.protocol.SymbolKind.Method,
  --       vim.lsp.protocol.SymbolKind.Class,
  --       vim.lsp.protocol.SymbolKind.Interface,
  --       vim.lsp.protocol.SymbolKind.Object,
  --       vim.lsp.protocol.SymbolKind.Array,
  --       vim.lsp.protocol.SymbolKind.Property,
  --     },
  --   },
  -- },
}
