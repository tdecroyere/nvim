return {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
        { "<leader>pt", ":TodoTelescope<cr>" }
    },
    opts = {
        colors = {
            info = { "Comment", "#2563EB" },
        },
        highlight = {
            before = "",
            keyword = "bg",
            after = "fg"
        }
    }
}
