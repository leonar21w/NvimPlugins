return {
    "wojciech-kulik/xcodebuild.nvim",
    -- only load in an Xcode project folder
    cond = function()
        return vim.fn.glob("*.xcodeproj") ~= ""
            or vim.fn.glob("*.xcworkspace") ~= ""
    end,
    -- also lazy-load on Swift/Obj-C/C/C++ filetypes
    ft = { "swift", "objective-c", "c", "cpp", "m", "mm" },
    -- or when you call any of these commands
    cmd = {
        "XcodebuildSetup",
        "XcodebuildPicker",
        "XcodebuildBuild",
        "XcodebuildBuildRun",
        "XcodebuildTest",
        "XcodebuildToggleLogs",
        "XcodebuildToggleCodeCoverage",
        "XcodebuildSelectDevice",
    },
    dependencies = {
        "nvim-telescope/telescope.nvim", -- fuzzy pickers (optional)
        "MunifTanjim/nui.nvim",          -- floating UI
        "folke/snacks.nvim",             -- SwiftUI/AppKit previews
    },
    config = function()
        local lspconfig                          = require("lspconfig")
        local util                               = lspconfig.util

        vim.highlight.priorities.semantic_tokens = 0
        -- 1) SourceKit-LSP: Xcode’s settings + fast indexing
        lspconfig.sourcekit.setup({
            cmd          = { "xcrun", "sourcekit-lsp" },
            filetypes    = { "swift", "m", "mm" },
            root_dir     = util.root_pattern( -- auto-find your project root
                "Package.swift",
                ".xcworkspace",
                ".xcodeproj",
                ".git"
            ),
            init_options = {
                ["sourcekit-lsp"] = {
                    completeBuildTargets = true, -- full symbol completion per target
                    enableIndexing       = true, -- incremental, super-fast indexing
                },
            },
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach    = function(client, bufnr)
                require("lsp_signature").on_attach({ bind = true }, bufnr)
            end,
        })

        -- 2) xcodebuild.nvim core: remember your last choices
        require("xcodebuild").setup({
            restore_on_start      = true, -- auto-restore last scheme/config/device
            default_scheme        = nil,  -- nil = use whatever your project’s default is
            default_configuration = nil,  -- nil = Debug/Release as per your .xcscheme
            default_device        = nil,
        })

        -- 3) Floating picker on ;p
        vim.keymap.set("n", ";p", "<cmd>XcodebuildPicker<cr>", {
            desc = " Xcodebuild: Picker",
        })

        -- 4) Only run the wizard once per new project, then auto-restore
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                if vim.fn.glob("*.xcodeproj") ~= ""
                    or vim.fn.glob("*.xcworkspace") ~= "" then
                    -- if no saved state yet, run setup; else skip
                    if not require("xcodebuild").has_saved_state() then
                        vim.defer_fn(function()
                            vim.cmd("XcodebuildSetup")
                        end, 50)
                    end
                end
            end,
        })

        -- 5) swiftformat on save
        require("conform").setup({
            formatters_by_ft = {
                swift = { "swiftformat" },
            },
        })

        -- 6) Safely load Telescope extension (if you do install it)
        local ok, telescope = pcall(require, "telescope")
        if ok and telescope.load_extension then
            pcall(telescope.load_extension, "xcodebuild")
        end

        -- 7) Show build/test status in your lualine
        pcall(require("lualine").setup, {
            sections = {
                lualine_x = {
                    -- ... your other components ...
                    {
                        function() return require("xcodebuild").get_status() end,
                        icon = "",
                    },
                },
            },
        })
    end,
}
