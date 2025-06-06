local M = {}

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
function M.basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

function M.get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir

  if current_dir then
    local path = current_dir.file_path
    return M.basename(path)
  end

  return ""
end

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function M.tab_title(tab)
  -- If the tab title is explicitly set, take that
  local title = tab.tab_title

  -- Otherwise, try to use current working directory as the title
  if #title == 0 then
    title = M.get_current_working_dir(tab)
  end

  -- Otherwise, use the title from the active pane
  -- in that tab
  if #title == 0 then
    title = tab.active_pane.title
  end

  if tab.active_pane.is_zoomed then
    title = title .. " "
  end

  return title
end

return M
