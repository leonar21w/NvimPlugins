return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    dependencies = {
        -- ensure transparent.nvim is loaded first so `vim.g.transparent_enabled` is set
        "xiyaowong/transparent.nvim",
    },
    opts = {
        compile        = false, -- enable compiling the colorscheme
        undercurl      = true,  -- enable undercurls
        commentStyle   = { italic = true },
        functionStyle  = {},
        keywordStyle   = { italic = true },
        statementStyle = { bold = true },
        typeStyle      = {},
        transparent    = vim.g.transparent_enabled,
        dimInactive    = false, -- dim inactive windows
    },
    config = function(_, opts)
        require("kanagawa").setup(opts)
        vim.cmd("colorscheme kanagawa")
    end,
}
