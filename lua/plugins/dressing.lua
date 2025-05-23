return {
    {
        "stevearc/dressing.nvim",
        lazy = false,
        init = function()
            vim.ui.select = function(...) require("dressing").select(...) end
            vim.ui.input  = function(...) require("dressing").input(...) end
        end,
        config = function()
            require("dressing").setup({
                input = {
                    enabled        = true,
                    default_prompt = "Input:",
                    prompt_align   = "left",
                    insert_only    = false,
                    border         = "rounded",
                    relative       = "cursor",
                    prefer_width   = 40,
                    win_options    = { winblend = 10 },
                },
                select = {
                    enabled   = true,
                    backend   = { "telescope", "fzf_lua", "fzf", "builtin" },
                    builtin   = { anchor = "NW", border = "rounded", win_options = { winblend = 10 } },
                    telescope = require("telescope.themes").get_dropdown({ winblend = 10, previewer = false }),
                },
            })

            -- build list of all colorschemes + noirbuddy presets
            local schemes      = vim.fn.getcompletion("", "color")
            local data_path    = vim.fn.stdpath("data")
            local preset_glob  = data_path .. "/lazy/*/lua/noirbuddy/presets"
            local preset_paths = vim.fn.globpath(preset_glob, "*.lua", false, true)
            local presets      = {}
            for _, f in ipairs(preset_paths) do
                table.insert(presets, vim.fn.fnamemodify(f, ":t:r"))
            end

            local items = {}
            for _, s in ipairs(schemes) do table.insert(items, { name = s, type = "scheme" }) end
            for _, p in ipairs(presets) do table.insert(items, { name = p, type = "preset" }) end

            -- unified picker
            vim.keymap.set("n", "<leader>cs", function()
                vim.ui.select(items, {
                    prompt      = "Pick scheme or preset:",
                    format_item = function(item)
                        return item.name .. (item.type == "preset" and " [noir preset]" or "")
                    end,
                }, function(choice)
                    if not choice then return end

                    -- reset then load
                    vim.cmd("highlight clear")
                    vim.cmd("syntax reset")
                    vim.o.termguicolors = true
                    vim.o.background    = "dark"

                    if choice.type == "scheme" then
                        vim.cmd("colorscheme " .. choice.name)
                    else
                        require("noirbuddy").setup({ preset = choice.name })
                    end

                    -- ─── transparency tweaks ─────────────────────────────────────────────
                    local hl = vim.api.nvim_set_hl
                    for _, group in ipairs({
                        "Normal", "NormalNC", "FoldColumn", "EndOfBuffer",
                        "CursorLineNr", -- keep your line-number highlight bg-free
                        "SignColumn",   -- sign-column itself
                        "DiagnosticSignError",
                        "DiagnosticSignWarn",
                        "DiagnosticSignInfo",
                        "DiagnosticSignHint",
                    }) do
                        hl(0, group, { bg = "none" })
                    end
                    -- re-apply your preferred LineNr color
                    local fg = "#c0caf5"
                    hl(0, "LineNr", { fg = fg, bg = "none" })
                    hl(0, "CursorLineNr", { fg = fg, bg = "none" })
                    -- ──────────────────────────────────────────────────────────────────────
                end)
            end, { desc = "󰘫 Pick colorscheme or Noirbuddy preset" })
        end,
    },
}
