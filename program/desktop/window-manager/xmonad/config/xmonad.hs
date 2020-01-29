--Base
import XMonad
import XMonad.Config.Desktop
import Data.List (sortBy)
import Data.Function (on)
import System.IO
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
-- Actions
import Control.Monad (forM_, join, liftM2)
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.GroupNavigation
import XMonad.Actions.MouseResize
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WithAll (sinkAll, killAll)
-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
-- Layouts
import XMonad.Layout.Fullscreen
import XMonad.Layout.GridVariants
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ThreeColumns
-- Layout modifiers
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
-- Utilities
import XMonad.Util.NamedWindows (getName)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

-- Workspaces
myWorkspaces = ["  1 : \xf120  ","  2 : \xf121  ","  3 : \xf269  ","  4 : \xf87c  ","  5 : \xf141  "]

-- Hooks
myManageHook = composeAll
	[ className =? "firefox" --> viewShift "  3 : \xf269  "
	, (className =? "firefox" <&&> resource =? "Dialog") --> doFloat
	, isFullscreen --> (doF W.focusDown <+> doFullFloat) ]
	<+> manageDocks
	<+> namedScratchpadManageHook myScratchPads
	where viewShift = doF . liftM2 (.) W.greedyView W.shift

eventLogHook = do
	winset <- gets windowset
	title <- maybe (return "") (fmap show . getName) . W.peek $ winset
	let currWs = W.currentTag winset
	let wss = map W.tag $ W.workspaces winset
	let wsStr = join $ map (fmt currWs) $ sort' wss

	io $ appendFile "/tmp/.xmonad-title-log" (take 30 title ++ "\n")
	io $ appendFile "/tmp/.xmonad-workspace-log" ("%{B#3949ab F#f5f5f5}"
		++ wsStr ++ "%{B- F-}\n")

	where fmt currWs ws
		| currWs == ws = "%{R}" ++ ws ++ "%{R}"
		| otherwise    = ws
sort' = sortBy (compare `on` (!! 2))

myStartupHook = do
	spawnOnce "~/.config/polybar/launch.sh"
	setWMName "LG3D"

-- Layouts
myLayout = spacingRaw True (Border 0 0 0 0) True (Border 3 3 3 3) True $
	smartBorders $ avoidStruts $ mouseResize $ windowArrange $
	mkToggle (NBFULL ?? NOBORDERS ?? EOT) $
	(mid ||| grid ||| threeRow ||| threeCol ||| full ||| floats)

mid = ThreeColMid 1 (3/100) (1/2)
grid = mkToggle (single MIRROR) $ SplitGrid XMonad.Layout.GridVariants.L 2 2 (2/3) (16/10) (5/100)
threeRow = Tall 1 (3/100) (1/2)
threeCol = Mirror (Tall 1 (3/100) (1/2))
full = Full
floats = simplestFloat

-- Colors and borders
myNormalBorderColor         = "#292d3e"
myFocusedBorderColor        = "#bbc5ff"
-- Width of the window border in pixels
myBorderWidth               = 2
-- Window focus
myFocusFollowsMouse         = False
myClickJustFocuses          = False

