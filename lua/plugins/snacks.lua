return {
  {
    "folke/snacks.nvim",
    dependencies = { "loctvl842/monokai-pro.nvim" },
    priority = 1000,
    lazy = false,
    opts = {
      explorer = { enabled = true },

      -- The explorer is BUILT ON the picker. Disabling picker while enabling
      -- explorer is contradictory and is the likely cause of the highlight
      -- mess (every group inspected came back as SnacksPicker*). Leave on.
      picker = { enabled = true },

      -- Everything else off unless explicitly wanted.
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      gitbrowse = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      lazygit = { enabled = false },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = false },
    },
    keys = {
      -- Moved off <leader>e: that key is now the diagnostics group. Leaving
      -- both <leader>e (explorer) and <leader>ev/<leader>ea (diagnostics)
      -- mapped means every diagnostic keystroke waits out `timeoutlen`.
      { "<leader>E", function() Snacks.explorer() end, desc = "File explorer" },
    },
  },
}
