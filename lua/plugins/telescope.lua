return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "xiyaowong/telescope-emoji.nvim"
    },
    lazy = false,
    keys = {
        { "<leader>pf", function() require("telescope.builtin").find_files() end, desc = "Find files" },
        { "<C-p>", function() require("telescope.builtin").git_files() end, desc = "Git files" },
        { "<leader>pb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
        { "<leader>ps", function() require("telescope.builtin").live_grep() end, desc = "Search" },
        { "<leader>pe", ":Telescope emoji<cr>", desc = "Show emojis" },
        { "<leader>pv", function()
            require("telescope").extensions.file_browser.file_browser({
                path = "%:p:h",
                select_buffer = true,
                grouped = true,
                sorting_strategy = 'ascending',
                display_stat = { date = true, size = true }
            })
        end, desc = "Project Files" }
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("notify")
        require("telescope").load_extension("emoji")
    end
}
