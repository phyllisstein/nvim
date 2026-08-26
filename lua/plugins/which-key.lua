return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
      icons = {
        -- No icon column: PragmataPro's glyph set is yours to control.
        mappings = false,
      },
      spec = {
        { "<leader>e", group = "diagnostic" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>b", group = "buffer" },
        { "<leader>C", group = "claude" },
      },
    },
  },
}
