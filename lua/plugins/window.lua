return {
  "yorickpeterse/nvim-window",
  keys = {
    {
      ";w",
      function()
        require("nvim-window").pick()
      end,
      desc = "Jump to window",
    },
    { ";wh", ":split<CR>", desc = "Horizontal Split" },
    { ";wv", ":vsplit<CR>", desc = "Vertical Split" },
    { ";wn", ":enew<CR>", desc = "New Buffer" },
    { ";ww", ":bn<CR>", desc = "Next Buffer" },
    { ";ws", ":bp<CR>", desc = "Previous Buffer" },
  },
}
