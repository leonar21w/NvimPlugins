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
    vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    vim.g.lazygit_use_neovim_remote = 1
  end,
}
