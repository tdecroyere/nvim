return {
    "ThePrimeagen/harpoon",
    lazy = false,
    keys = {
        { "<leader>a", function() require("harpoon.mark").add_file() end },
        { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end },
        
        { "<C-q>", function() require("harpoon.ui").nav_file(1) end },
        { "<C-s>", function() require("harpoon.ui").nav_file(2) end },
        { "<C-d>", function() require("harpoon.ui").nav_file(3) end },
        { "<C-f>", function() require("harpoon.ui").nav_file(4) end },
        { "<C-g>", function() require("harpoon.ui").nav_file(5) end },
        
        { "<C-a>", function() require("harpoon.term").gotoTerminal(1) vim.cmd("startinsert") end },
        { "<C-z>", function() require("harpoon.term").gotoTerminal(2) vim.cmd("startinsert") end },
        
        { mode = "t", "<C-q>", function() require("harpoon.ui").nav_file(1) end },
        { mode = "t", "<C-s>", function() require("harpoon.ui").nav_file(2) end },
        { mode = "t", "<C-d>", function() require("harpoon.ui").nav_file(3) end },
        { mode = "t", "<C-f>", function() require("harpoon.ui").nav_file(4) end },
        { mode = "t", "<C-g>", function() require("harpoon.ui").nav_file(5) end },
        
        { mode = "t", "<C-a>", function() require("harpoon.term").gotoTerminal(1) vim.cmd("startinsert") end },
        { mode = "t", "<C-z>", function() require("harpoon.term").gotoTerminal(2) vim.cmd("startinsert") end }
    }
}
