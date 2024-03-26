return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "docker-compose-language-service",
        "dockerfile-language-server",
      })
    end,
  },
}
