return {
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "none",
        ["<Tab>"]     = { "accept", "fallback" },
        ["<S-Tab>"]   = { "select_prev", "fallback" },
        ["<C-n>"]     = { "select_next", "fallback" },
        ["<C-p>"]     = { "select_prev", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"]     = { "hide" },
        -- <CR> left entirely to nvim-autopairs.
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "buffer" },
      },
      completion = {
        -- <Tab> maps to `accept`, which needs something SELECTED to accept.
        -- Preselecting the first item means Tab works without pressing <C-n>
        -- first. Set to false if you'd rather Tab insert a literal tab until
        -- you explicitly pick a candidate.
        list = { selection = { preselect = true, auto_insert = false } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
    },
  },
}
