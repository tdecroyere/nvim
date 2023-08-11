return {
    "nvim-telescope/telescope.nvim", branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    keys = {
        { "<leader>pf", function() require("telescope.builtin").find_files() end, desc = "Find files" },
        { "<C-p>", function() require("telescope.builtin").git_files() end, desc = "Git files" },
        { "<leader>pb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
        { "<leader>ps", function() require("telescope.builtin").live_grep() end, desc = "Search" }
    },
    config = true
}
