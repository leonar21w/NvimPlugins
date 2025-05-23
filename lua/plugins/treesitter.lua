return {
    "nvim-treesitter/nvim-treesitter",
    build  = ":TSUpdate",
    lazy   = false,
    opts   = {
        ensure_installed = {
            "swift", "c", "cpp",
            "go", "javascript", "typescript", "python",
            "html", "css", "json", "lua",
        },
        highlight        = { enable = true, additional_vim_regex_highlighting = false },
        indent           = { enable = true },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
        vim.opt.termguicolors = false
    end,
}
