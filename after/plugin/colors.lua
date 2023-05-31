local c = require('vscode.colors').get_colors()

require('vscode').setup({
    style = 'dark',
    transparent = true,
    italic_comments = true,
    disable_nvimtree_bg = true,
    group_overrides = {
        ["@keyword"] = { fg = c.vscBlue, bg = c.vscNone },
        ["@include"] = { fg = c.vscBlue, bg = c.vscNone },
        ["@keyword.return"] = { fg = c.vscPink, bg = c.vscNone },
        ["LineNr"] = { fg = c.vscGray, bg = c.vscNone },
        ["CursorLineNr"] = { fg = c.vscFront, bg = c.vscNone },
    }
})

require('vscode').load()

vim.api.nvim_set_hl(0, "TSRainbowYellow", { fg = '#fad632' })
vim.api.nvim_set_hl(0, "TSRainbowViolet", { fg = '#cd7bd3' })
vim.api.nvim_set_hl(0, "TSRainbowBlue", { fg = '#41a1fc' })
