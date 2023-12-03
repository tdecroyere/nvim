return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind.nvim",
        "Fildo7525/pretty_hover"
    },
    opts = {
        diagnostic = {
            severity_sort = true
        },
        diagnostic_signs = {
            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn", text = "" },
            { name = "DiagnosticSignHint", text = "" },
            { name = "DiagnosticSignInfo", text = "" }
        },
        lsp_servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                "vim",
                                "require"
                            },
                        },
                    },
                }
            },
            omnisharp = { },
            clangd = {
                cmd = {
                    "clangd",
                    "--header-insertion=never"
                }
            }
        }
    },
    config = function(_, opts)
        -- TODO: Add support to V0.10.0 virtual text prefix
        for _, sign in ipairs(opts.diagnostic_signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end

        vim.diagnostic.config({ opts.diagnostic })

        local ensure_installed = {}

        for lsp_server_name, _ in pairs(opts.lsp_servers) do
            ensure_installed[#ensure_installed + 1] = lsp_server_name
        end

        require("mason-lspconfig").setup({
            ensure_installed = ensure_installed
        })

        require("pretty_hover").setup()

        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            sources = {
                { name = "nvim_lsp" }
            },
            mapping = {
                ["<CR>"] = cmp.mapping.confirm({select = true}),
                ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            },
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol",
                    preset = "codicons",
                    maxwidth = 50,
                    ellipsis_char = "...",
                })
            }
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        for lsp_server_name, lsp_server_config in pairs(opts.lsp_servers) do
            lsp_server_config.capabilities = capabilities
            require("lspconfig")[lsp_server_name].setup(lsp_server_config)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local parameters = { buffer = ev.buf }

                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, parameters)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, parameters)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, parameters)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, parameters)
                --vim.keymap.set("n", "K", vim.lsp.buf.hover, parameters)
                vim.keymap.set("n", "K", require "pretty_hover".hover, parameters)

                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, parameters)
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, parameters)
            end
        })
    end
}
