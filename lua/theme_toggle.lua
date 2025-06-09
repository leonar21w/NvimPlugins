local M = {}

local is_transparent = false
local current_theme = "kanagawa"

local function transparent_overrides()
  return {
    Normal = { bg = "none" },
    Cursor = {
      bg = "#FF9E64", -- soft orange
      fg = "#000000",
      blend = 20,
    },
    NormalNC = { bg = "none" },
    SignColumn = { bg = "none" },
    LineNr = { bg = "none" },
    CursorLineNr = { bg = "none" },
    FoldColumn = { bg = "none" },
    VertSplit = { bg = "none" },
    Pmenu = { bg = "none" },
    PmenuSel = { bg = "#2A2A37" },
    PmenuSbar = { bg = "none" },
    PmenuThumb = { bg = "#2A2A37" },
    FloatBorder = { bg = "none" },
    NormalFloat = { bg = "none" },
    FloatTitle = { bg = "none" },
    TelescopeNormal = { bg = "none" },
    TelescopeBorder = { bg = "none" },
    TelescopePromptNormal = { bg = "none" },
    TelescopePromptBorder = { bg = "none" },
    TelescopeResultsNormal = { bg = "none" },
    TelescopePreviewNormal = { bg = "none" },
    StatusLine = { bg = "none" },
    StatusLineNC = { bg = "none" },
    OilNormal = { bg = "none" },
    OilBorder = { bg = "none" },
  }
end

local function load_kanagawa()
  current_theme = "kanagawa"
  require("kanagawa").setup({
    transparent = is_transparent,
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    overrides = function()
      return is_transparent and transparent_overrides() or {}
    end,
  })
  vim.cmd("colorscheme kanagawa-dragon")
end

local function load_vscode()
  current_theme = "vscode"
  vim.g.vscode_style = "dark"
  vim.g.vscode_transparency = is_transparent
  vim.cmd("colorscheme vscode")

  if is_transparent then
    for hl, val in pairs(transparent_overrides()) do
      vim.api.nvim_set_hl(0, hl, val)
    end
  end
end

local function load_rosepine()
  current_theme = "rose-pine"
  require("rose-pine").setup({
    disable_background = is_transparent,
    disable_float_background = is_transparent,
    highlight_groups = is_transparent and transparent_overrides() or {},
  })
  vim.cmd("colorscheme rose-pine-main")
end

local function apply_theme(theme)
  vim.o.termguicolors = true
  vim.o.background = "dark"
  if theme == "kanagawa" then
    load_kanagawa()
  elseif theme == "vscode" then
    load_vscode()
  elseif theme == "rose-pine" then
    load_rosepine()
  end
end

function M.setup()
  apply_theme(current_theme)

  vim.keymap.set("n", ";b", function()
    is_transparent = not is_transparent
    apply_theme(current_theme)
  end, { desc = "Toggle transparency" })

  vim.keymap.set("n", ";1", function()
    apply_theme("kanagawa")
  end, { desc = "Kanagawa" })

  vim.keymap.set("n", ";2", function()
    apply_theme("vscode")
  end, { desc = "VSCode" })

  vim.keymap.set("n", ";3", function()
    apply_theme("rose-pine")
  end, { desc = "Rose Pine" })
end

return M
