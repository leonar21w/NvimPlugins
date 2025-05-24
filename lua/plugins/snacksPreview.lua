return {
    -- Snacks.nvim: minimal setup
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy     = false,
        opts     = {
            image        = { enabled = true },
            bigfile      = { enabled = true },
            dashboard    = { enabled = true },
            indent       = { enabled = true },
            picker       = { enabled = true },
            notifier     = { enabled = true },
            scope        = { enabled = true },
            words        = { enabled = true },
            statuscolumn = { enabled = true },
        },
    },

    -- Noice.nvim: enhanced command-line & LSP UI
    {
        "folke/noice.nvim",
        event        = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts         = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"]                = true,
                    ["cmp.entry.get_documentation"]                  = true,
                },
            },
            presets = {
                bottom_search         = true,
                command_palette       = true,
                long_message_to_split = true,
                inc_rename            = false,
                lsp_doc_border        = false,
            },
        },
        config       = function(_, opts)
            require("noice").setup(opts)
        end,
    },
}
