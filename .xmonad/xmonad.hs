import XMonad
--import XMonad.Layout.SimpleFloat
import XMonad.Layout.ThreeColumns
import XMonad.Hooks.DynamicLog
--import XMonad.Hooks.EwmhDesktops
--
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.EwmhDesktops
import System.IO
import XMonad.Hooks.ManageDocks
import Data.Monoid

import qualified Data.Map as M
import XMonad.Actions.CycleWS

--import XMonad.Util.EZConfig
--import XMonad.Util.Run

-- Define default layouts used on most workspaces
--defaultLayouts = tiled ||| simpleFloat ||| Full
--defaultLayouts = tiled ||| ThreeCol 1 (3/100) (1/2) ||| Full
-- myLayouts = ThreeCol 1 (1/100) (49/100) ||| Full
myLayouts = avoidStruts $ ThreeCol 1 (1/100) (49/100) ||| 
   noBorders (fullscreenFull Full)

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
--main = do
--  xmonad =<< xmobar defaultConfig {
--    xmonad =<< xmobar $ defaultConfig {
--


  --xmonad $ xmobar $ myConfig xmproc

--myConfig = defaultConfig {
myLogHook dest = dynamicLogWithPP defaultPP { ppOutput = hPutStrLn dest
                                            ,ppVisible = wrap "(" ")"
              }     

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList
             [
--                  ((modm,               xK_Right),  nextWS)
--                , ((modm,               xK_Left),    prevWS)
                  ((controlMask,               xK_Right),  nextWS)
                , ((controlMask,               xK_Left),    prevWS)
             ]

myConfig xmproc = defaultConfig {
  layoutHook = myLayouts,
  --terminal = "urxvt256cc"
  terminal = "terminator",
  logHook = myLogHook xmproc,
  manageHook = manageHook defaultConfig <+> manageDocks,
  keys = myKeys <+> keys defaultConfig
--  handleEventHook = mconcat
--                          [ docksEventHook
--                          , handleEventHook defaultConfig ]



  -- mod is Windows key
  -- modMask = mod4Mask
}

main = do
  xmproc <- spawnPipe "/home/john/.cabal/bin/xmobar /home/john/dotfiles/.xmobarrc"
  xmonad $ ewmh $ myConfig xmproc

--main = xmonad =<< xmobar myConfig

