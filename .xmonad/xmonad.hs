import XMonad
--import XMonad.Layout.SimpleFloat
import XMonad.Layout.ThreeColumns
import XMonad.Hooks.DynamicLog
--import XMonad.Hooks.EwmhDesktops

-- Define default layouts used on most workspaces
--defaultLayouts = tiled ||| simpleFloat ||| Full
--defaultLayouts = tiled ||| ThreeCol 1 (3/100) (1/2) ||| Full
myLayouts = ThreeCol 1 (1/100) (49/100) ||| Full
--    where
        -- default tiling algorithm partitions the screen into two panes
--        tiled   = Tall nmaster delta ratio
        -- The default number of windows in the master pane
--        nmaster = 1
        -- Default proportion of screen occupied by master pane
--        ratio   = 1/2
        -- Percent of screen to increment by when resizing panes
--        delta   = 3/100

-- Put all layouts together
--myLayouts = defaultLayouts

-- Run XMonad
main = do
--      xmonad $ xmobar defaultConfig {
      xmonad =<< xmobar defaultConfig {
        layoutHook = myLayouts
      }
