return {
    {"kvrohit/mellow.nvim"}, {"nyoom-engineering/oxocarbon.nvim"}, {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            integrations = {
                alpha = true,
                aerial = true,
                dap = true,
                dap_ui = true,
                mason = true,
                neotree = true,
                notify = true,
                nvimtree = false,
                semantic_tokens = true,
                symbols_outline = true,
                telescope = true,
                ts_rainbow = false,
                which_key = true
            },
            color_overrides = {
                mocha = {
                    base = "#000000",
                    mantle = "#000000",
                    crust = "#000000"
                }
            }
        }
    }, {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            }
        }
    }
}
