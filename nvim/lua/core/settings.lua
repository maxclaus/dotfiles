---- [[ Setting options ]]
---- See `:help vim.o`
---- NOTE: You can change these options as you wish!
--
---- Set highlight on search
--vim.o.hlsearch = false
--
---- Make line numbers default and relative
--vim.wo.number = true
--vim.wo.relativenumber = true
--
---- Enable mouse mode
--vim.o.mouse = 'a'
--
---- Enable break indent
--vim.o.breakindent = true
--
---- Save undo history
--vim.o.undofile = true
--
---- Case-insensitive searching UNLESS \C or capital in search
--vim.o.ignorecase = true
--vim.o.smartcase = true
--
---- Keep signcolumn on by default
--vim.wo.signcolumn = 'yes'
--
---- Decrease update time
--vim.o.updatetime = 250
--vim.o.timeout = true
--vim.o.timeoutlen = 300
--
---- Set completeopt to have a better completion experience
--vim.o.completeopt = 'menuone,noselect'
--
---- NOTE: You should make sure your terminal supports this
--vim.o.termguicolors = true
--
---- disable netrw at the very start of your init.lua
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
--
----vim.opt.encoding="utf-8"
----vim.g.airline_powerline_fonts = 1
local M = {}

-- theme: nightfox, tokyonight, tundra, kanagawa, oxocarbon; default is catppuccin
-- refer to the themes settings file for different styles
M.theme = 'onedark'
-- Toggle global status line
M.global_statusline = true
-- use rg instead of grep
M.grepprg = 'rg --hidden --vimgrep --smart-case --'
-- set numbered lines
M.number = true
-- enable mouse see :h mouse
M.mouse = 'nv'
-- set relative numbered lines
M.relative_number = true
-- always show tabs; 0 never, 1 only if at least two tab pages, 2 always
M.showtabline = 1
-- enable or disable listchars
M.list = false
-- which list chars to schow
M.listchars = 'eol:¬,tab:>·,trail:~,extends:>,precedes:<'
-- Noice heavily changes the Neovim UI ...
-- NOTE: Disabled it for now, as noice was freezing Neovim very often
M.enable_noice = false
-- Number of recent files shown in dashboard
-- 0 disables showing recent files
M.dashboard_recent_files = 5
-- disable the header of the dashboard
M.disable_dashboard_header = false
-- disable quick links of the dashboard
M.disable_dashboard_quick_links = false
-- which tool to use for handling git merge conflicts
-- choose between "git-conflict" and "diffview"
M.merge_conflict_tool = 'git-conflict'
-- treesitter parsers to be installed
-- one of "all", "maintained" (parsers with maintainers), or a list of languages
M.treesitter_ensure_installed = {
  'bash',
  'cmake',
  'css',
  'dockerfile',
  'go',
  'hcl',
  'html',
  -- 'java',
  'javascript',
  'typescript',
  'json',
  'kotlin',
  'ledger',
  'lua',
  'markdown',
  'markdown_inline',
  'query',
  'python',
  'regex',
  'rust',
  -- 'terraform',
  'toml',
  'vim',
  'yaml',
  'asm',
}

-- LSPs that should be installed by Mason-lspconfig.
-- Any other lsp not supported by Mason needs to be
-- setup directly on lsp/lsp.lua module.
M.lsp_servers = {
  -- 'bashls',
  'dockerls',
  'jsonls',
  'gopls',
  'marksman',
  'pyright',
  'lua_ls',
  'rust_analyzer',
  'tailwindcss',
  'terraformls',
  'texlab',
  'ts_ls',
  'yamlls',
  -- 'flow',
  'clangd',
  'asm_lsp',
  -- 'eslint',
}

-- Tools that should be installed by Mason
M.tools = {
  -- Formatter
  'black',
  'prettier',
  'stylua',
  'shfmt',
  'codespell',
  'yamlfmt',
  'fixjson',
  -- Linter
  'cpplint',
  'eslint_d',
  -- 'shellcheck',
  'selene',
  'tflint',
  'yamllint',
  'ruff',
  'goimports-reviser',
  -- DAP
  'debugpy',
  'codelldb',
  -- Go
  'gofumpt',
  'goimports',
  'gomodifytags',
  'golangci-lint',
  'gotests',
  'iferr',
  'impl',
}

-- enable greping in hidden files
M.telescope_grep_hidden = true

-- which patterns to ignore in file switcher
M.telescope_file_ignore_patterns = {
  '%.7z',
  '%.JPEG',
  '%.JPG',
  '%.MOV',
  '%.RAF',
  '%.burp',
  '%.bz2',
  '%.cache',
  '%.class',
  '%.dll',
  '%.docx',
  '%.dylib',
  '%.epub',
  '%.exe',
  '%.flac',
  '%.ico',
  '%.ipynb',
  '%.jar',
  '%.jpeg',
  '%.jpg',
  '%.lock',
  '%.mkv',
  '%.mov',
  '%.mp4',
  '%.otf',
  '%.pdb',
  '%.pdf',
  '%.png',
  '%.rar',
  '%.sqlite3',
  '%.svg',
  '%.tar',
  '%.tar.gz',
  '%.ttf',
  '%.webp',
  '%.zip',
  '%.git/',
  '%.gradle/',
  '%.idea/',
  '%.settings/',
  '%.vale/',
  '%.vscode/',
  '__pycache__/*',
  'build/',
  'env/',
  'gradle/',
  'node_modules/',
  'smalljre_*/*',
  'target/',
  'vendor/*',
}

return M
