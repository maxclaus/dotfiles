-- Project navigation to bookmarked files.
return {
  'cbochs/grapple.nvim',
  -- opts = {
  --   scope = 'git',
  --   win_opts = {
  --     width = 140,
  --     height = 22,
  --   },
  -- },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    { '<leader>mt', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
    { '<leader>mm', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
    { '<leader>mn', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
    { '<leader>mp', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },
    {
      'mM',
      -- '<cmd>Telescope grapple tags layout_strategy=horizontal layout_config={preview_width=0.5}<cr>',
      '<cmd>Telescope grapple tags theme=dropdown shorten_path=true layout_strategy=horizontal previewer=false<cr>',
      -- '<cmd>Telescope grapple tags theme=dropdown<cr>',
      -- '<cmd>Telescope grapple tags<cr>',
      desc = 'Grapple open tags window',
    },
  },
  config = function(_, _opts)
    -- -- vim.api.nvim_set_hl(0, 'GrappleNormal', { link = 'Added' })
    -- -- vim.api.nvim_set_hl(0, 'GrappleBorder', { link = 'Added' })
    --
    -- -- vim.api.nvim_set_hl(0, 'GrappleNormal', { bg = 3946550, fg = 12106534 })
    -- vim.api.nvim_set_hl(0, 'GrappleNormal', { link = 'Pmenu' })
    -- -- vim.api.nvim_set_hl(0, 'GrappleTitle', { link = 'Added' })
    -- -- vim.api.nvim_set_hl(0, 'GrappleCurrent', { link = 'Added' })
    -- vim.api.nvim_set_hl(0, 'GrappleCurrent', { link = 'Added' })
    -- vim.api.nvim_set_hl(0, 'GrappleNoExist', { link = 'Added' })
    --
    -- -- vim.api.nvim_set_hl(0, 'GrappleTitle', { bg = '#ededed' })
    -- -- vim.api.nvim_set_hl(0, 'GrappleName', { link = 'Added' })

    -- vim.cmd("highlight default GrappleBold gui=bold cterm=bold")
    -- vim.cmd("highlight default link GrappleHint Comment")
    -- vim.cmd("highlight default link GrappleName DiagnosticHint")
    -- vim.cmd("highlight default link GrappleNoExist DiagnosticError")
    -- vim.cmd("highlight default link GrappleNormal NormalFloat")
    -- vim.cmd("highlight default link GrappleBorder FloatBorder")
    -- vim.cmd("highlight default link GrappleTitle FloatTitle")
    -- vim.cmd("highlight default link GrappleFooter FloatFooter")

    -- vim.api.nvim_set_hl(0, 'GrappleNoExist', { link = 'Added' })
    -- vim.api.nvim_set_hl(0, 'GrappleBold', { bg = '#800080', fg = '#FFFF00' })
    -- vim.api.nvim_set_hl(0, 'GrappleHint', { bg = '#800080', fg = '#FFFF00' })
    -- vim.api.nvim_set_hl(0, 'GrappleName', { bg = '#800080', fg = '#FFFF00' })
    -- vim.api.nvim_set_hl(0, 'GrappleNoExist', { bg = '#800080', fg = '#FFFF00' })
    -- vim.api.nvim_set_hl(0, 'GrappleNormal', { bg = '#800080', fg = '#FFFF00' })
    -- vim.api.nvim_set_hl(0, 'GrappleBorder', { bg = '#800080', fg = '#FFFF00' })
    -- vim.api.nvim_set_hl(0, 'GrappleTitle', { bg = '#800080', fg = '#FFFF00' })
    -- vim.api.nvim_set_hl(0, 'GrappleFooter', { bg = '#800080', fg = '#FFFF00' })

    local opts = {
      icons = false,
      tag_title = function(scope)
        return vim.fn.fnamemodify(scope.id, ':t')
      end,
      styles = {
        custom = function(entity, _)
          -- TODO: show only last 50 chars
          local path = require 'grapple.path'

          local parent_mark = {
            virt_text = {
              {
                path.parent(path.fs_short(entity.tag.path)),
                'GrappleHint',
              },
            },
            virt_text_pos = 'eol',
          }

          local line = {
            display = path.base(entity.tag.path),
            marks = { parent_mark },
          }

          return line
        end,
      },
      style = 'custom',
      -- style = 'basename',
      -- style = 'relative',
      win_opts = {
        width = 150,
        height = 12,
        row = 0.3,
        border = 'rounded',
        title_pos = 'center',
        footer = '',
      },
    }

    require('telescope').load_extension 'grapple'
    -- require('grapple').setup(opts)
    require('grapple').setup(opts)
  end,
}

-- -- Bookmark navigation
-- return {
--   'otavioschwanck/arrow.nvim',
--   dependencies = {
--     { 'nvim-tree/nvim-web-devicons' },
--     -- or if using `mini.icons`
--     -- { "echasnovski/mini.icons" },
--   },
--   opts = {
--     show_icons = true,
--     leader_key = ';', -- Recommended to be a single key
--     buffer_leader_key = 'm', -- Per Buffer Mappings
--   },
-- }
