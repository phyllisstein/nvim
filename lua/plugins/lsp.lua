-- NOTE: mason v2 lives under the `mason-org` org. The old
-- `williamboman/*` paths redirect but the v2 options below
-- (notably `automatic_enable`) only exist on v2.

return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = { border = "rounded" },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      -- ensure_installed = { "rust_analyzer", "ts_ls", "pylsp", "eslint", "cypher_ls", "stylelint_lsp" },
      -- `automatic_installation` was REMOVED in mason-lspconfig v2 and is
      -- silently ignored. `automatic_enable` is the real kill-switch, and it
      -- DEFAULTS TO TRUE -- i.e. without this line mason will auto-enable
      -- every server it finds installed, which is the overeager behaviour
      -- we're trying to avoid.
      automatic_enable = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-org/mason-lspconfig.nvim" },
    config = function()
      -- nvim-lspconfig no longer exposes a setup framework. It ships default
      -- server configs as files on the runtimepath; `vim.lsp.enable` turns
      -- them on. Per-server overrides go in `after/lsp/<server>.lua`.
      vim.lsp.enable({ "rust_analyzer", "ts_ls", "pylsp", "eslint", "cypher_ls", "stylelint_lsp" })

      -- Strip formatting from ts_ls so eslint is the sole JS/TS formatter.
      --
      -- This deliberately does NOT live in `after/lsp/ts_ls.lua`: those files
      -- are DEEP-MERGED with lspconfig's defaults, and a deep merge REPLACES
      -- functions rather than composing them. Defining `on_attach` there
      -- would silently clobber whatever lspconfig sets. An LspAttach autocmd
      -- filtered by client name composes cleanly instead.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "ts_ls" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "LspEslintFixAll",
            })
          end
        end,
      })
    end,
  },
}
