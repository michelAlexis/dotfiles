local wezterm = require 'wezterm'

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

-- Always open on fullscreen
wezterm.on('gui-startup', function()
  local tab, pane, window = wezterm.mux.spawn_window {}
  window:gui_window():maximize()
end)

return config
