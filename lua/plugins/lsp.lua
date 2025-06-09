return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason").setup()
          require("mason-lspconfig").setup({
            ensure_installed = {
              "gopls",
              "ts_ls",
              "lua_ls",
              "tailwindcss", -- added Tailwind LSP
            },
          })
        end,
      },
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local capabilities = cmp_nvim_lsp.default_capabilities()
      local on_attach = function(client, bufnr)
        local bufmap = function(mode, lhs, rhs)
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { silent = true, noremap = true })
        end
        bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
        bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
      end

      -- Go
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- TypeScript/JavaScript
      lspconfig.tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayVariableTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
            suggest = {
              completeFunctionCalls = true,
            },
            updateImportsOnFileMove = {
              enable = "always",
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayVariableTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
            suggest = {
              completeFunctionCalls = true,
            },
            updateImportsOnFileMove = {
              enable = "always",
            },
          },
        },
      })

      -- ESLint
      lspconfig.eslint.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Lua (Neovim config)
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          },
        },
      })

      -- Tailwind CSS LSP
      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "vue",
        },
        init_options = {
          userLanguages = {
            eelixir = "html-eex", -- example mapping if you use .eex files
          },
        },
      })
    end,
  },
}
