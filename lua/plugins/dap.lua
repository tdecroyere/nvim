return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "rcarriga/nvim-dap-ui"
    },
    opts = {
        dap_servers = {
            coreclr = {
                setup = {
                    type = "executable",
                    command = "netcoredbg",
                    args = { "--interpreter=vscode" },
                    options = { detached = false }
                },
                extension = "cs",
                configurations = {
                    {
                        type = "coreclr",
                        name = "Launch .NET",
                        request = "launch",
                        cwd = "${fileDirname}",
                        subProcess = false,
                        program = function()
                            return coroutine.create(function(dap_run_co)
                                local items = vim.fn.globpath(vim.fn.getcwd(), '**/bin/**/Debug/**/*.dll', 0, 1)
                                local opts = {
                                    format_item = function(path)
                                        return vim.fn.fnamemodify(path, ':t')
                                    end,
                                }
                                local function cont(choice)
                                    if choice == nil then
                                        return nil
                                    else
                                        coroutine.resume(dap_run_co, choice)
                                    end
                                end

                                vim.ui.select(items, opts, cont)
                            end)
                        end
                    }
                }
            },
            cppdbg = {
                setup = {
                    type = "executable",
                    command = "OpenDebugAD7",
                    options = { detached = false }
                },
                extension = "cpp",
                configurations = {
                    {
                        name = 'Launch file',
                        type = 'cppdbg',
                        request = 'launch',
                        program = function()
                            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                        end,
                        cwd = '${workspaceFolder}',
                        stopAtEntry = true,
                    }
                }
            }
        }
    },
    config = function(_, opts)
        local ensure_installed = {}

        local dap = require("dap")
        local dapui = require("dapui")

        for dap_server_name, _ in pairs(opts.dap_servers) do
            ensure_installed[#ensure_installed + 1] = dap_server_name
        end

        require("mason").setup()
        require("mason-nvim-dap").setup({
            ensure_installed = ensure_installed
        })

        for dap_server_name, dap_server_config in pairs(opts.dap_servers) do
            dap.adapters[dap_server_name] = dap_server_config.setup
            dap.configurations[dap_server_config.extension] = dap_server_config.configurations

            dap.adapters[dap_server_name].command = vim.fn.exepath(dap_server_config.setup.command)
        end

        --dap.set_log_level("TRACE")
        --require('dap.ext.vscode').load_launchjs(nil, {})

        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
        vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

        vim.keymap.set('n', '<F5>', require 'dap'.continue)
        vim.keymap.set('n', '<F10>', require 'dap'.step_over)
        vim.keymap.set('n', '<F11>', require 'dap'.step_into)
        vim.keymap.set('n', '<F12>', require 'dap'.step_out)
        vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
    end
}
