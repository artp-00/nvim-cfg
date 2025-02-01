return
{
    -------------- LSP PLUGINS -------------- 

    { "williamboman/mason.nvim", opts = {} },
    { "williamboman/mason-lspconfig.nvim", opts = {},
        dependencies = {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        }
    },
    -- LSP servers and clients communicate which features they support through "capabilities".
    --  By default, Neovim supports a subset of the LSP specification.
    --  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
    --  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
    --
    -- This can vary by config, but in general for nvim-lspconfig
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },

        -- example using `opts` for defining servers
        opts = {
            servers = {
                lua_ls = {}
            }
        },
        config = function(_, opts)
            local lspconfig = require('lspconfig')
            for server, config in pairs(opts.servers) do
                -- passing config.capabilities to blink.cmp merges with the capabilities in your
                -- `opts[server].capabilities, if you've defined it
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end
    },

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
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },
        },
        opts_extend = { "sources.default" }
    },

    -------------- NAVIGATION -------------- 

    { "nvim-telescope/telescope.nvim", opts = {} },
    { "karb94/neoscroll.nvim", opts = {} },
    -- { "cljoly/telescope-repo.nvim" },
    { "nvim-tree/nvim-tree.lua", opts = {} },

    -------------- COLORSCHEME -------------- 

    { "nvim-treesitter/nvim-treesitter", opts = {} },
    { "folke/tokyonight.nvim", opts = {} },
    { "sainnhe/everforest" },
    { "gbprod/nord.nvim", opts = {} },
    { "presindent/ethereal.nvim", opts = {} },
    { "vague2k/vague.nvim", opts = {} },
    { "comfysage/aurora", opts = {} },
    { "slugbyte/lackluster.nvim", opts = {} },
    { "sho-87/kanagawa-paper.nvim", opts = {} },
    { "chama-chomo/grail", opts = {} },
    { "backdround/melting", opts = {} },

    -------------- UTILITY -------------- 

    { "kylechui/nvim-surround", opts = {} },
    { "numToStr/Comment.nvim", opts = {} },
    { "ziontee113/color-picker.nvim", opts = {} },
    { "mbbill/undotree" },
    { "m4xshen/autoclose.nvim", opts = {} },

    -------------- VISUALS -------------- 

    { "beauwilliams/statusline.lua" },
    --{ "nvim-lualine/lualine.nvim", opts = {} },
    { "sontungexpt/stcursorword", opts = {} },
    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            draw = { delay = 10, animation = function() return 0 end },
            options = { border = "top", try_as_border = true },
            -- symbol = "▏",
            symbol = '¦',
            -- symbol = '‖',
        },
        config = function(_, opts)
            require("mini.indentscope").setup(opts)

            -- Disable for certain filetypes
            vim.api.nvim_create_autocmd({ "FileType" }, {
                desc = "Disable indentscope for certain filetypes",
                callback = function()
                    local ignore_filetypes = {
                        "aerial",
                        "dashboard",
                        "help",
                        "lazy",
                        "leetcode.nvim",
                        "mason",
                        "neo-tree",
                        "NvimTree",
                        "neogitstatus",
                        "notify",
                        "startify",
                        "toggleterm",
                        "Trouble"
                    }
                    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
                        vim.b.miniindentscope_disable = true
                    end
                end,
            })
        end
    },

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
    --{ "folke/which-key.nvim", opts = {} },
}
