return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      -- `lsp_fallback` is the deprecated spelling; conform wants `lsp_format`
      -- in both places now. The original config was also self-contradictory:
      -- the ft entry asked for the LSP first while format_on_save forbade the
      -- LSP entirely, so JS/TS was never formatted at all.
      formatters_by_ft = {
        javascript      = { lsp_format = "prefer" },
        javascriptreact = { lsp_format = "prefer" },
        typescript      = { lsp_format = "prefer" },
        typescriptreact = { lsp_format = "prefer" },
        rust            = { "rustfmt" },
        python          = { "ruff_format" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "prefer",
      },
    },
  },
}
