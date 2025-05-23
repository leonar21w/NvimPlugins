return {
    "catppuccin/nvim",
    name         = "catppuccin",
    lazy         = false,
    dependencies = {
        "xiyaowong/transparent.nvim",
    },
    opts         = {

        transparent_background = vim.g.transparent_enabled, -- :contentReference[oaicite:0]{index=0}

        -- other niceties
        show_end_of_buffer     = false, -- hide the ~ after EOF
        term_colors            = false, -- don’t redefine :terminal colors
        dim_inactive           = {
            enabled    = false,
            shade      = "dark",
            percentage = 0.15,
        },
        no_italic              = false,
        no_bold                = false,
        no_underline           = false,

        styles                 = {
            comments     = { "italic" },
            conditionals = { "italic" },
            loops        = {},
            functions    = {},
            keywords     = {},
            strings      = {},
            variables    = {},
            numbers      = {},
            booleans     = {},
            properties   = {},
            types        = {},
            operators    = {},
        },

        color_overrides        = {},
        custom_highlights      = function(colors)
            -- clear out any default bg for popups / line-numbers / diagnostics
            return {
                Pmenu               = { bg = colors.none },
                PmenuSel            = { bg = colors.surface2 },
                PmenuThumb          = { bg = colors.surface2 },
                Normal              = { bg = colors.none },
                NormalNC            = { bg = colors.none },
                FoldColumn          = { bg = colors.none },
                EndOfBuffer         = { bg = colors.none },
                SignColumn          = { bg = colors.none },

                CursorLineNr        = { fg = colors.text, bg = colors.none },
                LineNr              = { fg = colors.text, bg = colors.none },

                DiagnosticSignError = { fg = colors.red, bg = colors.none },
                DiagnosticSignWarn  = { fg = colors.yellow, bg = colors.none },
                DiagnosticSignInfo  = { fg = colors.blue, bg = colors.none },
                DiagnosticSignHint  = { fg = colors.teal, bg = colors.none },
            }
        end,
        default_integrations   = true,
        integrations           = {
            treesitter = true,
            gitsigns = true,
        }
    },
}
