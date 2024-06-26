return {
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, {
  --       "blade-formatter",
  --       "css-lsp",
  --       "diagnostic-languageserver",
  --
  --       "gofumpt",
  --       "delve",
  --       "goimports-reviser",
  --       -- "goimports"
  --       -- "golangci-lint-langserver",
  --       -- "golangci-lint",
  --       "golines",
  --       -- "gopls",
  --       "gotestsum",
  --       -- "templ",
  --       -- "pbls",
  --
  --       "html-lsp",
  --       "fixjson",
  --       "revive",
  --       "nginx-language-server",
  --       "sqlfluff",
  --       "yaml-language-server",
  --     })
  --   end,
  -- },
  -- Ensure mapping ok
  -- {
  --   "williamboman/mason-lspconfig",
  --   dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
  --   ---@class PluginLspOpts
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, {
  --       "dotls",
  --       "sqlls",
  --       "templ",
  --       -- "gopls",
  --       "golangci_lint_ls",
  --       "htmx",
  --       "emmet_ls",
  --       "taplo", -- toml
  --       "yamlls",
  --       "vacuum", -- openapi
  --     })
  --   end,
  -- },
  -- {
  --   "ray-x/go.nvim",
  --   dependencies = { -- optional packages
  --     "ray-x/guihua.lua",
  --     "neovim/nvim-lspconfig",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("go").setup({
  --       gofmt = "gofumpt", -- gofmt through gopls: alternative is gofumpt, goimports, golines, gofmt, etc
  --       trouble = true,
  --       luasnip = true,
  --       lsp_codelens = true, -- set to false to disable codelens, true by default, you can use a function
  --       test_efm = true, -- errorfomat for quickfix, default mix mode, set to true will be efm only
  --     })
  --     -- Run gofmt + goimports on save
  --     -- local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
  --     -- vim.api.nvim_create_autocmd("BufWritePre", {
  --     --   pattern = "*.go",
  --     --   callback = function()
  --     --     require("go.format").goimports()
  --     --   end,
  --     --   group = format_sync_grp,
  --     -- })
  --   end,
  --   event = { "CmdlineEnter" },
  --   ft = { "go", "gomod" },
  --   build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  --   keys = {
  --     { "<leader>cta", "<cmd>GoAddTag<cr>", desc = "Add Tag" },
  --     { "<leader>cta", "<cmd>GoRmTag<cr>", desc = "Remove Tag" },
  --     { "<leader>cR", "<cmd>GoRename<cr>", desc = "Rename 2" },
  --     { "<leader>cfs", "<cmd>GoFillStruct<cr>", desc = "Fill Struct" },
  --     { "<leader>cfS", "<cmd>GoFillSwitch<cr>", desc = "Fill Switch" },
  --     { "<leader>cv", "<cmd>GoVet<cr>", desc = "Run Go Vet" },
  --     { "<leader>cL", "<cmd>GoLint<cr>", desc = "Run Linter" },
  --     { "<leader>cD", "<cmd>GoDoc<cr>", desc = "Show Documentation" },
  --     { "<leader>ci", "<cmd>GoImpl<cr>", desc = "Implement" },
  --   },
  -- },

  {
    "nvim-neotest/neotest",
    dependencies = {
      -- "nvim-neotest/neotest-go",
      -- golang
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "fredrikaverpil/neotest-golang", -- Installation
    },
    ft = { "go", "gomod" },
    -- keys = {
    --   {
    --     "<leader>tl",
    --     function()
    --       require("neotest").run.run_last()
    --     end,
    --     desc = "Run Last Test",
    --   },
    --   {
    --     "<leader>tL",
    --     function()
    --       require("neotest").run.run_last({ strategy = "dap" })
    --     end,
    --     desc = "Debug Last Test",
    --   },
    --   {
    --     "<leader>tw",
    --     "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
    --     desc = "Run Watch",
    --   },
    -- },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      table.insert(opts.adapters, require("neotest-golang"))
      opts.adapters["neotest-golang"] = {
        go_test_args = {
          "-v",
          "-race",
          "-count=1",
          "-timeout=60s",
          "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
        },
        dap_go_enabled = true,
      }
      -- table.insert(
      --   opts.adapters,
      --   require("neotest-go")({
      --     experimentral = {
      --       test_table = true,
      --     },
      --   })
      -- )
    end,
    config = function(_, opts)
      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
    keys = {
      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "[t]est [a]ttach",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "[t]est run [f]ile",
      },
      {
        "<leader>tA",
        function()
          require("neotest").run.run(vim.uv.cwd())
        end,
        desc = "[t]est [A]ll files",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.run({ suite = true })
        end,
        desc = "[t]est [S]uite",
      },
      {
        "<leader>tn",
        function()
          require("neotest").run.run()
        end,
        desc = "[t]est [n]earest",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "[t]est [l]ast",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "[t]est [s]ummary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "[t]est [o]utput",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "[t]est [O]utput panel",
      },
      {
        "<leader>tt",
        function()
          require("neotest").run.stop()
        end,
        desc = "[t]est [t]erminate",
      },
      {
        "<leader>td",
        function()
          require("neotest").run.run({ suite = false, strategy = "dap" })
        end,
        desc = "Debug nearest test",
      },
    },
  },
}
