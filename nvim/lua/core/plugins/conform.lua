-- Plugin to handle formatting
return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile', 'InsertLeave' },
  enabled = true,
  opts = {
    format_on_save = function()
      -- Disable with a global variable
      if vim.g.disable_autoformat then
        return
      end
      return { async = false, timeout_ms = 500, lsp_fallback = false }
    end,
    -- log_level = vim.log.levels.TRACE,
    formatters_by_ft = {
      -- asm = { 'asmfmt' },
      c = { 'clang_format' },
      go = { 'goimports', 'gofmt' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' }, -- used by the Flow language
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      -- json = { 'prettier' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      python = { 'isort', 'ruff_format' },
      rust = { 'ruff_format', 'rustfmt' },
      -- sh = { 'shfmt' },
      terraform = { 'terraform_fmt' },
      tex = { 'latexindent' },
      typst = { 'typstfmt' },
      -- yaml = { 'yamlfmt' },
    },
  },
  config = function(_, opts)
    local conform = require 'conform'
    local util = require 'conform.util'

    conform.setup(opts)
    -- conform.formatters.shfmt = {
    --   prepend_args = { '-i', '2' }, -- 2 spaces instead of tab
    -- }
    conform.formatters.stylua = {
      prepend_args = { '--indent-type', 'Spaces', '--indent-width', '2' }, -- 2 spaces instead of tab
    }
    conform.formatters.yamlfmt = {
      prepend_args = { '-formatter', 'indent=2,include_document_start=true,retain_line_breaks_single=true' },
    }
    conform.formatters.clang_format = {
      -- cwd = util.root_file { '.editorconfig', '.clang-format' },
      -- require_cwd = true,
      -- append_args = {
      --   '--style={BasedOnStyle: Google, IndentWidth: 4, BinPackArguments: false, BinPackParameters: false, AlignAfterOpenBracket: BlockIndent }',
      -- },
    }

    vim.g.disable_autoformat = false
    vim.api.nvim_create_user_command('ToggleAutoformat', function()
      vim.g.disable_autoformat = vim.g.disable_autoformat == false and true or false
    end, { desc = 'Toggling autoformat' })
    vim.keymap.set('n', '<leader>tF', '<cmd>ToggleAutoformat<cr>', { desc = 'Toggle format on save' })
  end,
}
