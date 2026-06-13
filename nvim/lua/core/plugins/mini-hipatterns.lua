-- Algin plugin
-- Usage: to align all columns in csv use "<leader>gas,"
local M = {
  'echasnovski/mini.hipatterns',
  config = function()
    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}

return M
