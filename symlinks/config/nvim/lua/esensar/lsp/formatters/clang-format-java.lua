return function()
	local java_clang_format = require("formatter.filetypes.java").clangformat()
	for i = #java_clang_format.args, 1, -1 do
		if java_clang_format.args[i]:find("--style", 1, true) == 1 then
			table.remove(java_clang_format.args, i)
		end
	end
	vim.list_extend(java_clang_format.args, { '--style="{BasedOnStyle: Google, IndentWidth: 4}"' })
	return java_clang_format
end
