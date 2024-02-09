local movewindows = {}

movewindows.start = function()
	-- Keybindings
	local ctrl_cmd = { "cmd", "ctrl" }
	local cmd_alt = { "cmd", "alt" }
	local shift_ctrl_cmd = { "shift", "cmd", "ctrl" }

	-- Loading Spoons
	hs.loadSpoon("MiroWindowsManager")

	-- Settings Windows Manager
	hs.window.animationDuration = 0
	spoon.MiroWindowsManager:bindHotkeys({
		up = { cmd_alt, "up" },
		right = { cmd_alt, "right" },
		down = { cmd_alt, "down" },
		left = { cmd_alt, "left" },
		fullscreen = { cmd_alt, "m" },
	})

	hs.loadSpoon("WindowScreenLeftAndRight")
	spoon.WindowScreenLeftAndRight.animationDuration = 0
	spoon.WindowScreenLeftAndRight:bindHotkeys({
		screen_left = { ctrl_cmd, "Left" },
		screen_right = { ctrl_cmd, "Right" },
	})
end
return movewindows
