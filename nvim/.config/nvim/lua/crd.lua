local curl = require("plenary.curl")

local M = {
  schemas_catalogs = {
    { name = "datreeio/CRDs-catalog", branch = "main", tree = {} },
    { name = "yannh/kubernetes-json-schema", branch = "master", tree = {} },
  },
  github_base_api_url = "https://api.github.com/repos",
  github_headers = {
    Accept = "application/vnd.github+json",
    ["X-GitHub-Api-Version"] = "2022-11-28",
  },
}

-- Add raw.githubusercontent.com URLs to each catalog
for _, catalog in ipairs(M.schemas_catalogs) do
  catalog.url = "https://raw.githubusercontent.com/" .. catalog.name .. "/" .. catalog.branch
end

M.load_github_tree = function()
  for _, catalog in ipairs(M.schemas_catalogs) do
    local url = M.github_base_api_url .. "/" .. catalog.name .. "/git/trees/" .. catalog.branch
    local response = curl.get(url, { headers = M.github_headers, query = { recursive = 1 } })
    local body = vim.fn.json_decode(response.body)

    if body and body.tree then
      local trees = {}
      for _, tree in ipairs(body.tree) do
        if tree.type == "blob" and tree.path:match("%.json$") then
          table.insert(trees, tree.path)
        end
      end
      catalog.tree = trees
    else
      vim.notify("Failed to fetch data from: " .. url, vim.log.levels.ERROR, {})
    end
  end
end

M.load_github_tree()

M.init = function()
  local crd_list = {}
  for _, catalog in ipairs(M.schemas_catalogs) do
    for _, crd_path in ipairs(catalog.tree) do
      table.insert(crd_list, {
        label = crd_path,
        value = {
          path = crd_path,
          catalog = catalog.name,
          branch = catalog.branch,
        },
      })
    end
  end

  vim.ui.select(crd_list, {
    prompt = "Select schema: ",
    format_item = function(item)
      return item.label
    end,
  }, function(selection)
    if not selection then
      vim.notify("Canceled.", vim.log.levels.WARN, {})
      return
    end

    local schema_url = "https://raw.githubusercontent.com/"
      .. selection.value.catalog
      .. "/"
      .. selection.value.branch
      .. "/"
      .. selection.value.path

    local schema_modeline = "# yaml-language-server: $schema=" .. schema_url
    -- TODO after previous ---
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { schema_modeline })
    -- vim.notify("Added schema modeline: " .. schema_modeline)
  end)
end

return M
