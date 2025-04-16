return {
  -- {
  --   "saghen/blink.cmp",
  --   opts = {
  --     keymap = {
  --       -- preset = "default",
  --       -- preset = "super-tab",
  --       -- ["<Tab>"] = {
  --       --   LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
  --       --   "fallback",
  --       -- },
  --     },
  --     -- nerd_font_variant = "normal",
  --   },
  -- },
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- add symbols-outline
  -- {
  --   "simrat39/symbols-outline.nvim",
  --   cmd = "SymbolsOutline",
  --   keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
  --   config = true,
  -- },

  -- override nvim-cmp and add cmp-emoji
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = { "hrsh7th/cmp-emoji" },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     table.insert(opts.sources, { name = "emoji" })
  --   end,
  -- },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  -- Preview images in telescope
  {
    "telescope.nvim",
    opts = {
      defaults = {
        preview = {
          mime_hook = function(filepath, bufnr, opts)
            local is_image = function(filepath)
              local image_extensions = { "png", "jpg" } -- Supported image formats
              local split_path = vim.split(filepath:lower(), ".", { plain = true })
              local extension = split_path[#split_path]
              return vim.tbl_contains(image_extensions, extension)
            end
            if is_image(filepath) then
              local term = vim.api.nvim_open_term(bufnr, {})
              local function send_output(_, data, _)
                for _, d in ipairs(data) do
                  vim.api.nvim_chan_send(term, d .. "\r\n")
                end
              end
              vim.fn.jobstart({
                "catimg",
                filepath, -- Terminal image viewer command
              }, { on_stdout = send_output, stdout_buffered = true, pty = true })
            else
              require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
            end
          end,
        },
      },
    },
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "vim",
        "yaml",
      })
    end,
  },

  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- add tsx and treesitter
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      })
    end,
  },
  -- {
  --   "L3MON4D3/LuaSnip",
  --   keys = function()
  --     return {}
  --   end,
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --
  --     -- opts.mapping = vim.mapping("force", opts.mapping, { ["<CR>"] = nil })
  --
  --     opts.preselect = cmp.PreselectMode.None
  --     opts.completion = {
  --       completeopt = "menu,menuone,noinsert,noselect",
  --     }
  --
  --     local luasnip = require("luasnip")
  --     opts.mapping = cmp.mapping.preset.insert(vim.tbl_deep_extend("force", opts.mapping, {
  --
  --       -- Select the [n]ext item
  --       ["<C-n>"] = cmp.mapping.select_next_item(),
  --       -- Select the [p]revious item
  --       ["<C-p>"] = cmp.mapping.select_prev_item(),
  --
  --       -- Scroll the documentation window [b]ack / [f]orward
  --       ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --       ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --
  --       -- Accept ([y]es) the completion.
  --       --  This will auto-import if your LSP supports it.
  --       --  This will expand snippets if the LSP sent a snippet.
  --       ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  --
  --       -- Manually trigger a completion from nvim-cmp.
  --       --  Generally you don't need this, because nvim-cmp will display
  --       --  completions whenever it has completion options available.
  --       ["<C-Space>"] = cmp.mapping.complete({}),
  --
  --       -- Think of <c-l> as moving to the right of your snippet expansion.
  --       --  So if you have a snippet that's like:
  --       --  function $name($args)
  --       --    $body
  --       --  end
  --       --
  --       -- <c-l> will move you to the right of each of the expansion locations.
  --       -- <c-h> is similar, except moving you backwards.
  --       ["<C-l>"] = cmp.mapping(function()
  --         if luasnip.expand_or_locally_jumpable() then
  --           luasnip.expand_or_jump()
  --         end
  --       end, { "i", "s" }),
  --       ["<C-h>"] = cmp.mapping(function()
  --         if luasnip.locally_jumpable(-1) then
  --           luasnip.jump(-1)
  --         end
  --       end, { "i", "s" }),
  --
  --       -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
  --       --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  --       ["<CR>"] = cmp.mapping({
  --         i = function(fallback)
  --           if cmp.visible() and cmp.get_active_entry() then
  --             cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
  --           else
  --             fallback()
  --           end
  --         end,
  --         s = cmp.mapping.confirm({ select = true }),
  --         c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  --       }),
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
  --         if cmp.visible() then
  --           local entry = cmp.get_selected_entry()
  --           if not entry then
  --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  --           end
  --           cmp.confirm()
  --         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
  --         -- this way you will only jump inside the snippet region
  --         elseif luasnip.expand_or_jumpable() then
  --           luasnip.expand_or_jump()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s", "c" }),
  --     }))
  --   end,
  -- },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  -- {
  --   "L3MON4D3/LuaSnip",
  --   dependencies = { "rafamadriz/friendly-snippets" },
  --   config = function()
  --     -- require("luasnip").filetype_extend("javascript", { "javascriptreact" })
  --     -- require("luasnip").filetype_extend("javascript", { "html" })
  --     -- require("luasnip").filetype_extend("javascript", { "typescriptreact" })
  --     -- require("luasnip").filetype_extend("javascript", { "html" })
  --
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --   end,
  --   -- keys = function()
  --   --   return {}
  --   -- end,
  -- },
  -- then: setup supertab in cmp
  -- {
  --   "hrsh7th/nvim-cmp",
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local luasnip = require("luasnip")
  --     local cmp = require("cmp")
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
  --           -- cmp.select_next_item()
  --           cmp.confirm({ select = true })
  --         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
  --         -- this way you will only jump inside the snippet region
  --         elseif luasnip.expand_or_jumpable() then
  --           luasnip.expand_or_jump()
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<S-Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif luasnip.jumpable(-1) then
  --           luasnip.jump(-1)
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     })
  --   end,
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     -- local luasnip = require("luasnip")
  --     -- local cmp = require("cmp")
  --
  --     opts.formatting = {
  --       formatting = {
  --         format = function(entry, item)
  --           local log = require("plenary.log").new({ plugin = "uthman", level = "debug" })
  --
  --           local icons = require("lazyvim.config").icons.kinds
  --           if icons[item.kind] then
  --             item.kind = icons[item.kind] .. item.kind
  --           end
  --
  --           log.debug("entry", entry)
  --           local i = entry:get_completion_item()
  --           log.debug("i", i)
  --
  --           if i.detail then
  --             item.menu = i.detail
  --           end
  --
  --           return item
  --         end,
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {},
  -- },

  -- {
  --   "danielfalk/smart-open.nvim",
  --   branch = "0.2.x",
  --   config = function()
  --     require("telescope").load_extension("smart_open")
  --   end,
  --   keys = {
  --     {
  --       "<leader><leader>",
  --       function()
  --         require("telescope").extensions.smart_open.smart_open({
  --           cwd_only = true,
  --           -- show_scores = true,
  --         })
  --       end,
  --       desc = "Smart Open",
  --     },
  --   },
  --   dependencies = {
  --     "kkharji/sqlite.lua",
  --     -- Only required if using match_algorithm fzf
  --     { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  --     -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
  --     { "nvim-telescope/telescope-fzy-native.nvim" },
  --   },
  -- },
  --
  --
  --
  -- {
  --   "hrsh7th/nvim-cmp",
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local cmp = require("cmp")
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
  --           cmp.select_next_item()
  --         elseif vim.snippet.active({ direction = 1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(1)
  --           end)
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<S-Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif vim.snippet.active({ direction = -1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(-1)
  --           end)
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     })
  --   end,
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local cmp = require("cmp")
  --
  --     opts.mapping["<CR>"] = function(fallback)
  --       cmp.abort()
  --       fallback()
  --     end
  --
  --     opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
  --       if cmp.visible() then
  --         -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
  --         -- cmp.select_next_item()
  --         cmp.confirm({ select = true })
  --       elseif vim.snippet.active({ direction = 1 }) then
  --         vim.schedule(function()
  --           vim.snippet.jump(1)
  --         end)
  --       elseif has_words_before() then
  --         cmp.complete()
  --       else
  --         fallback()
  --       end
  --     end, { "i", "s" })
  --
  --     opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
  --       if cmp.visible() then
  --         cmp.select_prev_item()
  --       elseif vim.snippet.active({ direction = -1 }) then
  --         vim.schedule(function()
  --           vim.snippet.jump(-1)
  --         end)
  --       else
  --         fallback()
  --       end
  --     end, { "i", "s" })
  --   end,
  -- },
  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    keys = {
      -- nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
      -- nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
      -- nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
      -- nnoremap gpD <cmd>lua require('goto-preview').goto_preview_declaration()<CR>
      -- nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
      -- nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>
      {
        "<leader>cpd",
        function()
          require("goto-preview").goto_preview_definition()
        end,
        desc = "Goto Preview",
      },
      {
        "<leader>cpt",
        function()
          require("goto-preview").goto_preview_type_definition()
        end,
        desc = "Goto Preview Type Definition",
      },
      {
        "<leader>cpi",
        function()
          require("goto-preview").goto_preview_implementation()
        end,
        desc = "Goto Preview Implementation",
      },
      {
        "<leader>cpD",
        function()
          require("goto-preview").goto_preview_declaration()
        end,
        desc = "Goto Preview Declaration",
      },
      {
        "<leader>cpc",
        function()
          require("goto-preview").close_all_win()
        end,
        desc = "Close Preview",
      },
      {
        "<leader>cpr",
        function()
          require("goto-preview").goto_preview_references()
        end,
        desc = "Goto Preview References",
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    keys = {
      { "<leader>cp", "", desc = "+preview" },
    },
  },
  -- support todo without ":"
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*]],
        after = "fg ",
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     codelens = {
  --       enabled = true,
  --     },
  --   },
  -- },
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "mdx" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "Snikimonkd/telescope-git-conflicts.nvim",
    },
    config = function()
      require("telescope").setup({})
      require("telescope").load_extension("conflicts")
    end,
    keys = {
      {
        "<leader>gC",
        "<cmd>Telescope conflicts<cr>",
        desc = "[C]onflicts",
      },
    },
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = {
  --     directories = {
  --       shorten = false,
  --     },
  --   },
  --   -- opts = function(_, opts)
  --   --   opts.directories.shorten = false
  --   -- local icons = LazyVim.config.icons
  --   -- Your custom options
  --   -- theme = "tokyonight",
  --   -- opts.sections.lualine_c = {
  --   --   LazyVim.lualine.root_dir(),
  --   --   {
  --   --     "diagnostics",
  --   --     symbols = {
  --   --       error = icons.diagnostics.Error,
  --   --       warn = icons.diagnostics.Warn,
  --   --       info = icons.diagnostics.Info,
  --   --       hint = icons.diagnostics.Hint,
  --   --     },
  --   --   },
  --   --   { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
  --   --   { LazyVim.lualine.pretty_path() },
  --   -- }
  --   -- sections = {
  --   --   lualine_c = ,
  --   -- }
  --   -- end,
  -- },
}
