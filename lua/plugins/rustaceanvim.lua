return {
    'mrcjkb/rustaceanvim',
    -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
    -- No need for lazy.nvim to lazy-load it.
    lazy = false,
    init = function()
        vim.g.rustaceanvim = {
            -- Enable the plugin for Rust files.
            enable_for_rust = true,
            -- Enable the plugin for Cargo.toml files.
            enable_for_cargo_toml = true,
            -- Enable the plugin for Cargo.lock files.
            enable_for_cargo_lock = true,
        }

        vim.g.rustaceanvim = function()
            local extension_path = "/opt/homebrew/opt/lldb/"
            local codelldb_path = extension_path .. 'bin/codelldb'
            local liblldb_path = extension_path .. 'lib/liblldb'
            local this_os = vim.uv.os_uname().sysname;

            -- The path is different on Windows
            if this_os:find "Windows" then
                codelldb_path = extension_path .. "adapter\\codelldb.exe"
                liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
            else
                -- The liblldb extension is .so for Linux and .dylib for MacOS
                liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
            end

            local cfg = require('rustaceanvim.config')
            return {
                dap = {
                    adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
                },
            }
        end
    end,
}
