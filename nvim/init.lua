vim.cmd([[set termguicolors]])
require("config.lazy")

---------- TABS ----------
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character

---------- TRANSPARENCY ----------
-- vim.cmd([[
-- augroup TransparentBackground
-- autocmd!
-- autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
-- autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
-- augroup END
-- ]])

---------- PERSISTENT UNDO ----------
vim.o.undofile = true

---------- LINE NUMBER ----------
vim.wo.number = true
vim.opt.signcolumn = 'yes'
-- vim.wo.relativenumber = true


---------- COLORSCHEME ----------
-- vim.cmd([[colorscheme lackluster-dark]])
-- vim.cmd([[colorscheme vague]])
vim.cmd([[colorscheme everforest]])

---------- SETTINGS ----------
vim.cmd([[set cc=80]]) -- vertical line at 80 characters
vim.cmd([[set so=6]]) -- cursor padding

---------- NVIM TREE ----------
vim.keymap.set('n', '<C-t>', require'nvim-tree.api'.tree.open)
vim.keymap.set('n', '<C-b>', require'nvim-tree.api'.tree.toggle)

---------- UNDO TREE ----------
vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

---------- TELESCOPE ----------
require("telescope").setup {
    -- pickers = {
    --     find_files = {
    --         hidden = true,
    --     }
    -- },
  -- extensions = {
  --   repo = {
  --     list = {
  --       fd_opts = {
  --         "--no-ignore-vcs",
  --       },
  --       search_dirs = {
  --         "~/config/nvim",
  --       },
  --     },
  --   },
  -- },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
-- vim.keymap.set('n', '<leader>fp', require'telescope'.extensions.repo.list{})
-- vim.keymap.set('n', '<leader>fp', vim.cmd([[Telescope repo list]]))
-- require'telescope'.load_extension'repo'

---------- LSPCONFIG ----------
require'lspconfig'.pylyzer.setup{}
require'lspconfig'.denols.setup{}

-- require'lspconfig'.jdtls.setup{}
-- local config = {
--     cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
--     root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
-- }
-- require('jdtls').start_or_attach(config)

require'lspconfig'.clangd.setup({
  cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
  init_options = {
    fallbackFlags = { '-std=c++17' },
  },
})

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

---------- TREESITTER ----------
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "java" },
  modules = {},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  -- ignore_install = { "javascript" },
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a functionunction for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- modules = {},
  -- warning est normal
}

---------- NEOCROLL ----------
require('neoscroll').setup({
    mappings = {                 -- Keys to be mapped to their corresponding default scrolling animation
        '<C-u>', '<C-d>',
        -- '<C-b>', '<C-f>',
        -- '<C-y>', '<C-e>',
        -- 'zt', 'zz', 'zb',
    },
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    duration_multiplier = 0.5,   -- Global duration multiplier
    easing = 'linear',           -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
    ignored_events = {           -- Events ignored while scrolling
        'WinScrolled', 'CursorMoved'
    },
})

---------- COLOR PICKER ----------
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-c>", "<cmd>PickColor<cr>", opts)
vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

require("color-picker").setup({ -- for changing icons & mappings
	-- ["icons"] = { "ﱢ", "" },
	-- ["icons"] = { "ﮊ", "" },
	-- ["icons"] = { "", "ﰕ" },
	-- ["icons"] = { "", "" },
	-- ["icons"] = { "", "" },
	["icons"] = { "ﱢ", "" },
	["border"] = "rounded", -- none | single | double | rounded | solid | shadow
	["keymap"] = { -- mapping example:
		["U"] = "<Plug>ColorPickerSlider5Decrease",
		["O"] = "<Plug>ColorPickerSlider5Increase",
	},
	["background_highlight_group"] = "Normal", -- default
	["border_highlight_group"] = "FloatBorder", -- default
  ["text_highlight_group"] = "Normal", --default
})

vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.

---------- TIME TRACKING ----------
require('pendulum').setup({
    log_file = vim.fn.expand("~/.config/nvim/.time_tracking.csv"),
    timeout_len = 300,  -- 5 minutes
    timer_len = 60,     -- 1 minute
    gen_reports = false, -- Enable report generation (requires Go)
    top_n = 25,         -- Include top 25 entries in the report
    report_section_excludes = {
        "branch",       -- Hide `branch` section of the report
        -- Other options includes:
        "directory",
        -- "filetype",
        "file",
        -- "project",
    },
    report_excludes = {
        filetype = {
            -- This table controls what to be excluded from `filetype` section
            -- "neo-tree", -- Exclude neo-tree filetype
        },
        file = {
            -- This table controls what to be excluded from `file` section
            -- "test.py",  -- Exclude any test.py
            -- ".*.go",    -- Exclude all Go files
        },
        project = {
            -- This table controls what to be excluded from `project` section
            -- "unknown_project" -- Exclude unknown (non-git) projects
        },
        directory = {
            -- This table controls what to be excluded from `directory` section
        },
        branch = {
            -- This table controls what to be excluded from `branch` section
        },
    },
})
