return
{
    -------------- AUTOCOMPLETION -------------- 

    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = 'rafamadriz/friendly-snippets',

        -- use a release tag to download pre-built binaries
        version = '*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = { preset = 'super-tab' },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                -- default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                default = { 'path', 'snippets', 'buffer' },
            },
        },
        opts_extend = { "sources.default" }
    },

    -------------- NAVIGATION -------------- 

    { "nvim-telescope/telescope.nvim", opts = {} },
    { "nvim-tree/nvim-tree.lua", opts = {} },

    -------------- COLORSCHEME -------------- 

    { "nvim-treesitter/nvim-treesitter", opts = {} },
    { "sainnhe/everforest" },
    { "gbprod/nord.nvim", opts = {} },
    { "vague2k/vague.nvim", opts = {} },
    { "sho-87/kanagawa-paper.nvim", opts = {} },
    { "chama-chomo/grail", opts = {} },

    -------------- UTILITY -------------- 

    { "kylechui/nvim-surround", opts = {} },
    { "numToStr/Comment.nvim", opts = {} },
    { "mbbill/undotree" },
    { "m4xshen/autoclose.nvim", opts = {} },

    -------------- VISUALS -------------- 

    { "sontungexpt/stcursorword", opts = {} },

    -------------- DASHBOARD -------------- 

    {
        'goolord/alpha-nvim',
        dependencies = {
            'echasnovski/mini.icons',
            'nvim-lua/plenary.nvim'
        },
        config = function ()
            require'alpha'.setup(require'themes.theta_custom'.config)
        end
    },
}
