-- Highlight and search for todo comments like TODO, HACK, BUG in the code base
local M = {
  'folke/todo-comments.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    highlight = {
      -- vimgrep regex, supporting the pattern TODO(name):
      pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]],
    },
    search = {
      -- ripgrep regex, supporting the pattern TODO(name):
      pattern = [[\b(KEYWORDS)(\(\w*\))*:]],
    },
  },
}

return M
