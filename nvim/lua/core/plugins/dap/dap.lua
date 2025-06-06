local M = {}

local function configure()
  local dap_breakpoint = {
    breakpoint = {
      -- text = '',
      -- text = '',
      text = '',
      texthl = 'DiagnosticInfo',
      linehl = '',
      numhl = '',
    },
    breakpoint_condition = {
      text = '',
      texthl = 'DiagnosticInfo',
      linehl = '',
      numhl = '',
    },
    breakpoint_rejected = {
      text = '',
      texthl = 'DiagnosticSignError',
      linehl = '',
      numhl = '',
    },
    stopped = {
      text = '',
      texthl = 'DiagnosticSignWarn',
      linehl = 'Visual',
      numhl = 'DiagnosticSignWarn',
    },
    log_point = {
      text = '.>',
      texthl = 'DiagnosticInfo',
      linehl = '',
      numhl = '',
    },
  }

  vim.fn.sign_define('DapBreakpoint', dap_breakpoint.breakpoint)
  vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.breakpoint_condition)
  vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)
  vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.breakpoint_rejected)
  vim.fn.sign_define('DapLogPoint', dap_breakpoint.log_point)

  -- vim.api.nvim_set_hl(0, 'DapBreakpoint', { bg = '#552B24' })
  -- vim.api.nvim_set_hl(0, 'DapBreakpointStopped', { bg = '#244C55' })
end

local function configure_exts()
  require('nvim-dap-virtual-text').setup {
    commented = true,
  }

  local dap = require 'dap'
  local dapui = require 'dapui'

  dap.set_log_level 'DEBUG'

  -- print 'DEBUG DATA'
  -- print(vim.fn.stdpath 'data' .. '/nvim_checkpoints')
  -- require('persistent-breakpoints').setup {
  --   save_dir = vim.fn.stdpath 'data' .. '/nvim_checkpoints',
  --   load_breakpoints_event = { 'BufReadPost' },
  -- }

  dapui.setup {} -- use default
  dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open {}
  end
  -- dap.listeners.before.event_terminated['dapui_config'] = function()
  --   dapui.close {}
  -- end
  -- dap.listeners.before.event_exited['dapui_config'] = function()
  --   dapui.close {}
  -- end
end

--- Gets a path for a given program in the environment
---@param program string String of a program in the Mason packages
---@return Path Full path to the program if found, or nil if not
local function get_program_path(program)
  local program_path = vim.fn.stdpath 'data' .. '/mason/packages/' .. program .. '/' .. program
  return program_path
end

local function configure_debuggers()
  local dap = require 'dap'

  local lldb_path = get_program_path 'codelldb'

  -- Adapaters
  dap.adapters.lldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = lldb_path,
      args = { '--port', '${port}' },
    },
    name = 'lldb',
  }

  -- configurations
  dap.configurations.cpp = {
    {
      name = 'Launch',
      type = 'lldb',
      request = 'launch',
      program = function()
        return vim.fn.input {
          prompt = 'Path to executable: ',
          completion = 'file',
        }
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},

      -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
      --
      --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      --
      -- Otherwise you might get the following error:
      --
      --    Error on launch: Failed to attach to the target process
      --
      -- But you should be aware of the implications:
      -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
      runInTerminal = false,
    },
  }

  dap.configurations.c = dap.configurations.cpp
  dap.configurations.asm = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
  require('dap-go').setup()
end

local function create_mapping()
  local wk = require 'which-key'

  wk.add {
    { '<leader>d', group = 'Debug' },
    {
      '<leader>d?',
      function()
        require('dapui').eval(nil, { enter = true })
      end,
      desc = 'Show variable value',
    },
    { '<leader>dB', ':lua require("persistent-breakpoints.api").set_conditional_breakpoint()<cr>', desc = 'Conditional breakpoint' },
    { '<leader>dD', ':lua require("persistent-breakpoints.api").clear_all_breakpoints()<cr>', desc = 'Clear breakpoints' },
    { '<leader>dO', ':lua require("dap").step_out()<cr>', desc = 'Step Out (S-F11)' },
    { '<leader>dQ', ':lua require("dap").terminate()<cr>', desc = 'Terminate Session' },
    { '<leader>dR', ':lua require("dap").repl.toggle()<cr>', desc = 'Toggle REPL' },
    { '<leader>db', ':lua require("persistent-breakpoints.api").toggle_breakpoint()<cr>', desc = 'Toggle breakpoint (F9)' },
    { '<leader>dc', ':lua require("dap").continue()<cr>', desc = 'Start/Continue (F5)' },
    { '<leader>di', ':lua require("dap").step_into()<cr>', desc = 'Step Into (F11)' },
    { '<leader>do', ':lua require("dap").step_over()<cr>', desc = 'Step Over (F10)' },
    { '<leader>dp', ':lua require("dap").pause()<cr>', desc = 'Pause (F6)' },
    { '<leader>dq', ':lua require("dap").close()<cr>', desc = 'Close Session' },
    { '<leader>dr', ':lua require("dap").restart_frame()<cr>', desc = 'Restart (C-F5)' },
    { '<leader>ds', ':lua require("dap").run_to_cursor()<cr>', desc = 'Run To Cursor' },
    { '<leader>du', ':lua require("dapui").toggle()<CR>', desc = 'Toggle UI' },
  }

  vim.keymap.set('n', '<F5>', require('dap').continue)
  vim.keymap.set('n', '<F10>', require('dap').step_over)
  vim.keymap.set('n', '<F11>', require('dap').step_into)
  vim.keymap.set('n', '<F12>', require('dap').step_out)
  -- TODO: add all function key mappings

  -- maps.n["<F5>"] = { function() require("dap").continue() end, desc = "Debugger: Start" }
  -- maps.n["<F17>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" } -- Shift+F5
  -- maps.n["<F21>"] = { -- Shift+F9
  --   function()
  --     vim.ui.input({ prompt = "Condition: " }, function(condition)
  --       if condition then require("dap").set_breakpoint(condition) end
  --     end)
  --   end,
  --   desc = "Debugger: Conditional Breakpoint",
  -- }
  -- maps.n["<F29>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" } -- Control+F5
  -- maps.n["<F6>"] = { function() require("dap").pause() end, desc = "Debugger: Pause" }
  -- maps.n["<F9>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" }
  -- maps.n["<F10>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" }
  -- maps.n["<F11>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" }
  -- maps.n["<F23>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" } -- Shift+F11
  -- maps.n["<Leader>db"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F9)" }
  -- maps.n["<Leader>dB"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" }
  -- maps.n["<Leader>dc"] = { function() require("dap").continue() end, desc = "Start/Continue (F5)" }
  -- maps.n["<Leader>dC"] = {
  --   function()
  --     vim.ui.input({ prompt = "Condition: " }, function(condition)
  --       if condition then require("dap").set_breakpoint(condition) end
  --     end)
  --   end,
  --   desc = "Conditional Breakpoint (S-F9)",
  -- }
end

function M.setup()
  configure() -- Configuration
  configure_exts() -- Extensions
  configure_debuggers() -- Debugger
  create_mapping() -- which-key mapping
  -- require 'core.plugins.hydra.dap' -- enable Hydra head
end

return M
