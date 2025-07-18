-- return {
--   {
--     "nvim-cmp",
--     dependencies = { "ogaken-1/cmp-tsnip" },
--     opts = function(_, opts)
--       table.insert(opts.sources, { name = "tsnip" })
--     end,
--   },
-- }

return {
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "jose-elias-alvarez/typescript.nvim",
  --     init = function()
  --       require("lazyvim.util").lsp.on_attach(function(_, buffer)
  --         -- stylua: ignore
  --         vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
  --         vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
  --       end)
  --     end,
  --   },
  --   ---@class PluginLspOpts
  --   opts = {
  --     ---@type lspconfig.options
  --     servers = {
  --       -- tsserver will be automatically installed with mason and loaded with lspconfig
  --       tsserver = {},
  --     },
  --     -- you can do any additional lsp server setup here
  --     -- return true if you don't want this server to be setup with lspconfig
  --     ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  --     setup = {
  --       -- example to setup with typescript.nvim
  --       tsserver = function(_, opts)
  --         require("typescript").setup({ server = opts })
  --         return true
  --       end,
  --       -- Specify * to use this function as a fallback for any server
  --       -- ["*"] = function(server, opts) end,
  --     },
  --   },
  -- },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- {
  --   "yioneko/nvim-vtsls",
  --   opts = {
  --     refactor_auto_rename = true,
  --     -- typescript.tsserver.pluginPaths = ["./node_modules"]
  --     settings = {
  --       typescript = {
  --         tsdk = "node_modules/typescript/lib",
  --         --   inlayHints = {
  --         --     parameterNames = { enabled = "literals" },
  --         --     parameterTypes = { enabled = true },
  --         --     variableTypes = { enabled = true },
  --         --     propertyDeclarationTypes = { enabled = true },
  --         --     functionLikeReturnTypes = { enabled = true },
  --         --     enumMemberValues = { enabled = true },
  --         --   },
  --       },
  --     },
  --   },
  -- },
  {
    "nvimtools/none-ls.nvim",
    -- enable = false,
    -- ft = { "typescript" },
    opts = function(_, opts)
      local remove_sources = { "prettier" }
      opts.sources = vim.tbl_filter(function(source)
        return not vim.tbl_contains(remove_sources, source.name)
      end, opts.sources)
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     -- make sure mason installs the server
  --     servers = {
  --       -- tsserver = {
  --       --   enabled = false,
  --       -- },
  --       vtsls = {
  --         -- explicitly add default filetypes, so that we can extend
  --         -- them in related extras
  --         settings = {
  --           vtsls = {
  --             -- tsserver = {
  --             experimental = {
  --               enableProjectDiagnostics = true,
  --               maxInlayHintLength = 30,
  --             },
  --             -- },
  --
  --             --   enableMoveToFileCodeAction = true,
  --             --   autoUseWorkspaceTsdk = true,
  --             --   experimental = {
  --             --     completion = {
  --             --       enableServerSideFuzzyMatch = true,
  --             --     },
  --             --   },
  --           },
  --           typescript = {
  --             -- tsdk = "node_modules/typescript/lib",
  --             suggest = {
  --               includeAutomaticOptionalChainCompletions = true,
  --             },
  --             --  typescript.tsserver.experimental.enableProjectDiagnostics
  --             tsserver = {
  --               experimental = {
  --                 -- enableProjectDiagnostics = true,
  --               },
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "html",
        "javascript",
        "json",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "tsx",
        "typescript",
        "tsx",
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      -- add tsx and treesitter
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "eslint_d",
        -- "eslint_lsp",
        "mdx-analyzer",
        "js-debug-adapter",
        "prettierd",
        "vtsls",
      })
    end,
  },
  -- {
  --   "vuki656/package-info.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   ft = "json",
  --   opts = {
  --     hide_up_to_date = true,
  --     package_manager = "npm",
  --   },
  --   config = function()
  --     require("package-info").setup()
  --   end,
  -- },
  {
    "saghen/blink.cmp",
    dependencies = { "alexandre-abrioux/blink-cmp-npm.nvim" },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or {}
      opts.sources.providers = opts.sources.providers or {}
  
      -- Ensure that the 'npm' source is added to the default sources
      opts.sources.default = vim.list_extend(opts.sources.default, { "npm" })
      opts.sources.providers = vim.tbl_deep_extend("force", {
        npm = {
          name = "npm",
          module = "blink-cmp-npm",
          async = true,
          -- optional - make blink-cmp-npm completions top priority (see `:h blink.cmp`)
          score_offset = 100,
          -- optional - blink-cmp-npm config
          ---@module "blink-cmp-npm"
          ---@type blink-cmp-npm.Options
          opts = {
            ignore = {},
            only_semantic_versions = true,
            only_latest_version = false,
          },
        },
      }, opts.sources.providers)
    end,
  },
  {
    "lucaSartore/nvim-dap-exception-breakpoints",
    dependencies = { "mfussenegger/nvim-dap" },

    config = function()
      local set_exception_breakpoints = require("nvim-dap-exception-breakpoints")

      vim.api.nvim_set_keymap(
        "n",
        "<leader>dc",
        "",
        { desc = "[D]ebug [C]ondition breakpoints", callback = set_exception_breakpoints }
      )
    end,
  },
  {
    "dmmulroy/tsc.nvim",
    ft = { "typescript", "typescriptreact" },
    opts = {
      use_trouble_qflist = true,
      -- auto_open_qflist = true,
      auto_close_qflist = true,
      auto_focus_qflist = true,
      auto_start_watch_mode = true,
      enable_progress_notifications = true,
      flags = {
        watch = true,
      },
    },
    config = function(_, opts)
      require("tsc").setup(opts)
    end,
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "typescriptreact" },
    -- opts = {},
    config = function(_, opts)
      require("ts-error-translator").setup(opts)
    end,
  },
  -- { "artemave/workspace-diagnostics.nvim" },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   -- enabled = false,
  --   ft = { "typescript", "typescriptreact" },
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "pmizio/typescript-tools.nvim" },
  --   opts = {
  --     settings = {
  --       expose_as_code_action = "all",
  --       complete_function_calls = true,
  --       -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
  --       -- possible values: ("off"|"all"|"implementations_only"|"references_only")
  --       code_lens = "on",
  --       tsserver_format_options = {
  --         insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
  --       },
  --       tsserver_file_preferences = {
  --         includeInlayParameterNameHints = "all",
  --         includeCompletionsForModuleExports = true,
  --         quotePreference = "auto",
  --       },
  --       tsserver_plugins = {
  --         -- for TypeScript v4.9+
  --         -- "@styled/typescript-styled-plugin",
  --         -- or for older TypeScript versions
  --         -- "typescript-styled-plugin",
  --       },
  --     },
  --     on_attach = function(client, buffer)
  --       require("workspace-diagnostics").populate_workspace_diagnostics(client, buffer)
  --     end,
  --   },
  --   keys = {
  --     -- https://github.com/pmizio/typescript-tools.nvim?tab=readme-ov-file#custom-user-commands
  --     { "<leader>cr", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize Imports" },
  --   },
  -- },
  -- keymap code actions
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     -- make sure mason installs the server
  --     servers = {
  --       ---@type lspconfig.options.tsserver
  --       tsserver = {
  --         keys = {
  --           {
  --             "<leader>co",
  --             function()
  --               vim.lsp.buf.code_action({
  --                 apply = true,
  --                 context = {
  --                   only = { "source.organizeImports.ts" },
  --                   diagnostics = {},
  --                 },
  --               })
  --             end,
  --             desc = "Organize Imports",
  --           },
  --           {
  --             "<leader>cR",
  --             function()
  --               vim.lsp.buf.code_action({
  --                 apply = true,
  --                 context = {
  --                   only = { "source.removeUnused.ts" },
  --                   diagnostics = {},
  --                 },
  --               })
  --             end,
  --             desc = "Remove Unused Imports",
  --           },
  --         },
  --         ---@diagnostic disable-next-line: missing-fields
  --         settings = {
  --           completions = {
  --             completeFunctionCalls = true,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  --   optional = true,
  --   dependencies = {
  --     {
  --       "mason-org/mason.nvim",
  --       opts = function(_, opts)
  --         opts.ensure_installed = opts.ensure_installed or {}
  --         table.insert(opts.ensure_installed, "js-debug-adapter")
  --       end,
  --     },
  --   },
  --   opts = function()
  --     local dap = require("dap")
  --     if not dap.adapters["pwa-node"] then
  --       require("dap").adapters["pwa-node"] = {
  --         type = "server",
  --         host = "localhost",
  --         port = "${port}",
  --         executable = {
  --           command = "node",
  --           -- 💀 Make sure to update this path to point to your installation
  --           args = {
  --             require("mason-registry").get_package("js-debug-adapter"):get_install_path()
  --               .. "/js-debug/src/dapDebugServer.js",
  --             "${port}",
  --           },
  --         },
  --       }
  --     end
  --     for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  --       if not dap.configurations[language] then
  --         dap.configurations[language] = {
  --           {
  --             type = "pwa-node",
  --             request = "launch",
  --             name = "Launch file",
  --             program = "${file}",
  --             cwd = "${workspaceFolder}",
  --           },
  --           {
  --             type = "pwa-node",
  --             request = "attach",
  --             name = "Attach",
  --             processId = require("dap.utils").pick_process,
  --             cwd = "${workspaceFolder}",
  --           },
  --         }
  --       end
  --     end
  --   end,
  -- },
  -- Prettier in ESLint
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = { eslint = {} },
  --     setup = {
  --       eslint = function()
  --         require("lazyvim.util").lsp.on_attach(function(client)
  --           if client.name == "eslint" then
  --             client.server_capabilities.documentFormattingProvider = true
  --           elseif client.name == "tsserver" then
  --             client.server_capabilities.documentFormattingProvider = false
  --           end
  --         end)
  --       end,
  --     },
  --   },
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "artemave/workspace-diagnostics.nvim",
  --     "jose-elias-alvarez/typescript.nvim",
  --     init = function()
  --       require("lazyvim.util").lsp.on_attach(function(_, buffer)
  --         -- stylua: ignore
  --         vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
  --         vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
  --       end)
  --     end,
  --   },
  --   ---@class PluginLspOpts
  --   opts = {
  --     ---@type lspconfig.options
  --     servers = {
  --       -- tsserver will be automatically installed with mason and loaded with lspconfig
  --       tsserver = {},
  --     },
  --     -- you can do any additional lsp server setup here
  --     -- return true if you don't want this server to be setup with lspconfig
  --     ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  --     setup = {
  --       -- example to setup with typescript.nvim
  --       tsserver = function(_, opts)
  --         require("typescript").setup({ server = opts })
  --         return true
  --       end,
  --       -- Specify * to use this function as a fallback for any server
  --       -- ["*"] = function(server, opts) end,
  --     },
  --   },
  -- },
  {
    "elianiva/telescope-npm.nvim",
    keys = {
      { "<leader>nl", "<cmd>Telescope npm list<cr>", desc = "Npm List" },
      { "<leader>nr", "<cmd>Telescope npm scripts<cr>", desc = "Npm [R]un" },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    keys = {
      { "<leader>n", "", desc = "+npm" },
    },
  },
}
