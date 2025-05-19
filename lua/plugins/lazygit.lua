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
        -- Optional: Customize LazyGit floating window appearance
        vim.g.lazygit_floating_window_winblend = 10 -- Transparency
        vim.g.lazygit_floating_window_scaling_factor = 0.9 -- Size scaling
        vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } -- Border characters
        vim.g.lazygit_use_neovim_remote = 1 -- Use neovim-remote if available
    end,
}
