-- WezTerm config
-- Full reference: https://wezfurlong.org/wezterm/config/files.html

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Copy selection to system clipboard automatically
config.font = wezterm.font('MesloLGS NF')
config.font_size = 12.0

-- Top 3: "Material Darker (base16)", "Monokai Remastered", "Dracula"
-- config.color_scheme = 'Material Darker (base16)'
config.color_scheme = 'Monokai Remastered'

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'Clipboard',
  },
  {
    event = { Up = { streak = 2, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'Clipboard',
  },
  {
    event = { Up = { streak = 3, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'Clipboard',
  },
}

-- Word selection boundaries — characters that delimit words on double-click.
-- Includes / and . so that double-clicking "fred" in "./tmp/fred" selects only "fred".
config.selection_word_boundary = " \t\n{}[]()\"'`,;:/."

return config
