-- Vim grep configuration

if vim.fn.executable("rg") == 1 then
	vim.o.grepprg = "rg --vimgrep --hidden --glob ‘!.git’"
	vim.o.grepformat = vim.o.grepformat .. "," .. "%f:%l:%c:%m"
end
