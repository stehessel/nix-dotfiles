local wezterm = require("wezterm")
return {
  font = wezterm.font_with_fallback({ "FiraCode Nerd Font", "Font Awesome 5 Free" }),
  font_size = 18.0,
  keys = {
    { key = "[", mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTabRelative = -1 }) },
    { key = "]", mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTabRelative = 1 }) },
    {
      key = "h",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
    },
    {
      key = "v",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
    },
  },
}
