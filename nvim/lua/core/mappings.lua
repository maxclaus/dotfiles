-- TODO: Keep all mappings possible in this module
-- Example https://github.com/dkarter/dotfiles/blob/master/config/nvim/lua/core/mappings.lua

--local opts = { noremap = true, silent = true }
--
--local term_opts = { silent = true }
--
---- Shorten function name
--local keymap = vim.api.nvim_set_keymap
--
----Remap space as leader key
--keymap('', '<Space>', '<Nop>', opts)
--vim.g.mapleader = ' '
--vim.g.maplocalleader = ' '
--
---- Modes
----   normal_mode = "n",
----   insert_mode = "i",
----   visual_mode = "v",
----   visual_block_mode = "x",
----   term_mode = "t",
----   command_mode = "c",
--
---- Normal --
---- Better window navigation
--keymap('n', '<C-h>', '<C-w>h', opts)
--keymap('n', '<C-k>', '<C-w>k', opts)
--keymap('n', '<C-j>', '<C-w>j', opts)
--keymap('n', '<C-l>', '<C-w>l', opts)
--
---- Resize with arrows when using multiple windows
--keymap('n', '<C-Up>', ':resize -2<CR>', opts)
--keymap('n', '<c-down>', ':resize +2<cr>', opts)
--keymap('n', '<c-right>', ':vertical resize -2<cr>', opts)
--keymap('n', '<c-left>', ':vertical resize +2<cr>', opts)
--
---- navigate buffers
--keymap('n', '<tab>', ':bnext<cr>', opts)
--keymap('n', '<s-tab>', ':bprevious<cr>', opts)
--keymap('n', '<leader>h', ':nohlsearch<cr>', opts) -- No highlight search
--
---- move text up and down
--keymap('n', '<a-j>', '<esc>:m .+1<cr>==gi', opts)
--keymap('n', '<a-k>', '<esc>:m .-2<cr>==gi', opts)
--
---- insert --
---- press jk fast to exit insert mode
--keymap('i', 'jk', '<esc>', opts)
--keymap('i', 'kj', '<esc>', opts)
--
--keymap('n', 'df', 'ggdG', opts)
--keymap('n', 'yf', 'ggyG', opts)
--
--keymap('n', 'z', '0', opts)
--keymap('n', 'm', '$', opts)
--keymap('n', ';', '%', opts)
---- visual --
---- stay in indent mode
--keymap('v', '<', '<gv', opts)
--keymap('v', '>', '>gv', opts)
--
---- move text up and down
--keymap('v', '<a-j>', ':m .+1<cr>==', opts)
--keymap('v', '<a-k>', ':m .-2<cr>==', opts)
--keymap('v', 'p', '"_dp', opts)
--
---- Visual Block --
---- Move text up and down
----Terminal --
--keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
--keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
--keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
--keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)
--
----Better terminal navigation
--keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
--keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
--keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
--keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

local utils = require 'core.utils.functions'
local map = vim.keymap.set

-- disable arrow keys on normal and insert mode
map({ 'n', 'i' }, '<up>', '', { noremap = true })
map({ 'n', 'i' }, '<down>', '', { noremap = true })
map({ 'n', 'i' }, '<left>', '', { noremap = true })
map({ 'n', 'i' }, '<right>', '', { noremap = true })

-- copy and paste to clipboard
map('v', ',y', '"+y', { silent = true, noremap = true, desc = 'Copy to system clipboard (on yank)' })
map('v', ',d', '"+d', { silent = true, noremap = true, desc = 'Copy to system clipboard (on delete)' })
map({ 'n', 'v' }, ',p', '"+p', { silent = true, noremap = true, desc = ' Paste from system clipboard' })
map({ 'n', 'v' }, ',P', '"+P', { silent = true, noremap = true, desc = 'Paste from system clipboard (before position)' })

-- Remap for dealing with visual line wraps
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- switch buffer
map('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '<S-tab>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })

-- Cancel search highlighting with ESC
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Clear hlsearch and ESC' })

-- move over a closing element in insert mode
map('i', '<C-l>', function()
  return require('core.utils.functions').escapePair()
end)

