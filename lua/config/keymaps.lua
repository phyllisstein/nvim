-- ~/.config/nvim/lua/keymaps.lua

local map = vim.keymap.set

-- ---------------------------------------------------------------------------
-- LSP
-- ---------------------------------------------------------------------------
-- Nvim 0.11+ already ships defaults: K (hover), grn (rename), gra (code
-- action), grr (references), gri (implementation), gO (document symbols).
-- The maps below are additions / VSCode-muscle-memory overrides.

map("n", "gd", vim.lsp.buf.definition,      { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration,     { desc = "Go to declaration" })
map("n", "gi", vim.lsp.buf.implementation,  { desc = "Go to implementation" })
map("n", "gr", vim.lsp.buf.references,      { desc = "Go to references" })
map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "K",  vim.lsp.buf.hover,           { desc = "Hover docs" })

map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- ---------------------------------------------------------------------------
-- Diagnostics
-- ---------------------------------------------------------------------------
-- vim.diagnostic.goto_next / goto_prev are DEPRECATED as of nvim 0.11.
-- vim.diagnostic.jump() is the replacement.

map("n", "]e", function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = "Next diagnostic" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = "Prev diagnostic" })

map("n", "<leader>ev", vim.diagnostic.open_float, { desc = "View diagnostic" })
map("n", "<leader>ea", vim.lsp.buf.code_action,   { desc = "Code action" })

-- ---------------------------------------------------------------------------
-- Windows
-- ---------------------------------------------------------------------------
-- <C-w>h etc. are the vanilla chords; these are just ergonomic shortcuts.

map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- ---------------------------------------------------------------------------
-- Buffers
-- ---------------------------------------------------------------------------
-- Two spellings of the same motion, kept deliberately: <S-h>/<S-l> reclaims
-- vanilla H/L (top/bottom of screen), ]b/[b follows the vim bracket idiom.

map("n", "<S-h>", "<cmd>bprev<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b",    "<cmd>bprev<cr>", { desc = "Prev buffer" })
map("n", "]b",    "<cmd>bnext<cr>", { desc = "Next buffer" })

map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer" })
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
