-- IMPORTANT: this targets nvim-treesitter's `main` branch (the default on
-- nvim 0.12), which is a full, incompatible rewrite. On that branch
-- `ensure_installed`, `highlight = { enable = true }` and
-- `indent = { enable = true }` DO NOT EXIST. Passing them does nothing --
-- which is why `:TSUpdate` reports "all parsers are up to date" while no
-- parser has ever been requested, and why highlighting never starts.
--
-- The real API is `.setup{}` for install location and `.install{}` for
-- parsers. Highlighting is started per-buffer via `vim.treesitter.start()`.
-- The autocmd below is the CORRECT mechanism, not a workaround.
--
-- The plugin does not support lazy-loading.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})

      require("nvim-treesitter").install({
        "css",
        "javascript",
        "json",
        "lua",
        "markdown_inline",
        "markdown",
        "python",
        "rust",
        "scss",
        "styled",
        "tsx",
        "typescript",
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          -- pcall so filetypes without a parser fail silently
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
}
