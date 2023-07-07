
vim.g.mapleader = " "
  -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n><CR>')
vim.keymap.set('t', '<C-o>', '<C-\\><C-n><CR><C-o>')

