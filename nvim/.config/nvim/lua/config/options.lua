-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Module for defining new filetypes. I picked up these configurations based on inspirations from this dotfiles repo:
-- https://github.com/davidosomething/dotfiles/blob/be22db1fc97d49516f52cef5c2306528e0bf6028/nvim/lua/dko/filetypes.lua

-- vim.filetype.add({
--   -- Detect and assign filetype based on the extension of the filename
--   extension = {
--     astro = "astro",
--     mdx = "mdx",
--     log = "log",
--     env = "dotenv",
--   },
--   -- Detect and apply filetypes based on the entire filename
--   filename = {
--     [".env"] = "dotenv",
--     ["env"] = "dotenv",
--   },
--   -- Detect and apply filetypes based on certain patterns of the filenames
--   pattern = {
--     -- INFO: Match filenames like - ".env.example", ".env.local" and so on
--     ["%.env%.[%w_.-]+"] = "dotenv",
--   },
-- })
vim.diagnostic.config({ severity_sort = true })
