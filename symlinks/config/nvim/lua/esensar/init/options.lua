local opt = vim.opt

-- Not needed?
opt.wildignore = "__pycache__"
opt.wildignore = opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }

-- Indentation config
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Misc
opt.backspace = "indent,eol,start" -- Allow backspacing over everything in insert mode
opt.ttimeoutlen = 50
opt.history = 50 -- Keep 50 lines of command line history
opt.ruler = true -- Show the cursor position all the time
opt.laststatus = 2 -- Always display the status line
opt.undofile = true -- Enable undofile (auto supported in NeoVim)
opt.showcmd = true -- Display incomplete commands
opt.incsearch = true -- Do incremental searching
opt.autoread = true -- Reload files changed outside
opt.hidden = true -- Allow leaving unsaved buffers
opt.inccommand = "nosplit" -- Enable live preview of text replacement
opt.hlsearch = true
opt.mouse = "a"

opt.encoding = "utf-8"

opt.exrc = true
