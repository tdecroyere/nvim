return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    version = "2.20.8", -- temporary
    opts = {
        use_treesitter = true,
        show_trailing_blankline_indent = false
    }
}
