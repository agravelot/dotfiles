return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters.sqruff = {
        -- args = { "format", "--dialect=ansi", "-" },
      }

      local sql_ft = { "sql", "mysql", "plsql" }
      for _, ft in ipairs(sql_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "sqruff")
        -- remove sqlfluff
        opts.formatters_by_ft[ft] = vim.tbl_filter(function(name)
          return name ~= "sqlfluff"
        end, opts.formatters_by_ft[ft])
      end
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "sqruff",
      })
    end,
  },
}
