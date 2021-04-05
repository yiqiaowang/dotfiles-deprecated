--- Keybindings

Keybind.g({
	{ 'n', '<leader>ff', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true } },
	{ 'n', '<leader>fb', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true } },
  { 'n', '<leader>fg', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true } },
  { 'n', '<leader>fh', [[:lua require('telescope.builtin').oldfiles()<cr>]], { noremap = true, silent = true } },
})


Keybind.g({
	{ 'n', '<Leader>fc', [[<Cmd>lua require('telescope.builtin').git_branches()<CR>]], { noremap = true, silent = true } },
})

--- Settings
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "top",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}