-- Copied originally from https://github.com/dragonlobster/wezterm-config
-- https://github.com/hadynz/dotfiles/blob/main/wezterm/wezterm-multiplex.lua

-- Pull in the wezterm API
local wezterm = require("wezterm")
local utils = require("utils")
local colors = require("colors.onedark").colors

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- For example, changing the color scheme:
config.color_scheme = "OneDark (base16)"
config.font = wezterm.font("FiraMono Nerd Font Mono")
config.font_size = 16
config.tab_max_width = 100

-- config.window_decorations = "RESIZE"
config.window_padding = {
  left = 20,
  right = 20,
  top = 30, -- padding for macos top bar
  bottom = 20,
}

-- tmux
config.leader = { key = "o", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },

  -- Splitting
  {
    mods = "LEADER",
    key = "\\",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = "LEADER",
    key = "-",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },

  -- Swap panes
  {
    mods = "LEADER",
    key = "s",
    action = wezterm.action.PaneSelect({
      mode = "SwapWithActive",
    }),
  },

  -- Tab Navigation
  {
    mods = "LEADER",
    key = "p",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    mods = "LEADER",
    key = "n",
    action = wezterm.action.ActivateTabRelative(1),
  },

  -- Tab Navigation
  {
    mods = "LEADER",
    key = "h",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    mods = "LEADER",
    key = "j",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    mods = "LEADER",
    key = "k",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },

  -- Cycle Panes Forward/Backward
  -- Keep zoomed state when active.
  {
    key = ";",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      local panes = pane:tab():panes_with_info()
      local is_zoomed = false
      for _, p in ipairs(panes) do
        if p.is_zoomed then
          is_zoomed = true
          break
        end
      end

      wezterm.log_info(string.format("is_zoomed %s", tostring(is_zoomed)))

      if #panes == 1 then
        return
      end

      if is_zoomed then
        win:perform_action(
          wezterm.action.Multiple({
            wezterm.action.SetPaneZoomState(false),
            wezterm.action.ActivatePaneDirection("Next"),
            wezterm.action.SetPaneZoomState(true),
          }),
          pane
        )
      else
        win:perform_action(wezterm.action.ActivatePaneDirection("Next"), pane)
      end
    end),
  },

  -- Resizing
  {
    mods = "LEADER",
    key = "LeftArrow",
    action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
  },
  {
    mods = "LEADER",
    key = "RightArrow",
    action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
  },
  {
    mods = "LEADER",
    key = "DownArrow",
    action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
  },
  {
    mods = "LEADER",
    key = "UpArrow",
    action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
  },

  -- Zoom/Zen
  {
    mods = "LEADER",
    key = "z",
    action = wezterm.action.TogglePaneZoomState,
  },

  -- Toggle terminal panes
  {
    key = "`",
    mods = "CTRL",
    action = wezterm.action_callback(function(_, pane)
      local tab = pane:tab()
      local panes = tab:panes_with_info()
      if #panes == 1 then
        pane:split({
          direction = "Bottom",
          size = 0.3,
        })
      elseif not panes[1].is_zoomed then
        panes[1].pane:activate()
        tab:set_zoomed(true)
      elseif panes[1].is_zoomed then
        tab:set_zoomed(false)
        panes[2].pane:activate()
      end
    end),
  },
  -- Tab rename
  {
    key = "r",
    mods = "CMD",
    action = wezterm.action.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  -- Copy Mode
  {
    key = "[",
    mods = "LEADER",
    action = wezterm.action.ActivateCopyMode,
  },

  -- Clear Terminal
  {
    key = "k",
    mods = "CMD",
    -- action = wezterm.action.ClearScrollback('ScrollbackAndViewport'),
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
}

for i = 0, 9 do
  -- leader + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
-- config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

-- tmux status
wezterm.on("update-right-status", function(window, _)
  local SOLID_LEFT_ARROW = ""
  local ARROW_FOREGROUND = { Foreground = { Color = "#000" } }
  local prefix = ""

  if window:leader_is_active() then
    prefix = " 🌊"
    SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  end

  if window:active_tab():tab_id() ~= 0 then
    -- arrow color based on if tab is first pane
    ARROW_FOREGROUND = { Foreground = { Color = "#333333" } }
  end

  window:set_left_status(wezterm.format({
    { Background = { Color = "#b7bdf8" } }, -- bg when active
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW },
  }))
end)

-- Current tab title
wezterm.on("format-tab-title", function(tab)
  -- -- and that we have room for the edges.
  -- title = wezterm.truncate_right(title, max_width - 2)

  return {
    { Attribute = { Intensity = "Bold" } },
    { Text = string.format(" %s. ", tab.tab_index + 1) },
    "ResetAttributes",
    { Text = utils.tab_title(tab) },
    { Foreground = { Color = colors.base } },
    { Text = "▕" },
  }
end)

-- and finally, return the configuration to wezterm
return config
