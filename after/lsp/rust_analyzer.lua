-- Deep-merged with nvim-lspconfig's bundled lsp/rust_analyzer.lua.
-- Only the keys named here are overridden; everything else is inherited.
--
-- These files are PURELY DECLARATIVE -- they return a table and nothing
-- else. `vim.lsp.enable()` (in lua/plugins/lsp.lua) is what actually turns
-- the server on. Blueprint vs. switch.
--
-- Do NOT define on_attach / before_init here: a deep merge REPLACES
-- functions rather than composing them, so you'd silently clobber the ones
-- lspconfig sets. Use an LspAttach autocmd filtered by client name instead.

return {
  settings = {
    ["rust-analyzer"] = {
      check = { command = "check" },
    },
  },
}
