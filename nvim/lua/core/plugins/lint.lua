-- local config = vim.g.config.plugins.nvim_lint

local events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' }
-- Plugin to handle linting
return {
  'mfussenegger/nvim-lint',
  event = events,
  enabled = true,
  opts = {
    events = events,
    linters_by_ft = {
      c = { 'cppcheck' },
      -- dockerfile = { 'hadolint' },
      -- go = { 'golangcilint' },
      lua = { 'selene' },
      -- sh = { 'shellcheck' },
      yaml = { 'yamllint' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
    },
  },
  config = function(_, opts)
    local lint = require 'lint'
    lint.linters_by_ft = opts.linters_by_ft

    -- extend ccpcheck configuration to solve an issue about include checkings
    -- https://github.com/danmar/cppcheck/pull/3824
    table.insert(lint.linters.cppcheck.args, '--suppress=missingIncludeSystem')

    local lint_augroup = vim.api.nvim_create_augroup('linting', { clear = true })
    vim.api.nvim_create_autocmd(opts.events, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
    vim.api.nvim_create_user_command('DisableLinting', function()
      -- utils.notify("Disable Linting", vim.log.levels.INFO, "nvim-lint")
      local ft = vim.filetype.match { buf = 0 }
      require('lint').linters_by_ft[ft] = {}
      vim.diagnostic.hide()
    end, { desc = 'Disable linting for current filetype' })
    vim.keymap.set('n', '<leader>tL', '<cmd>DisableLinting<cr>', { desc = 'Toggle Linting' })
  end,
}
