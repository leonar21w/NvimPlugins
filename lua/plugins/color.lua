return {
    -- 1) color engine
    {
        "tjdevries/colorbuddy.nvim",
        lazy = true, -- loaded by noirbuddy
    },

    -- 2) nvim-noirbuddy (minimal preset)
    {
        "jesseleite/nvim-noirbuddy",
        dependencies = { "tjdevries/colorbuddy.nvim" },
        lazy         = false,
        priority     = 1000,
        opts         = { preset = "minimal", plugins = { telescope = true, lualine = true } },
        config       = function(_, opts)
            vim.o.termguicolors = true
            vim.o.background    = "dark"
            require("noirbuddy").setup(opts)
        end,
    },


    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = function()
            local transparent = require("transparent")
            transparent.setup({
                groups = {
                    "Normal", "NormalNC", "FoldColumn", "EndOfBuffer",
                    "CursorLineNr", "SignColumn",
                    "DiagnosticSignError", "DiagnosticSignWarn",
                    "DiagnosticSignInfo", "DiagnosticSignHint",
                },
                exclude_groups = {
                    "Visual", "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
                },
                extra_groups = {},
            })

            local function preserve_number_highlight()
                local hl = vim.api.nvim_set_hl
                local fg = "#c0caf5"
                for _, g in ipairs({
                    "CursorLineNr", "SignColumn",
                    "DiagnosticSignError", "DiagnosticSignWarn",
                    "DiagnosticSignInfo", "DiagnosticSignHint",
                }) do
                    hl(0, g, { bg = "none" })
                end
                hl(0, "LineNr", { fg = fg, bg = "none" })
                hl(0, "CursorLineNr", { fg = fg, bg = "none" })
            end

            -- initial cleanup if you want transparency at startup:
            if vim.g.transparent_enabled then preserve_number_highlight() end

            vim.keymap.set("n", ";b", function()
                transparent.toggle()
                if vim.g.transparent_enabled then
                    preserve_number_highlight()
                end
            end, { desc = "Toggle background transparency" })
        end,
    },
}
