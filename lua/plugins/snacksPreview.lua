return {
  -- Snacks.nvim: minimal setup
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      image = { enabled = true },
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      words = { enabled = true },
      statuscolumn = { enabled = true },
    },
  },
}
