return {
    "yorickpeterse/nvim-window",
    keys = {
        { ";w", "<cmd>lua require('nvim-window').pick()<CR>", desc = "Jump to window" }
    },
    config = true,
}
