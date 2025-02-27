vim.cmd([[set termguicolors]])
require("config.lazy")

-- indent
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.shiftwidth = 4
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.wo.number = true

-- block cursos
-- marche pas bien
vim.cmd([[set guicursor=n-v-c-i:block]])

-- persistent undo
vim.o.undofile = true

-- line numbers
vim.opt.signcolumn = 'yes'
vim.wo.relativenumber = true

-- colorscheme
vim.cmd([[colorscheme alduin]])

-- vertical line at 80
vim.cmd([[set cc=80]])

-- scroll offset (how close the cursor is to the edge of the screen)
vim.cmd([[set scrolloff=80]])

-- nvim tree bindings
vim.keymap.set('n', '<C-t>', require'nvim-tree.api'.tree.open)
vim.keymap.set('n', '<C-b>', require'nvim-tree.api'.tree.toggle)

---------------- Telescope ---------------- 
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require('telescope').setup {
    defaults = {
        preview = {
            treesitter = false
        },
        file_ignore_patterns = {"build"}
    },
}

require('mason-lspconfig').setup({
    automatic_installation = false,
    ensure_installed = {
        'pyright',
        -- 'hls',
        'lua_ls',
        'cmake',
    }
})

---------------- LSPs ---------------- 
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    end,
})
-- alt enter for quickfix
vim.keymap.set('n', '<A-CR>', require("fastaction").code_action, opts)

-- An example for configuring `clangd` LSP to use nvim-cmp as a completion engine
require('lspconfig').clangd.setup {
}
require('lspconfig').pyright.setup {
}
require('lspconfig').cmake.setup {
    { "cmake", "txt" }
}

-- require('lua-language-server').lua_ls.setup {
-- }

---------------- autocompletion ---------------- 
local cmp = require'cmp'
cmp.setup {
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvlime' },
        { name = 'path' },
        { name = 'buffer' }
    },
    window = {
        completion = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<TAB>'] = cmp.mapping.confirm({ select = true }),
    })
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()


---------------- treesitter ---------------- 
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "javascript", "cpp", "python", "rust", "cmake", "typescript" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    -- ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = false,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = { "c", "cmake", "cpp" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        -- disable = function(lang, buf)
        --     local max_filesize = 100 * 1024 -- 100 KB
        --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --     if ok and stats and stats.size > max_filesize then
        --         return true
        --     end
        -- end,

        -- SettiuFLrxPNng this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
    },
}


-- No need to copy this inside `setup()`. Will be used automatically.
-- require 'mini.indentscope'.setup(
-- {
--         -- Draw options
--         draw = {
--             -- Delay (in ms) between event and start of drawing scope indicator
--             delay = 10,
--
--             -- Animation rule for scope's first drawing. A function which, given
--             -- next and total step numbers, returns wait time (in ms). See
--             -- |MiniIndentscope.gen_animation| for builtin options. To disable
--             -- animation, use `require('mini.indentscope').gen_animation.none()`.
--             -- animation = --<function: implements constant 20ms between steps>,
--             animation = function() return 0 end,
--
--             -- Whether to auto draw scope: return `true` to draw, `false` otherwise.
--             -- Default draws only fully computed scope (see `options.n_lines`).
--             -- predicate = function(scope) return not scope.body.is_incomplete end,
--
--             -- Symbol priority. Increase to display on top of more symbols.
--             priority = 2,
--
--         -- Module mappings. Use `''` (empty string) to disable one.
--         mappings = {
--             -- Textobjects
--             object_scope = 'ii',
--             object_scope_with_border = 'ai',
--
--             -- Motions (jump to respective border line; if not present - body line)
--             goto_top = '[i',
--             goto_bottom = ']i',
--         },
--
--         -- Options which control scope computation
--         options = {
--             -- Type of scope's border: which line(s) with smaller indent to
--             -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
--             border = 'both',
--
--             -- Whether to use cursor column when computing reference indent.
--             -- Useful to see incremental scopes with horizontal cursor movements.
--             indent_at_cursor = true,
--
--             -- Maximum number of lines above or below within which scope is computed
--             n_lines = 10000,
--
--             -- Whether to first check input line to be a border of adjacent scope.
--             -- Use it if you want to place cursor on function header to get scope of
--             -- its body.
--             try_as_border = false,
--         },
--
--         -- Which character to use for drawing scope indicator
--         symbol = '╎',
--         }
-- })

--local lspconfig = require('lspconfig')
--lspconfig.clangd.setup {
--  -- Server-specific settings. See `:help lspconfig-setup`
--  settings = {
--    ['clangd'] = {},
--  },
--}

---------------- Dashboard ---------------- 
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
        [[                                                                   ]],
        [[                                                                   ]],
        [[                                                                   ]],
        [[                                                                   ]],
        [[                                                                   ]],
        [[                                                                   ]],
        [[                                                                   ]],
    [[ ███▄▄▄▄      ▄████████  ▄██████▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄   ]],
    [[ ███▀▀▀██▄   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄ ]],
    [[ ███   ███   ███    █▀  ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
    [[ ███   ███  ▄███▄▄▄     ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
    [[ ███   ███ ▀▀███▀▀▀     ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
    [[ ███   ███   ███    █▄  ███    ███ ███    ███ ███  ███   ███   ███ ]],
    [[ ███   ███   ███    ███ ███    ███  ██▄  ▄██  ███  ███   ███   ███ ]],
    [[  ▀█   █▀    ██████████  ▀██████▀   ▀██████▀  █▀    ▀█   ███   █▀  ]],
    [[                                                                   ]],
-- [[                __                                       ]], 
-- [[              .'  '.                                     ]],
-- [[             :      :                                    ]],
-- [[             | _  _ |                                    ]],
-- [[          .-.|(o)(o)|.-.        _._          _._         ]],
-- [[         ( ( | .--. | ) )     .',_ '.      .' _,'.       ]],
-- [[          '-/ (    ) \-'     / /' `\ \ __ / /' `\ \      ]],
-- [[           /   '--'   \     / /     \.'  './     \ \     ]],
-- [[           \ `"===="` /     `-`     : _  _ :      `-`    ]],
-- [[            `\      /'              |(o)(o)|             ]],
-- [[              `\  /'                |      |             ]],
-- [[              /`-.-`\_             /        \            ]],
-- [[        _..:;\._/V\_./:;.._       /   .--.   \           ]],
-- [[      .'/;:;:;\ /^\ /:;:;:\'.     |  (    )  |           ]],
-- [[     / /;:;:;:;\| |/:;:;:;:\ \    _\  '--'  /__          ]],
-- [[    / /;:;:;:;:;\_/:;:;:;:;:\ \ .'  '-.__.-'   `-.       ]],
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "󰈞  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
    dashboard.button( "1", "  > 42sh", ":cd ~/afs/ing/proj/42sh/epita-ing-assistants-acu-42sh-2027-paris-87 | Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "q", "󰿅  > Quit NVIM", ":qa<CR>"),
}

-- Set footer
--   NOTE: This is currently a feature in my fork of alpha-nvim (opened PR #21, will update snippet if added to main)
--   To see test this yourself, add the function as a dependecy in packer and uncomment the footer lines
--   ```init.lua
--   return require('packer').startup(function()
--       use 'wbthomason/packer.nvim'
--       use {
--           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
--           requires = {'BlakeJC94/alpha-nvim-fortune'},
--           config = function() require("config.alpha") end
--       }
--   end)
--   ```
-- local fortune = require("alpha.fortune") 
-- dashboard.section.footer.val = fortune()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
