local luasnip = require("luasnip")
local s = luasnip.snippet
local f = luasnip.function_node

luasnip.add_snippets("all", {
	s("date", { f(function(_, _)
		return os.date("%Y-%m-%d")
	end) }),
	s("datetime", { f(function(_, _)
		return os.date("%Y-%m-%d %H:%M:%S")
	end) }),
	s("diso", { f(function(_, _)
		return os.date("%Y-%m-%dT%H:%M:%S")
	end) }),
})

require("luasnip.loaders.from_vscode").lazy_load()
