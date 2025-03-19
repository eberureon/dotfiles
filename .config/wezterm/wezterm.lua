-- Pull in the wezterm API
local wezterm = require("wezterm")
local action = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.initial_cols = 170
config.initial_rows = 40

-- my coolnight colorscheme
config.colors = {
  foreground = "#869395",
  background = "#0D2A34",
  cursor_bg = "#47FF9C",
  cursor_border = "#47FF9C",
  cursor_fg = "#011423",
  selection_bg = "#163540",
  selection_fg = "#CBE0F0",
  ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
  brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

config.font = wezterm.font("PragmataPro Mono")
config.font_size = 12

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 10

config.keys = {
  {
    key = "w",
    mods = "CMD|SHIFT",
    action = action.CloseCurrentPane({ confirm = true }),
  },
  {
    key = "v",
    mods = "CMD|SHIFT",
    action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "h",
    mods = "CMD|SHIFT",
    action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "h",
    mods = "CTRL|SHIFT",
    action = action.ActivatePaneDirection("Left"),
  },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = action.ActivatePaneDirection("Right"),
  },
  {
    key = "k",
    mods = "CTRL|SHIFT",
    action = action.ActivatePaneDirection("Up"),
  },
  {
    key = "j",
    mods = "CTRL|SHIFT",
    action = action.ActivatePaneDirection("Down"),
  },
  {
    key = "Z",
    mods = "CMD",
    action = action.TogglePaneZoomState,
  },
}

-- and finally, return the configuration to wezterm
return config
