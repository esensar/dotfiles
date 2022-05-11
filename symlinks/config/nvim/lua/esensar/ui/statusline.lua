-- Lua personal statusline

local filetype_glyphs = {
	rust = "%2*%*",
	c = "%4*%*",
	cs = "%4*%*",
	python = "%3*%*",
	javascript = "",
	typescript = "%4*%*",
	vim = "%1*%*",
	clojure = "",
	html = "",
	haskell = "",
	markdown = "",
	org = "",
	scss = "",
	scala = "",
	elixir = "%5*%*",
	kotlin = "%2*洞%*",
	yml = "",
	toml = "",
	json = "",
}

local edit_modes = {
	n = "N",
	i = "%3*I%*",
	v = "%1*V%*",
	V = "%1*V.%*",
	["<C-V>"] = "%1*VB%*",
	c = "%4*C%*",
}

local function update_colors()
	local status_line_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
	local bg = status_line_hl.foreground

	local function set_user_highlight_based_on(user_hl_name, based_on)
		local hl_based_on = vim.api.nvim_get_hl_by_name(based_on, true)
		local user_config = {
			foreground = hl_based_on.foreground,
			background = bg,
			bold = true,
		}
		vim.api.nvim_set_hl(0, user_hl_name, user_config)
	end

	set_user_highlight_based_on("User1", "Function")
	set_user_highlight_based_on("User2", "WarningMsg")
	set_user_highlight_based_on("User3", "MoreMsg")
	set_user_highlight_based_on("User4", "Identifier")
	set_user_highlight_based_on("User5", "Number")
end

local function get_filetype_string()
	return filetype_glyphs[vim.o.filetype] or "%y"
end

local function get_mode_string()
	local mode = vim.fn.mode()
	local mode_fallback = "[mode: " .. mode .. "]"
	return edit_modes[mode] or mode_fallback
end

local function get_paste_string()
	if vim.o.paste then
		return " [paste] "
	else
		return ""
	end
end

local function get_diagnostics_status()
	local diagnostics = vim.diagnostic.get(0)

	local error_count = #vim.tbl_filter(function(d)
		return d.severity == vim.diagnostic.severity.ERROR
	end, diagnostics)
	local non_error_count = #diagnostics - error_count

	if #diagnostics == 0 then
		return "%1*OK%*"
	else
		return string.format("%%3*%d%%* %%2*%d%%*", non_error_count, error_count)
	end
end

local function blank_override()
	return ""
end

local function centered_title_override(title)
	return {
		left = function()
			return "%= " .. title .. " %="
		end,
		right = blank_override,
	}
end

local dapui_override = {
	active = centered_title_override("%f"),
}

local ft_overrides = {
	fugitive = {
		active = centered_title_override("===GIT FUGITIVE==="),
		inactive = centered_title_override("GIT FUGITIVE"),
	},
	help = {
		active = {
			left = function()
				return " Documentation: %2*%f%*"
			end,
		},
		inactive = centered_title_override("Documentation: %f"),
	},
	dbui = {
		active = centered_title_override("DBUI"),
		inactive = centered_title_override("DBUI"),
	},
	["dap-repl"] = {
		active = centered_title_override("DAP REPL"),
		inactive = centered_title_override("DAP REPL"),
	},
	dapui_watches = dapui_override,
	dapui_stacks = dapui_override,
	dapui_breakpoints = dapui_override,
	dapui_scopes = dapui_override,
}

local function get_override(filetype)
	return vim.tbl_extend("keep", ft_overrides[filetype] or {}, {
		active = {},
		inactive = {},
	})
end

local function get_current_override()
	local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)
	return get_override(vim.api.nvim_buf_get_option(bufnr, "filetype"))
end

local statuslines = {
	active = function()
		local override = get_current_override().active

		local function build_left_side()
			if override.left then
				return override.left()
			end
			local status = " " .. get_mode_string() .. " " -- starting with current mode
			if vim.g.loaded_fugitive then -- then git status
				local head = vim.fn.FugitiveHead()
				if string.len(head) > 0 then
					status = status .. "%4* " .. head .. "%*"
				end
			end
			status = status .. " %f" -- Filename
			status = status .. " %1*%M%*" -- Modified
			status = status .. " %2*%r%*" -- Read only
			status = status .. get_paste_string()

			-- Take just the first message which makes sense
			local first_lsp_message = vim.tbl_filter(function(msg)
				return not msg.done and msg.progress
			end, vim.lsp.util.get_progress_messages())[1]
			if first_lsp_message then
				status = status
					.. " %2*"
					.. "["
					.. first_lsp_message.name
					.. "]"
					.. "("
					.. first_lsp_message.percentage
					.. "%%)"
					.. " "
					.. first_lsp_message.title
					.. "%*"
			end
			-- TODO: Add current container if devcontainer is used
			return status
		end

		local function build_right_side()
			if override.right then
				return override.right()
			end
			local status = "%=   " -- Align right
			status = status .. get_diagnostics_status()
			status = status .. " %2c:%3l/%3L (%3p%%) " -- col, line, tot. lines
			status = status .. get_filetype_string() .. " " -- File type
			return status
		end

		return build_left_side() .. build_right_side()
	end,
	inactive = function()
		local override = get_current_override().inactive

		local build_left_side = override.left or centered_title_override("%f").left
		local build_right_side = override.right or blank_override
		return build_left_side() .. build_right_side()
	end,
}

return {
	statuslines = statuslines,
	setup = function()
		update_colors()
		local au_id = vim.api.nvim_create_augroup("statuslineconf", {})
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			group = au_id,
			callback = function()
				update_colors()
			end,
		})
		vim.api.nvim_create_autocmd({ "User LspProgressUpdate", "User LspRequest" }, {
			group = au_id,
			callback = function()
				vim.cmd("redrawstatus")
			end,
		})
		vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
			pattern = "*",
			group = au_id,
			callback = function()
				vim.wo.statusline = "%!v:lua.require'esensar.ui.statusline'.statuslines.active()"
			end,
		})
		vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
			pattern = "*",
			group = au_id,
			callback = function()
				vim.wo.statusline = "%!v:lua.require'esensar.ui.statusline'.statuslines.inactive()"
			end,
		})
	end,
}
