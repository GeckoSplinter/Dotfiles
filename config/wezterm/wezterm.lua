-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()



config.color_scheme = 'rose-pine'
-- config.font = wezterm.font("VictorMono Nerd Font Mono", { weight = 'Bold'})
config.font = wezterm.font { family = 'FiraCode Nerd Font', weight = 'Regular' }

config.font_rules = {
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font {
      family = 'VictorMono Nerd Font',
      weight = 'Bold',
      style = 'Italic',
    },
  },
  {
    italic = true,
    intensity = 'Half',
    font = wezterm.font {
      family = 'VictorMono Nerd Font',
      weight = 'DemiBold',
      style = 'Italic',
    },
  },
  {
    italic = true,
    intensity = 'Normal',
    font = wezterm.font {
      family = 'VictorMono Nerd Font',
      style = 'Italic',
    },
  },
}
config.font_size = 15

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.window_background_opacity = 1

-- and finally, return the configuration to wezterm
return config
