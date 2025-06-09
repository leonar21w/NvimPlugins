-- Split characters (borders between windows)
vim.opt.fillchars:append({
  vert = "│",
  horiz = "─",
  eob = " ",
})

vim.opt.guicursor = {
  "n:block", -- Normal mode: block
  "v:block", -- Visual mode: block
  "i:ver25", -- Insert mode: vertical bar (25% height)
  "a:blinkon0", -- Disable cursor blinking (optional)
}

vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.numberwidth = 3

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.updatetime = 250
vim.opt.showmode = false

require("lualine").setup({
  sections = {
    lualine_c = {
      {
        "filename",
        path = 1, -- relative path
        symbols = {
          modified = "✗", -- Unsaved
          readonly = "🔒",
          unnamed = "[No Name]",
          newfile = "[New]",
        },
        fmt = function(name, context)
          if vim.bo.modified then
            return "" .. name
          else
            return name .. " ✔"
          end
        end,
      },
    },
  },
})
require("lualine").setup({
  options = {
    theme = {
      normal = {
        a = { bg = "#8CCEFF", fg = "#1E1E2E", gui = "bold" }, -- baby blue
        b = { bg = "#2A2C3A", fg = "#8CCEFF" },
        c = { bg = "NONE", fg = "#CDD6F4" },
      },
      insert = {
        a = { bg = "#A6E3A1", fg = "#1E1E2E", gui = "bold" }, -- green
      },
      visual = {
        a = { bg = "#F5C2E7", fg = "#1E1E2E", gui = "bold" }, -- pink
      },
      replace = {
        a = { bg = "#F38BA8", fg = "#1E1E2E", gui = "bold" },
      },
      inactive = {
        a = { bg = "NONE", fg = "#7F849C" },
        b = { bg = "NONE", fg = "#7F849C" },
        c = { bg = "NONE", fg = "#7F849C" },
      },
    },
  },
})
