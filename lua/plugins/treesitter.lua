return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { 
        "nvim-treesitter/nvim-treesitter-textobjects",
        "HiPhish/nvim-ts-rainbow2"
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    opts = {
        highlight = { 
            enable = true,
            additional_vim_regex_highlighting = false 
        },
        indent = { 
            enable = true 
        },
        ensure_installed = {
            "c", 
            "cpp", 
            "c_sharp", 
            "hlsl", 
            "usd", 
            "cmake", 
            "javascript", 
            "typescript", 
            "html", 
            "jsonc", 
            "yaml", 
            "lua", 
            "vim", 
            "vimdoc",
            "query"
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                scope_incremental = "<CR>",
                node_incremental = "<TAB>",
                node_decremental = "<S-TAB>",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                    ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                },
                selection_modes = {
                    ["@parameter.outer"] = "v",                    
                    ["@function.outer"] = "V",
                    ["@class.outer"] = "<c-v>",
                },
                include_surrounding_whitespace = true,
            },
            -- TODO: Object selection
        },
        rainbow = {
            enable = true,
            query = "rainbow-parens",
            hlgroups = {
                "TSRainbowYellow",
                "TSRainbowViolet",
                "TSRainbowBlue",
            },
        },
    },
    config = function(_, opts)
        opts.rainbow.strategy = require("ts-rainbow").strategy.global

        require("nvim-treesitter.configs").setup(opts)
    end
}
