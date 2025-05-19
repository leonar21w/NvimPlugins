return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        require("lualine").setup({
            options = {
                theme = "tundra",
                icons_enabled = true,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = {
                    "encoding",
                    "fileformat",
                    "filetype",
                },
                lualine_y = {
                    function()
                        return os.date("%a %b %d · %I:%M %p") -- Ex: Sat Apr 13 · 09:45 AM
                    end,
                },
                lualine_z = {
                    function()
                        local line = vim.fn.line(".")
                        local col = vim.fn.col(".")
                        return string.format("ln %d col %d", line, col)
                    end,
                }
            },
        })

        -- ⏱ Refresh lualine every 60 seconds to update the time
        vim.fn.timer_start(60000, function()
            require("lualine").refresh()
        end, { ["repeat"] = -1 })
    end,
}
