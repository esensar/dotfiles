-------------------------------------------------------------------------------
--    - Common projects library -
-------------------------------------------------------------------------------

local M = {}

-- Gets project root directory based on projectionist
function M.get_project_root()
  return vim.fn['projectionist#path']()
end

-- Get unique project ID based on git repository
function M.get_project_id()
  local remote_url = vim.fn['fugitive#RemoteUrl']()
  remote_url = remote_url:gsub("/", ":")
  return remote_url
end

return M
