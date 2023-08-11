return {
    "rcarriga/nvim-notify",
    lazy = false,
    keys = {
        { "<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss all Notifications" },
        { "<leader>pn", ":Telescope notify<cr>", desc = "Show all notificatins in telescope" }
    },
    opts = {
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
        background_colour = "#FFFFFF"
    },
    config = function(_, opts)
        require("telescope").load_extension("notify")
        require("notify").setup(opts)
        vim.notify = require("notify")
    end
}
