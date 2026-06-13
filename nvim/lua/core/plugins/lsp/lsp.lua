local settings = require 'core.settings'
local nvim_lsp = require 'lspconfig'
local utils = require 'core.plugins.lsp.utils'
local lsp_settings = require 'core.plugins.lsp.settings'

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autoclompletion via nvim-cmp
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('core.utils.functions').on_attach(function(client, buffer)
  -- disable formatting for LSP clients as this is handled by null-ls
  -- TODO: not required anymore?
  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false
  require('core.plugins.lsp.keys').on_attach(client, buffer)
end)

local function setup_lsp_language_server(lsp)
  local lsp_server_settings = {}

  if lsp == 'rust_analyzer' then
    vim.notify('rust_analyzer is managed by rust-tools', vim.log.levels.INFO, { title = 'LSP config' })
    return
  elseif lsp == 'lua_ls' then
    lsp_server_settings.Lua = lsp_settings.lua
  elseif lsp == 'jsonls' then
    lsp_server_settings.json = lsp_settings.json
  elseif lsp == 'terraformls' then
    lsp_server_settings.redhat = { telemetry = { enabled = false } }
  elseif lsp == 'yamlls' then
    lsp_server_settings.yaml = lsp_settings.yaml
  elseif lsp == 'texlab' then
    lsp_server_settings.texlab = lsp_settings.tex
  end

  -- NOTE: It uses the default configuration for each server from nvim-lspconfig.
  vim.lsp.config(lsp, {
    before_init = function(_, config)
      if lsp == 'pyright' then
        config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
      end
    end,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = lsp_server_settings,
  })
end

for _, lsp in ipairs(settings.lsp_servers) do
  setup_lsp_language_server(lsp)
end

vim.lsp.config('flow', {
  capabilities = capabilities,
})

-- NOTE: In order to support Flow language properly, it needs to use jsx filetype.
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/3350
vim.filetype.add {
  pattern = {
    ['.*.js'] = {
      priority = math.huge,
      function(_, bufnr)
        -- Check the top 10 commented lines if there is any with a Flow annotation
        -- which determines it is a Javascript file with Flow type checking support.
        local isFlowFile = false

        -- TODO: it is using a private method, replace it with a public api option.
        local lines = vim.filetype._getlines(bufnr, 1, 10)

        for _, content in pairs(lines) do
          if content ~= '' then
            -- TODO: it is using a private method, replace it with a public api option.
            if vim.filetype._matchregex(content, '^// @flow') or vim.filetype._matchregex(content, '^/* @flow') then
              isFlowFile = true
              break
            end

            -- TODO: it is using a private method, replace it with a public api option.
            if vim.filetype._matchregex(content, '^// @noflow') or vim.filetype._matchregex(content, '^/* @noflow') then
              break
            end
          end
        end

        if isFlowFile then
          return 'javascriptreact'
        else
          return 'javascript'
        end
      end,
    },
  },
}

vim.treesitter.language.register('tsx', 'javascriptreact')
