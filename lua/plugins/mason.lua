return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "MasonUpdate" },
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
}
