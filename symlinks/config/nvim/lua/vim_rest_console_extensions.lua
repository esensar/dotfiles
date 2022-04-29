-------------------------------------------------------------------------------
--     - Vim REST Console extensions library -
-------------------------------------------------------------------------------

local function get_vim_rest_home_dir()
	vim.fn.mkdir(vim.env.NVIMHOME .. "/vim-rest-console", "p")
	return vim.env.NVIMHOME .. "/vim-rest-console"
end

-- Opens up a new tab if current buffer is not empty
local function new_tab_if_needed()
	if vim.api.nvim_buf_get_name(0) ~= "" then
		-- Current buffer is not empty, open up a new tab
		vim.cmd("tabnew")
	end
end

local function open_rest_console(file)
	new_tab_if_needed()
	local ending = ".rest"
	if file:sub(-#ending) ~= ending then
		file = file .. ".rest"
	end
	vim.cmd("e " .. file)
end

local function open_cached_rest_console(name)
	local dir = get_vim_rest_home_dir()
	open_rest_console(dir .. "/" .. name)
end

-------------------------------------------------------------------------------
--    - Public API -
-------------------------------------------------------------------------------

local M = {}

-- Opens us a scratch rest console (not saved)
function M.open_scratch_rest_console()
	new_tab_if_needed()
	vim.cmd("set ft=rest")
end

-- Opens up a rest console which can be saved -- cached by name
function M.open_cached_rest_console(args)
	local name = args[0] or args[1]
	if not name then
		name = require("common.projects").get_project_id()
	end
	open_cached_rest_console(name)
end

-- Opens up a rest console which can be saved -- cached by name
function M.open_named_cached_rest_console(name)
	name = require("common.projects").get_project_id() .. name
	open_cached_rest_console(name)
end

-- Opens up a rest console based on local file path
function M.open_local_rest_console(args)
	local file = args[0] or args[1]
	if not file then
		file = "default"
	end
	open_rest_console(file)
end

return M
