return {
  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-buffer", "davidsierradz/cmp-conventionalcommits" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "conventionalcommits" })
      table.insert(opts.sources, { name = "buffer" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gh",
        "actionlint",
        "commitlint",
        "gitlint",
      },
    },
  },
}
