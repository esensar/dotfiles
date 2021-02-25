-------------------------------------------------------------------------------
--    - NeoVim DAP (Debug Adapter Protocol) config -
-------------------------------------------------------------------------------

local dap = require('dap')

dap.adapters.python = {
	type = 'executable';
	command = 'python';
	args = { '-m', 'debugpy.adapter' };
}

-- Nvim DAP Treesitter integration
vim.g.dap_virtual_text = true
