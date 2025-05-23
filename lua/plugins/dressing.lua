return {
    {
        "stevearc/dressing.nvim",
        lazy = false,
        init = function()
            vim.ui.select = function(...) require("dressing").select(...) end
            vim.ui.input  = function(...) require("dressing").input(...) end
        end,
        config = function()
            require("dressing").setup({})
            vim.keymap.set("n", "<leader>cs", function()
                -- 1) grab every colorscheme under runtimepath/colors/*.vim
                local raw = vim.fn.globpath(vim.o.rtp, "colors/*.vim", true, true)
                -- globpath() returns a list when the last arg is true,
                -- or a string when it’s false—so handle both:
                local paths = type(raw) == "table" and raw or vim.split(raw, "\n")

                local schemes = {}
                for _, f in ipairs(paths) do
                    table.insert(schemes, vim.fn.fnamemodify(f, ":t:r"))
                end

                -- 2) grab your Noirbuddy presets
                local preset_raw = vim.fn.globpath(
                    vim.fn.stdpath("data") .. "/lazy/*/lua/noirbuddy/presets",
                    "*.lua",
                    false,
                    true
                )
                local preset_paths = type(preset_raw) == "table"
                    and preset_raw
                    or vim.split(preset_raw, "\n")

                local presets = {}
                for _, f in ipairs(preset_paths) do
                    table.insert(presets, vim.fn.fnamemodify(f, ":t:r"))
                end

                -- 3) merge into items
                local items = {}
                for _, s in ipairs(schemes) do table.insert(items, { name = s, type = "scheme" }) end
                for _, p in ipairs(presets) do table.insert(items, { name = p, type = "preset" }) end

                -- 4) fire off your existing ui.select exactly as before
                vim.ui.select(items, {
                    prompt      = "Pick scheme or preset:",
                    format_item = function(item)
                        return item.name .. (item.type == "preset" and " [noir preset]" or "")
                    end,
                }, function(choice)
                    if not choice then return end
                    vim.cmd("highlight clear")
                    vim.cmd("syntax reset")
                    vim.o.termguicolors = true
                    vim.o.background    = "dark"

                    if choice.type == "scheme" then
                        vim.cmd("colorscheme " .. choice.name)
                    else
                        require("noirbuddy").setup({ preset = choice.name })
                    end

                    -- your transparency tweaks…
                    local hl = vim.api.nvim_set_hl
                    for _, group in ipairs({
                        "Normal", "NormalNC", "FoldColumn", "EndOfBuffer",
                        "CursorLineNr", "SignColumn",
                        "DiagnosticSignError", "DiagnosticSignWarn",
                        "DiagnosticSignInfo", "DiagnosticSignHint",
                    }) do
                        hl(0, group, { bg = "none" })
                    end
                    local fg = "#c0caf5"
                    hl(0, "LineNr", { fg = fg, bg = "none" })
                    hl(0, "CursorLineNr", { fg = fg, bg = "none" })
                end)
            end, { desc = "󰘫 Pick colorscheme or Noirbuddy preset" })
        end,
    },
}
