return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal_cmd = "~/.local/bin/claude",
    },
    keys = {
      { "<leader>C",  nil,                              desc = "Claude Code", icon = "✻" },
      { "<leader>Cc", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>Cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>Cr", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume" },
      { "<leader>CC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue" },
      { "<leader>Cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },
      { "<leader>Cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add buffer" },
      { "<leader>Cs", "<cmd>ClaudeCodeSend<cr>",        desc = "Send selection", mode = "v" },
      { "<leader>Ca", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept diff" },
      { "<leader>Cd", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Deny diff" },
      -- Lazy's `ft` filter makes this buffer-local via an autocmd, so it
      -- shadows the global <leader>Cf only inside an explorer buffer.
      { "<leader>Cf", "<cmd>ClaudeCodeTreeAdd<cr>",     desc = "Add file", ft = { "snacks_picker_list", "oil", "netrw" } },
    },
  },
}
