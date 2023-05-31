local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-q>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-d>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-f>", function() ui.nav_file(4) end)
vim.keymap.set("n", "<C-g>", function() ui.nav_file(5) end)

vim.keymap.set("n", "<C-a>", function() term.gotoTerminal(1) vim.cmd('startinsert') end)
vim.keymap.set("n", "<C-z>", function() term.gotoTerminal(2) vim.cmd('startinsert') end)

vim.keymap.set('t', '<C-q>', function() ui.nav_file(1) end)
vim.keymap.set('t', '<C-s>', function() ui.nav_file(2) end)
vim.keymap.set('t', '<C-d>', function() ui.nav_file(3) end)
vim.keymap.set('t', '<C-f>', function() ui.nav_file(4) end)
vim.keymap.set('t', '<C-g>', function() ui.nav_file(5) end)

vim.keymap.set("t", "<C-a>", function() term.gotoTerminal(1) vim.cmd('startinsert') end)
vim.keymap.set("t", "<C-z>", function() term.gotoTerminal(2) vim.cmd('startinsert') end)
