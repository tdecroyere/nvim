----------------------------------------------------------------------------------------------------------
-- General Configuration
----------------------------------------------------------------------------------------------------------

vim.opt.swapfile = false

vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.guicursor = ""

vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = -1
vim.opt.scrolloff = 8

vim.opt.hlsearch = false

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>up", vim.pack.update)

vim.pack.add({
    "https://github.com/Mofiqul/vscode.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    { src = "https://github.com/Saghen/blink.cmp", version = "v1.8.0" }
})


----------------------------------------------------------------------------------------------------------
-- Theme Configuration
----------------------------------------------------------------------------------------------------------

local colors = require("vscode.colors").get_colors()

require("vscode").setup({
    transparent = true,
    group_overrides = {
        ["@keyword"] = { fg = colors.vscBlue, bg = colors.vscNone },
        ["@include"] = { fg = colors.vscBlue, bg = colors.vscNone },
        ["@keyword.return"] = { fg = colors.vscPink, bg = colors.vscNone },
        ["LineNr"] = { fg = colors.vscGray, bg = colors.vscNone },
        ["CursorLineNr"] = { fg = colors.vscFront, bg = colors.vscNone }
    }
})

vim.cmd("colorscheme vscode")

----------------------------------------------------------------------------------------------------------
-- Languages Configuration
----------------------------------------------------------------------------------------------------------

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "clangd"
    }
})

require("blink.cmp").setup({
    keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
    },
    signature = { enabled = true },
    completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true }
    }
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
})

