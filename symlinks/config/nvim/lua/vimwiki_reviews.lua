-------------------------------------------------------------------------------
--    - Vimwiki reviews extension library -
-------------------------------------------------------------------------------

-- Gets path to reviews dir of provided vimwiki (by index)
local function get_reviews_dir(...)
	local vimwiki = {}
	if (select('#', ...) == 0)
		then
		vimwiki = vim.g.vimwiki_list[1]
	else
		vimwiki = vim.g.vimwiki_list[tonumber(select(1, ...))]
	end

	return vimwiki.path .. 'reviews/'
end

-- Finds review template path for provided review type
local function get_review_template_path(vimwiki_reviews_path, review_type)
	return vimwiki_reviews_path .. 'template-' .. review_type .. '.md'
end

-- Reads template for provided review type into current buffer
-- Uses overrides in form of files in reviews directory
-- Looks for file named template-{review_type}.md:
--  - template-week.md
--  - template-month.md
--  - template-year.md
-- Templates can use variables using %variable% syntax
-- Currently supported variables are:
--  - %date% (Puts different date based on review type)
local function read_review_template_into_buffer(vimwiki_reviews_path, review_type)
	local template_path = get_review_template_path(vimwiki_reviews_path, review_type)
	if (vim.fn.filereadable(vim.fn.glob(template_path)))
		then
		vim.cmd('read ' .. template_path)
	else
		if (review_type == 'week')
			then
			vim.fn.setline(1, '# %date% Weekly Review')
		elseif (review_type == 'month')
			then
			vim.fn.setline(1, '# %date% Monthly Review')
		elseif (review_type == 'year')
			then
			vim.fn.setline(1, '# %date% Yearly Review')
		end
	end
end

-------------------------------------------------------------------------------
--    - Public API -
-------------------------------------------------------------------------------
local M = {}

-- Edits weekly review template
M.open_review_weekly_template = function(...)
	local reviews_dir = get_reviews_dir(...)
	vim.cmd('edit ' .. get_review_template_path(reviews_dir, 'week'))
end

-- Edits monthly review template
M.open_review_monthly_template = function(...)
	local reviews_dir = get_reviews_dir(...)
	vim.cmd('edit ' .. get_review_template_path(reviews_dir, 'month'))
end

-- Edits yearly review template
M.open_review_yearly_template = function(...)
	local reviews_dir = get_reviews_dir(...)
	vim.cmd('edit ' .. get_review_template_path(reviews_dir, 'year'))
end

-- Open current week weekly review file
-- Created buffer is dated to Sunday of current week
-- Opens current week because Sunday is good time to do this review
M.vimwiki_weekly_review = function(...)
	local reviews_dir = get_reviews_dir(...)
	local days_to_sunday = 7 - tonumber(os.date('%u'))
	local week_date = os.date('%Y-%m-%d', os.time() + days_to_sunday * 24 * 60 * 60)
	local file_name = reviews_dir .. week_date .. '-week.md'
	local exists = vim.fn.filereadable(vim.fn.glob(file_name)) == 1
	vim.cmd('edit ' .. file_name)
	if (exists == false)
		then
		read_review_template_into_buffer(reviews_dir, 'week')
		vim.cmd('%substitute/%date%/' .. week_date)
	end
end


-- Open past month monthly review file
-- Created buffer is dated to previous month
-- Previous month is calculated in an erroneous way
-- 28 days are subtracted from current time to get previous month
M.vimwiki_monthly_review = function(...)
	local reviews_dir = get_reviews_dir(...)
	local month_time = os.time() - 28 * 24 * 60 * 60
	local month_date = os.date('%Y-%m', month_time)
	local file_name = reviews_dir .. month_date .. '-month.md'
	local exists = vim.fn.filereadable(vim.fn.glob(file_name)) == 1
	vim.cmd('edit ' .. file_name)
	if (exists == false)
		then
		read_review_template_into_buffer(reviews_dir, 'month')
		vim.cmd('%substitute/%date%/' .. os.date('%Y %B', month_time))
	end
end

-- Open past year yearly review file
-- Created buffer is dated to previous year
M.vimwiki_yearly_review = function(...)
	local reviews_dir = get_reviews_dir(...)
	local year_date = (tonumber(os.date('%Y')) - 1)
	local file_name = reviews_dir .. year_date .. '-year.md'
	local exists = vim.fn.filereadable(vim.fn.glob(file_name)) == 1
	vim.cmd('edit ' .. file_name)
	if (exists == false)
		then
		read_review_template_into_buffer(reviews_dir, 'year')
		vim.cmd('%substitute/%date%/' .. year_date)
	end
end

-- Open reviews index file
M.vimwiki_review_index = function(...)
	local reviews_dir = get_reviews_dir(...)
	vim.cmd('edit ' .. reviews_dir .. 'reviews.md')
end

return M
