vim.cmd([[set termguicolors]])
require("config.lazy")

---------- TABS ----------
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character

---------- PERSISTENT UNDO ----------
vim.o.undofile = true

---------- LINE NUMBER ----------
vim.wo.number = true
vim.opt.signcolumn = 'yes'
-- vim.wo.relativenumber = true


---------- COLORSCHEME ----------
-- vim.cmd([[colorscheme vague]])
-- vim.cmd([[colorscheme grail]])
-- vim.cmd([[colorscheme nord]])
-- vim.cmd([[colorscheme everforest]])
vim.cmd([[colorscheme kanagawa-paper]])

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
    pickers = {
        find_files = {
            hidden = true,
        }
    },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

---------- TREESITTER ----------
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
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
}
