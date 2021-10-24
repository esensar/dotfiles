-------------------------------------------------------------------------------
--     - Vimwiki extensions library -
--     Relies on vimwiki-reviews-lua for its vimwiki API
-------------------------------------------------------------------------------
local api = require('vimwiki_reviews.vimwiki_api')
local utils = require('vimwiki_reviews.utils')
local templates = require('vimwiki_reviews.templates')
local Path = require('plenary.path')
local scandir = require('plenary.scandir')

local M = {}

-- Gets path to any dir of provided vimwiki (by index)
function M.get_vimwiki_subdir(vimwiki_index, directory)
  vimwiki_index = api.normalize_vimwiki_index(vimwiki_index)
  local vimwiki = vim.g.vimwiki_list[vimwiki_index]

  return vimwiki.path .. directory .. '/'
end

function M.get_directory_index(vimwiki_index, directory)
  local dir = M.get_vimwiki_subdir(vimwiki_index, directory)
  local path = Path:new(dir):expand()

  local entries = scandir.scan_dir(
    path,
    {
      hidden = false,
      add_dirs = false,
      respect_gitignore = true,
      depth = 1
    })

  local index = {}

  for _,entry in pairs(entries) do
    local filename = utils.get_filename_from_path(entry)
    local ext = api.get_vimwiki_extension(vimwiki_index)
    local noext = string.gsub(filename, ext, '')

    index[noext] = filename
  end

  table.sort(index)
  return index
end

-- Open subdirectory index file
function M.open_subdirectory_index_file(vimwiki_index, subdirectory)
  local dir = M.get_vimwiki_subdir(vimwiki_index, subdirectory)
  local ext = api.get_vimwiki_extension(vimwiki_index)
  local filename = dir .. 'index' .. ext
  vim.cmd('edit ' .. filename)

  local index = M.get_directory_index(vimwiki_index, subdirectory)

  local builder = templates.for_vimwiki(vimwiki_index)

  local lines = {
    builder.header(1, subdirectory:sub(1,1):upper()..subdirectory:sub(2)),
    '',
  }

  -- Add items
  for title, fname in pairs(index) do
    if (title ~= 'index')
    then
      title = string.gsub(title, '-', ' ')
      title = title:sub(1,1):upper()..title:sub(2)
      table.insert(lines, builder.list_item(builder.link(fname, title)))
    end
  end

  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})  -- Clear out
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)  -- Put new contents
end

return M