-- save like your are used to
map({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- search and replace is a pain with a German keyboard layout
map({ 'v', 'n' }, '<leader>sr', ':%s/', { desc = 'Buffer search and replace' })

-- toggles
map('n', '<leader>th', function()
  utils.notify('Toggling hidden chars', vim.log.levels.INFO, 'core.mappings')
  vim.o.list = vim.o.list == false and true or false
end, { desc = 'Toggle hidden chars' })
map('n', '<leader>tl', function()
  utils.notify('Toggling signcolumn', vim.log.levels.INFO, 'core.mappings')
  vim.o.signcolumn = vim.o.signcolumn == 'yes' and 'no' or 'yes'
end, { desc = 'Toggle signcolumn' })
map('n', '<leader>tv', function()
  utils.notify('Toggling virtualedit', vim.log.levels.INFO, 'core.mappings')
  vim.o.virtualedit = vim.o.virtualedit == 'all' and 'block' or 'all'
end, { desc = 'Toggle virtualedit' })
map('n', '<leader>ts', function()
  utils.notify('Toggling spell', vim.log.levels.INFO, 'core.mappings')
  vim.o.spell = vim.o.spell == false and true or false
end, { desc = 'Toggle spell' })
map('n', '<leader>tw', function()
  utils.notify('Toggling wrap', vim.log.levels.INFO, 'core.mappings')
  vim.o.wrap = vim.o.wrap == false and true or false
end, { desc = 'Toggle wrap' })

map('n', '<leader>tc', function()
  utils.notify('Toggling cursorline', vim.log.levels.INFO, 'core.mappings')
  vim.o.cursorline = vim.o.cursorline == false and true or false
end, { desc = 'Toggle cursorline' })

map('n', '<leader>tm', function()
  if vim.o.mouse == '' then
    vim.o.mouse = require('core.settings').mouse
    utils.notify('Toggling mouse on', vim.log.levels.INFO, 'core.mappings')
  else
    vim.o.mouse = ''
    utils.notify('Toggling mouse off', vim.log.levels.INFO, 'core.mappings')
  end
end, { desc = 'Toggle mouse' })

map('n', '<leader>to', "<cmd>lua require('core.utils.functions').toggle_colorcolumn()<cr>", { desc = 'Toggle colorcolumn' })
map('n', '<leader>tt', "<cmd>lua require('core.plugins.lsp.utils').toggle_virtual_text()<cr>", { desc = 'Toggle Virtualtext' })
map('n', '<leader>ts', '<cmd>SymbolsOutline<cr>', { desc = 'Toggle SymbolsOutline' })
map('n', '<leader>tS', '<cmd>windo set scb!<cr>', { desc = 'Toggle Scrollbind' })

local wk = require 'which-key'

-- register non leader based mappings
wk.add {
  { 'sF', desc = 'Find left surrounding' },
  { 'sa', desc = 'Add surrounding' },
  { 'sd', desc = 'Delete surrounding' },
  { 'sf', desc = 'Replace right surrounding' },
  { 'sh', desc = 'Highlight surrounding' },
  { 'sn', desc = 'Surround update n lines' },
  { 'sr', desc = 'Replace surrounding' },
  { 'st', "<cmd>lua require('tsht').nodes()<cr>", desc = 'TS hint textobject' },
}

-- Register leader based mappings
wk.add {
  { '<leader><tab>', '<cmd>e#<cr>', desc = 'Prev buffer' },
  { '<leader>b', group = 'Buffers' },
  { '<leader>bD', '<cmd>%bd|e#|bd#<cr>', desc = 'Close all but the current buffer' },
  { '<leader>bd', '<cmd>bdelete<cr>', desc = 'Close buffer' },
  { '<leader>f', group = 'Files' },
  { '<leader>fs', '<cmd>w<cr>', desc = 'Save Buffer' },
  { '<leader>l', desc = 'LSP' },
  { '<leader>lw', desc = 'Workspaces' },
  -- { '<leader>m', group = 'Misc' },
  -- { '<leader>ml', '<cmd>source ~/.config/nvim/snippets/*<cr>', desc = 'Reload snippets' },
  -- { '<leader>mp', '<cmd>Lazy check<cr>', desc = 'Lazy check' },
  { '<leader>q', group = 'Quickfix' },
  { '<leader>qj', '<cmd>cnext<cr>', desc = 'Next Quickfix Item' },
  { '<leader>qk', '<cmd>cprevious<cr>', desc = 'Previous Quickfix Item' },
  { '<leader>qq', "<cmd>lua require('core.utils.functions').toggle_qf()<cr>", desc = 'Toggle quickfix list' },
  { '<leader>qt', '<cmd>TodoQuickFix<cr>', desc = 'Show TODOs' },
  { '<leader>s', desc = 'Search' },
  { '<leader>t', group = 'Toggles' },
  { '<leader>w', desc = 'Windows' },
  { '<leader>z', desc = 'Spelling' },
}
