-- lua/plugins/noirbuddy.lua
return {
    -- 1) color engine
    {
        "tjdevries/colorbuddy.nvim",
        lazy = true, -- it'll be loaded by noirbuddy automatically
    },

    -- 2) the theme framework
    {
        "jesseleite/nvim-noirbuddy",
        dependencies = { "tjdevries/colorbuddy.nvim" },
        lazy         = false, -- load on startup
        priority     = 1000,  -- before everything else
        opts         = {
            -- pick one of the bundled presets, or leave blank for 'minimal'
            preset = "minimal",

            -- (OPTIONAL) override colors:
            -- colors = { primary = "#FF0055", secondary = "#0055FF" },

            -- (OPTIONAL) enable font styles:
            -- styles = { italic = true, bold = false, underline = false },

            -- (OPTIONAL) plugin integrations:
            -- plugins = { mini = true, lualine = true, telescope = true },
        },
        config       = function(_, opts)
            -- ensure true-color support
            vim.o.termguicolors = true
            vim.o.background    = "dark"
            require("noirbuddy").setup(opts)

            -- clear any lingering backgrounds
            local hl = vim.api.nvim_set_hl
            for _, group in ipairs({
                "Normal", "NormalNC", "SignColumn", "FoldColumn", "EndOfBuffer",
                "CursorLine", "CursorColumn", "Pmenu", "PmenuSel"
            }) do
                hl(0, group, { bg = "none" })
            end

            -- unify gutter numbers to a soft but bright gray
            hl(0, "LineNr", { fg = "#c0caf5", bg = "none" })
            hl(0, "CursorLineNr", { fg = "#c0caf5", bg = "none" })
        end,
    },

    -- 3) full transparency (including Oil.nvim)
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = function()
            require("transparent").setup({
                groups = {
                    "Normal", "NormalNC", "SignColumn", "FoldColumn", "EndOfBuffer",
                    "CursorLine", "CursorLineNr", "LineNr", "NonText", "VertSplit",
                    "StatusLine", "StatusLineNC", "TabLine", "TabLineSel",
                    "TabLineFill", "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
                    "NormalFloat", "FloatBorder", "Folded", "Visual", "VisualNOS",
                    "Search", "IncSearch", "WildMenu", "CursorColumn",
                },
                extra_groups = {
                    "OilNormal", "OilNormalNC", "OilDir", "OilFile",
                    "OilCursorLine", "OilCursorColumn", "OilHeader",
                },
                exclude_groups = {},
            })
        end,
    },
}
