local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Solarized Light (Gogh)"
config.colors = {
  background = "#eae5ce",
  foreground = "#444444",
  cursor_bg = "#222222",
  cursor_fg = "#F6F2DE",

  ansi = {
    "#444444",
    "#dc322f",
    "#859900",
    "#b58900",
    "#268bd2",
    "#d33682",
    "#2aa198",
    "#d9d7cc",
  },
  brights = {
    "#333333",
    "#cb4b16",
    "#93a1a1",
    "#839496",
    "#657b83",
    "#6c71c4",
    "#586e75",
    "#e5e5e5",
  },
}

config.font = wezterm.font_with_fallback({
  { family = "Input Mono Narrow" },
  "JetBrainsMono Nerd Font",
  "nonicons",
  "Open Arrow",
})
config.cell_width = 1
-- config.font = wezterm.font("SF Mono", { weight = "Medium" })
-- config.font = wezterm.font("Input Mono Narrow")
config.underline_position = -4
config.font_size = 14
config.unicode_version = 14

config.use_fancy_tab_bar = false

config.enable_scroll_bar = false
config.tab_bar_at_bottom = true
config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 0,
}

config.send_composed_key_when_left_alt_is_pressed = false

config.freetype_load_target = "HorizontalLcd"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  {
    key = "n",
    mods = "LEADER",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = "p",
    mods = "LEADER",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = "n",
    mods = "LEADER|SHIFT",
    action = wezterm.action.MoveTabRelative(1),
  },
  {
    key = "p",
    mods = "LEADER|SHIFT",
    action = wezterm.action.MoveTabRelative(-1),
  },
  {
    key = "x",
    mods = "LEADER",
    action = wezterm.action.CloseCurrentTab({ confirm = true }),
  },
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "[",
    mods = "LEADER",
    action = wezterm.action.ActivateCopyMode,
  },
  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    key = '!',
    mods = 'LEADER | SHIFT',
    action = wezterm.action_callback(function(win, pane)
      local tab, window = pane:move_to_new_window()
    end),
  },
}

for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- config.webgpu_power_preference = "HighPerformance"

return config
