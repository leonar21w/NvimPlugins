return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "goimports", "gofmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                swift = { "swift-format" }
            },
            format_on_save = function(bufnr)
                -- Disable autoformat for certain filetypes or conditions if needed
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return {
                    timeout_ms = 1000,
                    lsp_fallback = true,
                }
            end,
        })

        -- Manual format keybinding
        vim.keymap.set({ "n", "v" }, ";f", function()
            conform.format({ async = true, lsp_fallback = true })
        end, { desc = "Format buffer" })
    end,
}
