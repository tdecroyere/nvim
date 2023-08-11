return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        sections = {
            lualine_c = { { "filename", path = 1, file_status = true } },
            lualine_x = { { "datetime", style = "%H:%M:%S" } },
        }
    }
}
