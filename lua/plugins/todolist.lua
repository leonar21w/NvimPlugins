return {
  {
    "vimichael/floatingtodo.nvim",
    lazy = false,
    config = function()
      local todo_path = vim.fn.expand("~\\AppData\\Local\\nvim-data\\todo.md")

      -- Ensure the todo file exists
      if vim.fn.filereadable(todo_path) == 0 then
        vim.fn.mkdir(vim.fn.fnamemodify(todo_path, ":h"), "p")
        vim.fn.writefile({ "☐ Sample task" }, todo_path)
      end

      require("floatingtodo").setup({
        target_file = todo_path,
        border = "rounded",
        width = 0.5,
        height = 0.4,
        position = "center",
      })
    end,
    keys = {
      { "<leader>td", "<cmd>Td<cr>", desc = "Open Floating TODO" },
    },
  },
}
