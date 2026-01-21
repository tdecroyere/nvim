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
vim.opt.sessionoptions = { "buffers", "curdir" }

vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

vim.cmd.language("en_US")

if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.opt.shell = "pwsh.exe"
end

----------------------------------------------------------------------------------------------------------
-- Packages
----------------------------------------------------------------------------------------------------------

vim.pack.add({
    { src = "https://github.com/Mofiqul/vscode.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/Saghen/blink.cmp", version = "v1.8.0" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version="main" },
    { src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-file-browser.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/rmagatti/auto-session" },
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/RRethy/vim-illuminate" },
    { src = "https://github.com/ThePrimeagen/harpoon", version="harpoon2" },
})

require("auto-session").setup({})

local harpoon = require("harpoon")
harpoon:setup()

-- HACK: This is a temporary solution until Harpoon2 will implement native terminal support
local term_list = harpoon:list("terms") -- note the : instead of .

local function create_terminal()
	vim.cmd("terminal")
	local buf_id = vim.api.nvim_get_current_buf()
	return vim.api.nvim_buf_get_name(buf_id)
end

local function select_term(index)
    if index > term_list:length() then
        create_terminal()
        term_list:add()
    else
        term_list:select(index)
    end
end

local function remove_closed_terms()
	for _, term in ipairs(term_list.items) do
		local bufnr = vim.fn.bufnr(term.value)
		if bufnr == -1 then
			term_list:remove(term)
		end
	end
end

-- "VimEnter" cleans terminals that were saved when you closed vim for the last time but were not removed
vim.api.nvim_create_autocmd({ "TermClose", "VimEnter" }, {
	pattern = "*",
	callback = remove_closed_terms,
})

-- This is needed because closing term with bd! won't trigger "TermClose"
vim.api.nvim_create_autocmd({ "BufDelete", "BufUnload" }, {
	pattern = "term://*",
	callback = remove_closed_terms,
})

vim.api.nvim_create_user_command("HarpoonShowTermList", function()
	harpoon.ui:toggle_quick_menu(term_list)
end, {})

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

vim.api.nvim_set_hl(0, "TSRainbowYellow", { fg = '#fad632' })
vim.api.nvim_set_hl(0, "TSRainbowViolet", { fg = '#cd7bd3' })
vim.api.nvim_set_hl(0, "TSRainbowBlue", { fg = '#41a1fc' })

vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

require("lualine").setup({
    sections = {
        lualine_c = { { "filename", path = 1, file_status = true } },
        lualine_x = { { "datetime", style = "%H:%M:%S" } },
    }
})

----------------------------------------------------------------------------------------------------------
-- Languages Configuration
----------------------------------------------------------------------------------------------------------

require("nvim-treesitter").setup({})
require("nvim-treesitter").install({
    "c",
    "cpp",
    "c_sharp",
    "hlsl",
    "usd",
    "cmake",
    "javascript",
    "typescript",
    "html",
    "xml",
    "json",
    "yaml",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "markdown_inline",
    "slang",
    "python"
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then 
        return 
    end

    local fileType = vim.bo[args.buf].filetype

    if fileType == "" then 
        return 
    end

    local lang = vim.treesitter.language.get_lang(fileType)

    if not lang then 
        return 
    end

    local result = vim.treesitter.language.add(lang)

    if result then
      vim.treesitter.start(args.buf, lang)
    end
  end
})

require("rainbow-delimiters.setup").setup({
    highlight = {
        "TSRainbowYellow",
        "TSRainbowViolet",
        "TSRainbowBlue"
    }
})

require("ibl").setup({
    scope = {
        enabled = false
    }
})

require("todo-comments").setup({
    colors = {
        info = { "Comment", "#2563EB" },
    },
    highlight = {
        before = "",
        keyword = "bg",
        after = "fg"
    }
})

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
    },
    appearance = {
        kind_icons = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",

            Field = "",
            Variable = "",
            Property = "",

            Class = "",
            Interface = "",
            Struct = "",

            Unit = "",
            Value = "",
            Enum = "",
            EnumMember = "",

            Keyword = "",
            Constant = "",

            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",

            Event = "",
            Operator = "",
            TypeParameter = ""
        }
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

----------------------------------------------------------------------------------------------------------
-- Shortcuts
----------------------------------------------------------------------------------------------------------

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>up", function()
    vim.pack.update()
    vim.cmd("TSUpdate")
end)

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set({"n", "t"}, "<C-q>", function() harpoon:list():select(1) end)
vim.keymap.set({"n", "t"}, "<C-s>", function() harpoon:list():select(2) end)
vim.keymap.set({"n", "t"}, "<C-d>", function() harpoon:list():select(3) end)
vim.keymap.set({"n", "t"}, "<C-f>", function() harpoon:list():select(4) end)
vim.keymap.set({"n", "t"}, "<C-f>", function() harpoon:list():select(5) end)

vim.keymap.set({"n", "t"}, "<C-a>", function() select_term(1) vim.cmd("startinsert") end)
vim.keymap.set({"n", "t"}, "<C-z>", function() select_term(2) vim.cmd("startinsert") end)

vim.keymap.set("t", "<Esc>", "<C-\\><C-n><CR>")
vim.keymap.set("t", "<C-o>", "<C-\\><C-n><CR><C-o>")

vim.keymap.set("n", "gd", vim.lsp.buf.definition)

vim.keymap.set("n", "<leader>pf", function() require("telescope.builtin").find_files() end)
vim.keymap.set("n", "<leader>pb", function() require("telescope.builtin").buffers() end)
vim.keymap.set("n", "<leader>ps", function() require("telescope.builtin").live_grep() end)
vim.keymap.set("n", "<leader>pt", ":TodoTelescope<cr>")
vim.keymap.set("n", "<leader>pv", function()
            require("telescope").extensions.file_browser.file_browser({
                path = "%:p:h",
                select_buffer = true,
                grouped = true,
                sorting_strategy = 'ascending',
                display_stat = { date = true, size = true }
            })
        end)
