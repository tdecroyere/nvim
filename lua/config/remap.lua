vim.g.mapleader = " "

-- Normal Mode remap
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Terminal Mode remap
vim.keymap.set("t", "<Esc>", "<C-\\><C-n><CR>")
vim.keymap.set("t", "<C-o>", "<C-\\><C-n><CR><C-o>")
