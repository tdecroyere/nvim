local options = vim.opt

options.signcolumn = "yes" -- When and how to display the sign column
options.number = true -- Print the line number in front of each line
options.relativenumber = true -- Show relative line number in front of each line
options.cursorline = true -- Highlight the screen line of the cursor
options.cursorlineopt = "number" -- Settings for 'cursorline'

options.tabstop = 4 -- Number of spaces that <Tab> in file uses
options.softtabstop = 4 -- Number of spaces that <Tab> uses while editing
options.shiftwidth = 4 -- Number of spaces to use for (auto)indent step
options.expandtab = true -- Use spaces when <Tab> is inserted
options.smartindent = true -- Smart autoindenting for C programs
options.wrap = false -- Long lines wrap and continue on the next line
options.colorcolumn = "0" -- Columns to highlight

options.autoread = true -- Automatically read file when changed outside of Vim
options.autowrite = true -- Automatically write file if changed
options.autowriteall = true -- As 'autowrite', but works with more commands 
options.clipboard = "unnamedplus" -- Sync with system clipboard
options.updatetime = 50 -- After this many milliseconds flush swap file
options.undofile = true -- Save undo information in a file
options.undolevels = 1000 -- Maximum number of changes that can be undone

options.hlsearch = false -- Highlight matches with last search pattern
options.incsearch = true -- Highlight match while typing search pattern

options.termguicolors = true -- Use true terminal colors
options.shortmess:append({ W = true, I = true, c = true, C = true }) -- List of flags, reduce length of messages
options.showmode = false -- Message on status line to show current mode
options.guicursor = "" -- GUI: settings for cursor shape and blinking
options.isfname:append("@-@") -- Characters included in file names and pathnames
options.sessionoptions = { "buffers", "curdir" } -- Options for |:mksession|

options.scrolloff = 8 -- Minimum nr. of lines above and below cursor

vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

vim.api.nvim_exec("language en_US", true)

if vim.loop.os_uname().sysname == "Windows_NT" then
    options.shell = "pwsh.exe"
end
