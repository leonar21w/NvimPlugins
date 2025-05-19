return {
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",                   desc = "Find Buffers" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",                 desc = "Grep Files" },
            { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in Buffer" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",                 desc = "Find Help" },
            { "<leader>e",  "<cmd>Telescope file_browser<cr>",              desc = "File Browser" },
        },
        config = function()
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            local telescope = require("telescope")

            local open_in_split = function(split_cmd)
                return function(prompt_bufnr)
                    local selected = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    vim.cmd(split_cmd)
                    vim.cmd("edit " .. selected.path)
                end
            end

            telescope.setup({
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.8,
                        height = 0.9,
                        prompt_position = "top",
                    },
                    winblend = 10,
                    border = true,
                    mappings = {
                        i = {
                            ["<C-x>"] = open_in_split("split"),
                            ["<C-v>"] = open_in_split("vsplit"),
                            ["<C-d>"] = actions.delete_buffer,
                        },
                    },
                },
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                        grouped = true,
                        hidden = true,
                        select_buffer = true,
                    },
                },
            })

            telescope.load_extension("file_browser")
        end,
    },

    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>",      desc = "Toggle Terminal (float)" },
            { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Terminal (horizontal)" },
            { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Toggle Terminal (vertical)" },
        },
        config = function()
            require("toggleterm").setup({
                size = 15,
                open_mapping = [[<c-/>]],
                hide_numbers = true,
                shading_factor = 2,
                direction = "float",
                float_opts = {
                    border = "curved",
                },
            })
        end,
    },

    -- Window navigation
    {
        "tpope/vim-unimpaired", -- optional, enables [w ]w etc.
        lazy = false,
        config = function()
            vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
            vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
            vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
            vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
        end,
    },
}
