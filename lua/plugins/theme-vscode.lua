return {
    "Mofiqul/vscode.nvim",
    opts = {
        style = 'dark',
        transparent = true,
        italic_comments = false,
        disable_nvimtree_bg = true
    },
    config = function(_, opts)
        local colors = require('vscode.colors').get_colors()

        opts.group_overrides = {
            ["@keyword"] = { fg = colors.vscBlue, bg = colors.vscNone },
            ["@include"] = { fg = colors.vscBlue, bg = colors.vscNone },
            ["@keyword.return"] = { fg = colors.vscPink, bg = colors.vscNone },
            ["LineNr"] = { fg = colors.vscGray, bg = colors.vscNone },
            ["CursorLineNr"] = { fg = colors.vscFront, bg = colors.vscNone }
        }

        require('vscode').setup(opts)
        vim.cmd('colorscheme vscode')

        vim.api.nvim_set_hl(0, "TSRainbowYellow", { fg = '#fad632' })
        vim.api.nvim_set_hl(0, "TSRainbowViolet", { fg = '#cd7bd3' })
        vim.api.nvim_set_hl(0, "TSRainbowBlue", { fg = '#41a1fc' })

        vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
    end
}