-- Key binds
myModMask = mod4Mask
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
	-- Close focused window
	[ ((modMask, xK_q), kill)
	-- Cycle through the available layout algorithms
	, ((modMask, xK_i), sendMessage NextLayout)
	-- Switch to default layout
	, ((modMask, xK_o), sendMessage FirstLayout)
	-- Reset the layouts on the current workspace to default
	, ((modMask, xK_equal), setLayout $ XMonad.layoutHook conf)
	-- Toggle borderless fullscreen
	, ((modMask, xK_f), sendMessage $ Toggle NBFULL)
	-- Open scratch pad
	, ((modMask, xK_semicolon), namedScratchpadAction myScratchPads "terminal")
	-- Open scratch pad
	, ((modMask, xK_apostrophe), namedScratchpadAction myScratchPads "spotify")

	-- Rotate all windows except master
	, ((modMask, xK_Tab), rotSlavesDown)
	-- Rotate all windows in current stack
	, ((modMask, xK_grave), rotAllDown)
	-- Move focus to the next window
	, ((modMask, xK_j), windows W.focusDown)
	-- Move focus to the previous window
	, ((modMask, xK_k), windows W.focusUp)
	-- Move focus to the master window
	, ((modMask, xK_m), windows W.focusMaster)
	-- Move focus to the last window in history
	, ((modMask, xK_n), nextMatch History (return True))

	-- Swap the focused window with the next window
	, ((modMask .|. shiftMask, xK_j), windows W.swapDown)
	-- Swap the focused window with the previous window
	, ((modMask .|. shiftMask, xK_k), windows W.swapUp)
	-- Swap the focused window and the master window
	, ((modMask .|. shiftMask, xK_m), windows W.swapMaster)
	-- Shrink the master area
	, ((modMask, xK_h), sendMessage Shrink)
	-- Expand the master area
	, ((modMask, xK_l), sendMessage Expand)
	-- Push window back into tiling
	, ((modMask, xK_t), withFocused $ windows . W.sink)
	-- Push all windows back into tiling
	, ((modMask .|. shiftMask, xK_t), sinkAll)
	-- Increment the number of windows in the master area
	, ((modMask, xK_comma), sendMessage (IncMasterN 1))
	-- Decrement the number of windows in the master area.
	, ((modMask, xK_period), sendMessage (IncMasterN (-1)))

	-- Switch to next workspace
	, ((modMask, xK_bracketright), moveTo Next NonEmptyWS)
	-- Switch to prev workspace
	, ((modMask, xK_bracketleft), moveTo Prev NonEmptyWS)
	-- Switch to last workspace
	, ((modMask, xK_b), toggleWS)
	-- Switch to next free workspace
	, ((modMask, xK_minus), moveTo Next EmptyWS)
	-- Shift window to next workspace and follow
	, ((modMask .|. shiftMask, xK_bracketright), shiftToNext >> nextWS)
	-- Shift window to previous workspace and follow
	, ((modMask .|. shiftMask, xK_bracketleft), shiftToPrev >> prevWS)
	-- Copy to all workspaces
	, ((modMask, xK_a ), windows copyToAll)
	-- Remove from all workspaces except current
	, ((modMask, xK_s ), killAllOtherCopies)

	-- Switch to next screen
	, ((modMask, xK_y), nextScreen)
	-- Switch to previous screen
	, ((modMask, xK_u), prevScreen)
	-- Shift to next screen
	, ((modMask .|. shiftMask, xK_y), shiftNextScreen)
	-- Shift to previous screen
	, ((modMask .|. shiftMask, xK_u), shiftPrevScreen)

	-- Enable / disable keyboard window arraning
	, ((modMask, xK_d), sendMessage Arrange)
	, ((modMask .|. controlMask, xK_d), sendMessage DeArrange)
	-- Move windows
	, ((modMask, xK_Up), sendMessage (MoveUp 10))
	, ((modMask, xK_Down), sendMessage (MoveDown 10))
	, ((modMask, xK_Right), sendMessage (MoveRight 10))
	, ((modMask, xK_Left), sendMessage (MoveLeft 10))
	-- Expand windows
	, ((modMask .|. shiftMask, xK_Up), sendMessage (IncreaseUp 10))
	, ((modMask .|. shiftMask, xK_Down), sendMessage (IncreaseDown 10))
	, ((modMask .|. shiftMask, xK_Up), sendMessage (IncreaseUp 10))
	, ((modMask .|. shiftMask, xK_Down), sendMessage (IncreaseDown 10))
	-- Shrink windows
	, ((modMask .|. controlMask, xK_Up), sendMessage (DecreaseUp 10))
	, ((modMask .|. controlMask, xK_Down), sendMessage (DecreaseDown 10))
	, ((modMask .|. controlMask, xK_Up), sendMessage (DecreaseUp 10))
	, ((modMask .|. controlMask, xK_Down), sendMessage (DecreaseDown 10))

	-- Quit xmonad
	, ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess))
	-- Recompile xmonad
	, ((modMask .|. shiftMask, xK_c), spawn "xmonad --recompile")
	-- Restart xmonad
	, ((modMask .|. shiftMask, xK_r), restart "xmonad" True) ]
	++
	-- mod-[1..5] @@ Switch to workspace N
	-- mod-shift-[1..5] @@ Move client to workspace N
	-- mod-control-shift-[1..5] @@ Copy client to workspace N
	[ ((m .|. modMask, k), windows $ f i)
		| (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_5]
		, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask), (copy, shiftMask .|. controlMask)] ]

-- Mouse binds
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
	-- mod-button1, Set the window to floating mode and move by dragging
	[ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
	-- mod-button2, Raise the window to the top of the stack
	, ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
	-- mod-button3, Set the window to floating mode and resize by dragging
	, ((modMask, button3), (\w -> focus w >> mouseResizeWindow w)) ]

-- Scratch pads
myScratchPads  = [ NS "terminal" spawnTerm findTerm floatPad,
	               NS "spotify" spawnSpot findSpot floatPad ]
	where
	spawnTerm  = "kitty --name scratchpad"
	findTerm   = resource =? "scratchpad"
	spawnSpot  = "spotify"
	findSpot   = resource =? "spotify"
	floatPad   = customFloating $ W.RationalRect l t w h
		where
		h = 0.9
		w = 0.9
		t = 0.95 - h
		l = 0.95 - w

-- Defaults
defaults = desktopConfig {
	modMask            = myModMask,
	workspaces         = myWorkspaces,
	keys               = myKeys,
	mouseBindings      = myMouseBindings,
	focusFollowsMouse  = myFocusFollowsMouse,
	clickJustFocuses   = myClickJustFocuses,
	borderWidth        = myBorderWidth,
	normalBorderColor  = myNormalBorderColor,
	focusedBorderColor = myFocusedBorderColor,
	layoutHook         = myLayout,
	manageHook         = myManageHook,
	handleEventHook    = docksEventHook,
	logHook            = historyHook <+> eventLogHook,
	startupHook        = myStartupHook
}

main = do
	forM_ [".xmonad-workspace-log", ".xmonad-title-log"] $ \file -> do
		safeSpawn "mkfifo" ["/tmp/" ++ file]
	xmonad $ ewmh $ defaults
