return {
    { "nvim-telescope/telescope.nvim", opts = {} },
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp' },
    {'hrsh7th/nvim-cmp', opts={} },

    { "nvim-treesitter/nvim-treesitter", opts = {} },
    { "williamboman/mason-lspconfig.nvim", opts = {} },
    { "williamboman/mason.nvim", opts = {} },
    {"m4xshen/autoclose.nvim", opts={} },
    { "nvim-tree/nvim-tree.lua", opts = {} },
    {
        "sainnhe/everforest",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 100, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme everforest]])
        end,
    },
    { "gbprod/nord.nvim", opts = {} },
    { "presindent/ethereal.nvim", opts = {} },
    { "ellisonleao/gruvbox.nvim", opts = {} },
    { "comfysage/aurora", opts = {} },
    { "sho-87/kanagawa-paper.nvim", opts = {} },
    { "xero/miasma.nvim" },
    -- { "bakageddy/alduin.nvim", opts = {} },
    { "chama-chomo/grail", opts = {} },
    { "backdround/melting", opts = {} },
    { "nvim-lualine/lualine.nvim", opts = {} },
    -- { "michaeljsmith/vim-indent-object" },
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
    { "sontungexpt/stcursorword", opts = {} },
    { "karb94/neoscroll.nvim", opts = {} },
    { "numToStr/Comment.nvim", opts = {} },
    --{ "norcalli/nvim-colorizer.lua", opts = {} },

    { "mfussenegger/nvim-jdtls" },
    { "kylechui/nvim-surround", opts = {} },
    {
        'Chaitanyabsprip/fastaction.nvim',
        ---@type FastActionConfig
        opts = {},
    },
    -- { "monkoose/parsley" },
    -- { "monkoose/nvlime" },
    {
        'goolord/alpha-nvim',
        --config = function ()
        --    require'alpha'.setup(require'alpha.themes.dashboard'.config)
        --end
    },

    --{ "tjdevries/express_line.nvim", opts = {} },
}
