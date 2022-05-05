-- UI extensions
local plenary_async = require("plenary.async.async")

local M = {}

M.input = plenary_async.wrap(vim.ui.input, 2)
M.select = plenary_async.wrap(vim.ui.select, 3)

return M
