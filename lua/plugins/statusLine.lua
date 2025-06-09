return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "arkav/lualine-lsp-progress" },
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto", -- lets your current colorscheme handle styling
        icons_enabled = true,
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filename",
            path = 1, -- show relative path
            symbols = {
              modified = " ●", -- Not saved
              readonly = " 🔒", -- Readonly file
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },
        lualine_x = {
          {
            "filetype",
            icon_only = false,
          },
          {
            function()
              return os.date("%a %b %d · %I:%M %p")
            end,
            separator = "",
          },
        },
        lualine_y = { "lsp_progress" },
        lualine_z = { "location", "diagnostics" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree", "quickfix", "toggleterm", "fugitive" },
    })

    -- ⏱ Optional: Refresh every 60s to update time
    vim.fn.timer_start(60000, function()
      require("lualine").refresh()
    end, { ["repeat"] = -1 })
  end,
}
