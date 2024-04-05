return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "nvim-neotest/nvim-nio",
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
                                local items = vim.fn.globpath(vim.fn.getcwd(), 'artifacts/**/bin/**/Debug/**/*.exe', 0, 1)
                                local opts = {
                                    format_item = function(path)
                                        return vim.fn.fnamemodify(path, ':t')
                                    end,
                                }
                                local function cont(choice)
                                    if choice == nil then
                                        return nil
                                    else
                                        choice = choice:gsub(".exe", ".dll")
                                        coroutine.resume(dap_run_co, choice)
                                    end
                                end

                                vim.ui.select(items, opts, cont)
                            end)
                        end
                    }
                }
            },
            codelldb = {
                setup = {
                    type = "server",
                    port = "${port}",
                    executable = {
                        command = "codelldb",
                        args = { "--port", "${port}" }
                    },
                    options = { detached = false }
                },
                extension = "c;cpp",
                configurations = {
                    {
                        name = 'Launch file',
                        type = 'codelldb',
                        request = 'launch',
                        program = function()
                            return coroutine.create(function(dap_run_co)
                                --local items = vim.fn.globpath(vim.fn.getcwd(), 'artifacts/**/bin/**/debug/*.exe', 0, 1)
                                local items = vim.fn.globpath(vim.fn.getcwd(), 'build/bin/debug/*', 0, 1) -- Filter libs
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
                        end,
                        cwd = '${workspaceFolder}',
                        stopAtEntry = false,
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

            for language in string.gmatch(dap_server_config.extension, "([^"..";".."]+)") do
                dap.configurations[language] = dap_server_config.configurations
            end

            if dap_server_config.setup.command then
                dap.adapters[dap_server_name].command = vim.fn.exepath(dap_server_config.setup.command)
            end

            if dap_server_config.setup.executable then
                dap.adapters[dap_server_name].executable.command = vim.fn.exepath(dap_server_config.setup.executable.command)
            end
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

        vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapBreakpointRejected', {text='🚫', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapStopped', {text='➡️', texthl='', linehl='DebugBreakpointLine', numhl=''})

        vim.keymap.set('n', '<F5>', require 'dap'.continue)
        vim.keymap.set('n', '<F10>', require 'dap'.step_over)
        vim.keymap.set('n', '<F11>', require 'dap'.step_into)
        vim.keymap.set('n', '<F12>', require 'dap'.step_out)
        vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
    end
}
