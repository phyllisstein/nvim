return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        dependencies = { "nvim-treesitter/nvim-treesitter", "loctvl842/monokai-pro.nvim" },
        opts = {
            scope = {
                enabled = true,
                show_end = true,
                show_start = true,
            }
        }
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            require("rainbow-delimiters.setup").setup {
                strategies = {
                    [''] = 'rainbow-delimiters.strategy.local',
                    clojure = 'rainbow-delimiters.strategy.local'
                },
                whitelist = { 'clojure' }
            }
        end
    }
}
