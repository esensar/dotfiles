-------------------------------------------------------------------------------
--     - Fugitive.vim extensions library -
-------------------------------------------------------------------------------

-- Generates url for creating PR for current branch
-- Tested only with github.com
-- Works regardless of ssh or https for origin config
-- Hardcoded to use 'origin' remote
local function get_pr_url(...)
    local origin_url = vim.fn["fugitive#RemoteUrl"]("origin")
    origin_url = string.gsub(origin_url, ".git$", "")
    origin_url = string.gsub(origin_url, ":", "/")
    origin_url = string.gsub(origin_url, "git@", "https://")

    -- Remove prefix if it is available, for some of common git services
    local common_services = {"github.com", "bitbucket.org", "gitlab.com"}
    for k, service in pairs(common_services) do
        if (string.find(origin_url, service, 1, true)) then
            -- Common mechanism for managing multiple SSH keys
            origin_url = string.gsub(origin_url, "://.*" .. service, "://" .. service)
        end
    end

    -- This part probably only works on github
    local pr_url
    if (select("#", ...) == 0) then
        pr_url = origin_url .. "/compare/" .. vim.fn.FugitiveHead() .. "?expand=1"
    else
        pr_url = origin_url .. "/compare/" .. select(1, ...) .. "..." .. vim.fn.FugitiveHead() .. "?expand=1"
    end
    return pr_url
end

-------------------------------------------------------------------------------
--    - Public API -
-------------------------------------------------------------------------------

local M = {}

-- Shorcut to push directly to current branch on origin
-- Similar to `ggpush` in fish config
function M.push_origin()
    vim.cmd("Git push origin " .. vim.fn.FugitiveHead())
end

-- Shorcut to pull directly from current branch on origin
-- Similar to `ggpull` in fish config
function M.pull_origin()
    vim.cmd("Git pull origin " .. vim.fn.FugitiveHead())
end

-- Prints current branches PR url (not saved to :messages)
-- Makes it easy to use terminal for opening url on click
function M.print_pr_url(...)
    vim.cmd('echo "' .. get_pr_url(...) .. '"')
end

-- Copies current branches PR url to system clipboard
function M.copy_pr_url(...)
    vim.cmd('let @+ = "' .. get_pr_url(...) .. '"')
end

-- Opens current banches PR url in default browser
-- Utilizes netrw browse, meaning it should behave same as netrw
function M.open_new_pr(...)
    vim.fn["netrw#BrowseX"](get_pr_url(...), 0)
end

-- Creates new branch and checks out to it
-- Similar to `gcb` in fish config
function M.create_branch(branch)
    vim.cmd("Git checkout -b " .. branch)
end

-- Switches to branch
function M.checkout_branch(branch)
    vim.cmd("Git checkout " .. branch)
end

return M
