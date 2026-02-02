return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- TODO Extend
      servers = { eslint = {} },
      setup = {
        eslint = function()
          Snacks.util.lsp.on(function(bufnr, client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
}
