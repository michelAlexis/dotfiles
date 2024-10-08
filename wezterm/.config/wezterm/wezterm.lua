local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Frappe'

config.window_decorations = 'RESIZE'

config.window_padding = {
  top = 0,
  bottom = 0,
  left = 8,
  right = 8,
}

-- tmux
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }
config.keys = {
  {
    mods = 'LEADER',
    key = 'c',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    mods = 'LEADER',
    key = 'x',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    mods = 'LEADER',
    key = 'b',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    mods = 'LEADER',
    key = 'n',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    mods = 'LEADER',
    key = 's',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    mods = 'LEADER',
    key = 'v',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    mods = 'LEADER',
    key = 'h',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    mods = 'LEADER',
    key = 'j',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    mods = 'LEADER',
    key = 'k',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    mods = 'LEADER',
    key = 'l',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    mods = 'LEADER',
    key = 'LeftArrow',
    action = wezterm.action.AdjustPaneSize { 'Left', 5 },
  },
  {
    mods = 'LEADER',
    key = 'RightArrow',
    action = wezterm.action.AdjustPaneSize { 'Right', 5 },
  },
  {
    mods = 'LEADER',
    key = 'DownArrow',
    action = wezterm.action.AdjustPaneSize { 'Down', 5 },
  },
  {
    mods = 'LEADER',
    key = 'UpArrow',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 },
  },
  -- past
  {
    mods = 'CTRL',
    key = 'V',
    action = act.PasteFrom 'Clipboard',
  },
}

for i = 0, 9 do
  -- leader + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.status_update_interval = 1000

wezterm.on('gui-startup', function()
  local tab, pane, window = wezterm.mux.spawn_window {}
  -- Always open on fullscreen
  window:gui_window():maximize()
end)

wezterm.on("update-status", function(window, pane)
  local basename = function(s)
    -- Nothing a little regex can't fix
    return string.gsub(s, '(.*[/\\])(.*)', '%2')
  end

  -- Current working directory
  local cwd = pane:get_current_working_dir()
  if cwd then
    if type(cwd) == 'userdata' then
      -- Wezterm introduced the URL object in 20240127-113634-bbcac864
      cwd = basename(cwd.file_path)
    else
      -- 20230712-072601-f4abf8fd or earlier version
      cwd = basename(cwd)
    end
  else
    cwd = ''
  end

  -- Current command
  local cmd = pane:get_foreground_process_name()
  -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
  cmd = cmd and basename(cmd) or ''

  -- Time
  local time = wezterm.strftime '%H:%M'

  -- Left status (left of the tab line)
  -- window:set_left_status(wezterm.format {
  --   { Foreground = { Color = stat_color } },
  --   { Text = '  ' },
  --   { Text = wezterm.nerdfonts.oct_table .. '  ' .. stat },
  --   { Text = ' |' },
  -- })

  -- Right status
  window:set_right_status(wezterm.format {
    -- Wezterm has a built-in nerd fonts
    -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    { Text = wezterm.nerdfonts.md_folder .. '  ' .. cwd },
    { Text = ' | ' },
    { Foreground = { Color = '#ca9ee6' } },
    { Text = wezterm.nerdfonts.fa_code .. '  ' .. cmd },
    'ResetAttributes',
    { Text = ' | ' },
    { Text = wezterm.nerdfonts.md_clock .. '  ' .. time },
    { Text = '  ' },
  })
end)

return config
