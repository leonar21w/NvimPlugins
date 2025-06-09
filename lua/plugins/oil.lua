return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Custom winbar to show the current path
      CustomOilBar = function()
        local path = vim.fn.expand("%")
        path = path:gsub("oil://", "")
        return "  " .. vim.fn.fnamemodify(path, ":.")
      end

      -- Track the previous buffer
      local previous_buf = nil
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "oil://*",
        callback = function()
          if previous_buf == nil then
            local alt_buf = vim.fn.bufnr("#")
            if vim.api.nvim_buf_is_valid(alt_buf) and vim.bo[alt_buf].buftype == "" then
              previous_buf = alt_buf
            end
          end
        end,
      })

      -- Flag to debounce q key
      local oil_closing = false

      require("oil").setup({
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
          ["<C-k>"] = false,
          ["<C-j>"] = false,
          ["<M-h>"] = "actions.select_split",

          -- Smart q with debounce
          ["q"] = function()
            if oil_closing then
              return
            end
            oil_closing = true

            local win_config = vim.api.nvim_win_get_config(0)
            local is_float = win_config.relative ~= ""

            if is_float then
              vim.cmd("close")
            elseif previous_buf and vim.api.nvim_buf_is_valid(previous_buf) then
              vim.api.nvim_set_current_buf(previous_buf)
              previous_buf = nil
            else
              require("oil.actions").close.callback()
            end

            vim.defer_fn(function()
              oil_closing = false
            end, 150)
          end,
        },
        win_options = {
          winbar = "%{v:lua.CustomOilBar()}",
        },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
            return vim.tbl_contains(folder_skip, name)
          end,
        },
      })

      -- Keymaps for launching Oil
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<space>-", require("oil").toggle_float)
    end,
  },
}
