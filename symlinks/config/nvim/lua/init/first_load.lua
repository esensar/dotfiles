-- Adopted from https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/first_load.lua
local download_packer = function(force)
	if not force then
		if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
			return
		end
	end

	local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath("data"))

	vim.fn.mkdir(directory, "p")

	local out = vim.fn.system(
		string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
	)

	print(out)
	print("Downloading packer.nvim...")
	vim.api.nvim_command("PackerCompile")
	vim.api.nvim_command("PackerInstall")
	print("( You'll need to restart now )")
	if force then
		vim.api.nvim_command("quitall")
	end
end

return function(force)
	if not pcall(require, "packer") then
		download_packer(force)

		return true
	end

	return false
end
