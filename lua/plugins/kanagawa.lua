-- plugins/kanagawa_toggle.lua
return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.o.termguicolors = true
        vim.o.background = "dark"

        local is_transparent = false

        local function load_kanagawa()
            require("kanagawa").setup({
                transparent = is_transparent,
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                            },
                        },
                    },
                },
                overrides = function(colors)
                    local theme = colors.theme
                    local base = {
                        SignColumn                 = { bg = "none" },
                        LineNr                     = { bg = "none" },
                        CursorLineNr               = { bg = "none" },
                        FoldColumn                 = { bg = "none" },
                        VertSplit                  = { bg = "none" },
                        NormalFloat                = { bg = "none" },
                        FloatBorder                = { bg = "none" },
                        FloatTitle                 = { bg = "none" },
                        DiagnosticVirtualTextError = { bg = "none" },
                        DiagnosticVirtualTextWarn  = { bg = "none" },
                        DiagnosticVirtualTextInfo  = { bg = "none" },
                        DiagnosticVirtualTextHint  = { bg = "none" },
                        DiagnosticFloatingError    = { bg = "none" },
                        DiagnosticFloatingWarn     = { bg = "none" },
                        DiagnosticFloatingInfo     = { bg = "none" },
                        DiagnosticFloatingHint     = { bg = "none" },
                    }

                    if not is_transparent then
                        return base
                    end

                    return vim.tbl_extend("force", base, {
                        Normal     = { bg = "none" },
                        NormalNC   = { bg = "none" },
                        Pmenu      = { bg = "none" },
                        PmenuSel   = { bg = theme.ui.bg_p1 },
                        PmenuSbar  = { bg = "none" },
                        PmenuThumb = { bg = theme.ui.bg_m1 },
                    })
                end,
            })

            vim.cmd("colorscheme kanagawa-dragon")
        end

        -- ✅ Now it's safe to call it
        load_kanagawa()

        vim.keymap.set("n", ";b", function()
            is_transparent = not is_transparent
            load_kanagawa()
        end, { desc = "Toggle transparency" })
    end,
}
