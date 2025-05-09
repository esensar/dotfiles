local luasnip = require("luasnip")
local types = require("luasnip.util.types")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local f = luasnip.function_node
local t = luasnip.text_node
local i = luasnip.insert_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node

luasnip.config.setup({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "GruvboxOrange" } },
			},
		},
		[types.insertNode] = {
			active = {
				virt_text = { { "●", "GruvboxBlue" } },
			},
		},
	},
})

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
	s("disoutc", { f(function(_, _)
		return os.date("!%Y-%m-%dT%H:%M:%SZ")
	end) }),
})

-- Java snippets
local function jdocsnip(args, _, old_state)
	-- !!! old_state is used to preserve user-input here. DON'T DO IT THAT WAY!
	-- Using a restoreNode instead is much easier.
	-- View this only as an example on how old_state functions.
	local nodes = {
		t({ "/**", " * " }),
		i(1, "A short Description"),
		t({ "", "" }),
	}

	-- These will be merged with the snippet; that way, should the snippet be updated,
	-- some user input eg. text can be referred to in the new snippet.
	local param_nodes = {}

	if old_state then
		nodes[2] = i(1, old_state.descr:get_text())
	end
	param_nodes.descr = nodes[2]

	-- At least one param.
	if string.find(args[2][1], ", ") then
		vim.list_extend(nodes, { t({ " * ", "" }) })
	end

	local insert = 2
	for _, arg in ipairs(vim.split(args[2][1], ", ", true)) do
		-- Get actual name parameter.
		arg = vim.split(arg, " ", true)[2]
		if arg then
			local inode
			-- if there was some text in this parameter, use it as static_text for this new snippet.
			if old_state and old_state[arg] then
				inode = i(insert, old_state["arg" .. arg]:get_text())
			else
				inode = i(insert)
			end
			vim.list_extend(nodes, { t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) })
			param_nodes["arg" .. arg] = inode

			insert = insert + 1
		end
	end

	if args[1][1] ~= "void" then
		local inode
		if old_state and old_state.ret then
			inode = i(insert, old_state.ret:get_text())
		else
			inode = i(insert)
		end

		vim.list_extend(nodes, { t({ " * ", " * @return " }), inode, t({ "", "" }) })
		param_nodes.ret = inode
		insert = insert + 1
	end

	if vim.tbl_count(args[3]) ~= 1 then
		local exc = string.gsub(args[3][2], " throws ", "")
		local ins
		if old_state and old_state.ex then
			ins = i(insert, old_state.ex:get_text())
		else
			ins = i(insert)
		end
		vim.list_extend(nodes, { t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) })
		param_nodes.ex = ins
		-- insert = insert + 1
	end

	vim.list_extend(nodes, { t({ " */" }) })

	local snip = sn(nil, nodes)
	-- Error on attempting overwrite.
	snip.old_state = param_nodes
	return snip
end

luasnip.add_snippets("java", {
	-- Very long example for a java class.
	s("fn", {
		d(6, jdocsnip, { 2, 4, 5 }),
		t({ "", "" }),
		c(1, {
			t("public "),
			t("private "),
		}),
		c(2, {
			t("void"),
			t("String"),
			t("char"),
			t("int"),
			t("double"),
			t("boolean"),
			i(nil, ""),
		}),
		t(" "),
		i(3, "myFunc"),
		t("("),
		i(4),
		t(")"),
		c(5, {
			t(""),
			sn(nil, {
				t({ "", " throws " }),
				i(1),
			}),
		}),
		t({ " {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),
}, {
	key = "java",
})

require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip").filetype_extend("java", { "javadoc", "java-tests" })

luasnip.add_snippets("rust", {
	s("tests", {
		t({ "#[cfg(test)]", "mod tests {", "    use super::*;", "    " }),
		i(0),
		t({ "", "}" }),
	}),
})
