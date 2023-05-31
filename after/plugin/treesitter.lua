require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "cpp", "c_sharp", "hlsl", "usd", "cmake", "javascript", "typescript", "html", "jsonc", "yaml", "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    query = 'rainbow-parens',
    strategy = require('ts-rainbow').strategy.global,
    hlgroups = {
               'TSRainbowYellow',
               'TSRainbowViolet',
               'TSRainbowBlue',
               },
  },
}
