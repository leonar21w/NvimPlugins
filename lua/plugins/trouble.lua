return {
    {
        "folke/trouble.nvim",
        cmd = "Trouble",         -- Lazy-load the plugin when the Trouble command is used
        opts = {
            auto_preview = true, -- Automatically update preview when you move around the diagnostics list
            -- Configure the preview window as a split on the right
            preview = {
                type = "split",     -- Use a split (rather than a floating or main-window preview)
                position = "right", -- Place the split on the far right
                width = 50,         -- Adjust the width as desired
                scratch = false,    -- Use a normal buffer so you can focus it
            },
        },
        keys = {
            -- Toggle the diagnostics view with a single keybind
            { ";d",         "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Diagnostics (Trouble)" },
            -- Optional global key mappings to jump between splits
            { "<leader>fp", "<C-w>l",                              desc = "Focus Preview" },     -- Assume preview is right of diagnostics
            { "<leader>fd", "<C-w>h",                              desc = "Focus Diagnostics" }, -- Jump back to diagnostics on the left
        },
    },
}
