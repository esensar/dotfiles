-------------------------------------------------------------------------------
--     - Direnv + Vimrc extensions -
-------------------------------------------------------------------------------
local M = {}

function M.get_local_vimrc()
    local extra_vimrc_location = vim.env.DIRENV_EXTRA_VIMRC

    return extra_vimrc_location
end

function M.open_local_vimrc()
    local local_vimrc = M.get_local_vimrc()

    if local_vimrc == nil then
        local_vimrc = vim.fn.input("Local vimrc filename: ", ".vimrc")
        local save = vim.fn.input("Save to .envrc? [y/N]", "y")
        if save == "y" then
            local existing_envrc = vim.fn.readfile(".envrc")
            local write = true
            for line in existing_envrc do
                if string.find(line, "export DIRENV_EXTRA_VIMRC") then
                    write = false
                end
            end
            if write then
                vim.fn.writefile({"export DIRENV_EXTRA_VIMRC=" .. local_vimrc}, ".envrc", "a")
            end
        end
    end

    vim.cmd("edit " .. local_vimrc)
end

return M
