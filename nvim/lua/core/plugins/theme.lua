local settings = require 'core.settings'

-- TODO: configure theme based on system prefenrences
-- example https://drake.dev/posts/configuring-auto-dark-mode
-- example https://github.com/bottd/dotfiles/blob/3a73a1915bb48317f455d5608c5d03aebe75630f/home/opt/wezterm/wezterm.lua#L27
-- https://github.com/f-person/auto-dark-mode.nvim

if settings.theme == 'onedark' then
  return {
    'navarasu/onedark.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        -- style = 'light',
        style = 'dark',
      }
      require('onedark').load()
    end,
  }
else
  print 'Invalid theme option'
  os.exit()
end
