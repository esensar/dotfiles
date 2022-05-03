local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

return {
	name = "ledger-complete",
	meta = {
		url = "https://github.com/ledger/vim-ledger",
		description = "vim-ledger omnifunc completion source",
	},
	method = null_ls.methods.COMPLETION,
	filetypes = { "ledger" },
	generator = helpers.generator_factory({
		fn = function(params, done)
			-- This can be slow
			if #params.word_to_complete < 4 then
				done({ { items = {}, isIncomplete = false } })
				return
			end

			vim.fn.LedgerComplete(1, nil)
			local results = vim.fn.LedgerComplete(0, #params.word_to_complete)

			local words = {}
			local items = {}
			for result in ipairs(results) do
				table.insert(words, result)
			end

			for _, word in ipairs(words) do
				table.insert(items, {
					label = word,
					insertText = word,
				})
			end

			done({ { items = items, isIncomplete = #items == 0 } })
		end,
		async = true,
	}),
}
