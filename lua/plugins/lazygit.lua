return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    keys = {
        { ";lg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- Floating window styling
        vim.g.lazygit_floating_window_winblend = 10
        vim.g.lazygit_floating_window_scaling_factor = 0.9
        vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
        vim.g.lazygit_use_neovim_remote = 1

        -- Remap Ctrl+Enter to Alt+Enter inside the LazyGit terminal
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*lazygit*",
            callback = function()
                -- In terminal mode, Ctrl-CR will now send Alt-CR
                vim.keymap.set("t", "<C-CR>", "<A-CR>", { buffer = true })
            end,
        })
    end,
}
