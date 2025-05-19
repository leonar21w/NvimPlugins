return {
	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Autocompletion plugin
			"hrsh7th/nvim-cmp",
			-- LSP source for nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Setup nvim-cmp.
			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}),
			})

			-- Setup LSP servers.
			local lspconfig = require("lspconfig")
			local capabilities = cmp_lsp.default_capabilities()

			-- Common on_attach function for LSP servers.
			local on_attach = function(_, bufnr)
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

			-- Configure LSP servers.
			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.vtsls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	},
}
