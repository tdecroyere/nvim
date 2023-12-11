return {
    "jackMort/ChatGPT.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    },
    event = "VeryLazy",
    keys = {
--        { "<leader>cd", ":ChatGPTRun custom-docstring<cr>" }
    },
    config = function()
        require("chatgpt").setup({
            actions_paths = { debug.getinfo(1, "S").source:sub(2):match("(.*/)") .. "chatgpt-actions.json" },
        })
    end
}
