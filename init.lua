-- ~/.config/nvim/init.lua

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Core options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.laststatus = 3
vim.opt.timeoutlen = 300

-- NOTE: `cmdheight = 0` was tried during setup and did not fix the terminal
-- seam; it also interacts badly with some plugins. Left off deliberately.
-- The seam was a background mismatch: monokai-pro's `Normal` bg is #2d2a2e
-- (NOT #221f22, which is the darker secondary/sidebar colour). Set your
-- terminal background to #2d2a2e to make it vanish.

-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.keymaps")
require("config.autocmds")

require("lazy").setup("plugins", {
  defaults = { lazy = false },
})
