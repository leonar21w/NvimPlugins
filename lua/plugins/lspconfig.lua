-- in lua/plugins/lspconfig.lua
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lspconfig                          = require("lspconfig")
            local cmp                                = require("cmp")
            local cmp_lsp                            = require("cmp_nvim_lsp")

            vim.highlight.priorities.semantic_tokens = 0
            -- nvim-cmp setup
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                }),
                sources = { { name = "nvim_lsp" } },
            })




            -- common on_attach
            local on_attach = function(client, bufnr)
                local buf_map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end
                buf_map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
                buf_map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
                buf_map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
                buf_map("n", "gr", vim.lsp.buf.references, "Go to References")
                buf_map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
                buf_map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
                buf_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
                buf_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
                buf_map("n", "gl", vim.diagnostic.open_float, "Show Diagnostics")
                buf_map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
                buf_map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
            end

            -- shared capabilities
            local capabilities = cmp_lsp.default_capabilities()


            -- Go
            lspconfig.gopls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- Lua (Neovim)
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = { Lua = { diagnostics = { globals = { "vim" } } } },
            })

            -- TypeScript/JavaScript
            lspconfig.ts_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- HTML, CSS, JSON
            lspconfig.html.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.jsonls.setup({ on_attach = on_attach, capabilities = capabilities })

            -- Swift / Objective-C
            lspconfig.sourcekit.setup({
                cmd = { "xcrun", "sourcekit-lsp" },
                filetypes = { "swift", "objective-c", "objc", "objcpp" },
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                end,
                capabilities = capabilities,
                root_dir = lspconfig.util.root_pattern(
                    "Package.swift", "*.xcworkspace", "*.xcodeproj", ".git"
                ),
                init_options = {
                    ["sourcekit-lsp"] = {
                        completeBuildTargets = true,
                        enableIndexing       = true,
                    },
                },
            })
        end,
    },
}
