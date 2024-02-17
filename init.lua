hs.loadSpoon("Hyper")
hs.loadSpoon("HyperModal")
Hyper = spoon.Hyper
Hyper:bindHotKeys({ hyperKey = { {}, "F19" } })

Config = {}
Config.applications = require("configApplications")

local function getCurrentFocus()
	-- requires Hammerspoon to have full disk access in System Setings

	local _, focusMode = hs.osascript.javascript([[
// https://gist.github.com/drewkerr/0f2b61ce34e2b9e3ce0ec6a92ab05c18
const app = Application.currentApplication()
app.includeStandardAdditions = true

function getJSON(path) {
	const fullPath = path.replace(/^~/, app.pathTo('home folder'))
	const contents = app.read(fullPath)
	return JSON.parse(contents)
}

function run() {

	let focus = "No focus" // default
	const assert = getJSON("~/Library/DoNotDisturb/DB/Assertions.json").data[0].storeAssertionRecords
	const config = getJSON("~/Library/DoNotDisturb/DB/ModeConfigurations.json").data[0].modeConfigurations

	if (assert) { // focus set manually

		const modeid = assert[0].assertionDetails.assertionDetailsModeIdentifier
		focus = config[modeid].mode.name

	} else { // focus set by trigger

		const date = new Date
		const now = date.getHours() * 60 + date.getMinutes()

		for (const modeid in config) {

			const triggers = config[modeid].triggers.triggers[0]
			if (triggers && triggers.enabledSetting == 2) {

				const start = triggers.timePeriodStartTimeHour * 60 + triggers.timePeriodStartTimeMinute
				const end = triggers.timePeriodEndTimeHour * 60 + triggers.timePeriodEndTimeMinute
				if (start < end) {
					if (now >= start && now < end) {
						focus = config[modeid].mode.name
					}
				} else if (start > end) { // includes midnight
					if (now >= start || now < end) {
						focus = config[modeid].mode.name
					}
				}
			}
		}
	}
	return focus
}

run()
  ]])
	return focusMode
end

hs.fnutils.each(Config.applications, function(appConfig)
	if appConfig.hyperKey then
		-- has hyper key
		Hyper:bind({}, appConfig.hyperKey, function()
			if appConfig.focus then
				local currentFocus = getCurrentFocus()
				if appConfig.focus ~= string.lower(currentFocus) then
					-- has a focus set, which is not the current
					hs.alert.show("Not set in this focus")
					return
				end
			end
			hs.application.launchOrFocusByBundleID(appConfig.bundleID)
		end)
	end
	if appConfig.localBindings then
		hs.fnutils.each(appConfig.localBindings, function(key)
			Hyper:bindPassThrough(key, appConfig.bundleID)
		end)
	end
end)

Movewindows = require("movewindows")
Movewindows.start()

-- Hammerspoon bindings
Hyper:bind({}, "h", nil, function()
	hs.application.launchOrFocusByBundleID("org.hammerspoon.Hammerspoon")
end)

Hyper:bind({}, "r", nil, function()
	hs.reload()
end)

-- Link Wizard: Hyper + K gets me the link wherever
Hyper:bind({}, "k", nil, function()
	-- If in Obsidian, copy link to note
	if string.find(tostring(hs.window.frontmostWindow()), "Vault") then
		hs.eventtap.keyStroke("cmd", "k")
		return hs.osascript.applescript([[
      display notification with title "Copied from Obsidian"
    ]])
	elseif string.find(tostring(hs.window.frontmostWindow()), "Bear") then
		hs.eventtap.keyStroke({ "cmd", "shift", "alt" }, "l")
		return hs.osascript.applescript([[
      display notification with title "Copied link note"
    ]])
	else
		-- Copy markdown link and tab title from arc
		hs.eventtap.keyStroke({ "cmd", "shift", "alt" }, "c")
	end
end)

Hyper:bind({}, "a", nil, function()
	hs.osascript.applescript([[
tell application "Arc"
	tell front window
		tell active space
			tell tab 1 to select
		end tell
	end tell
	activate
end tell
    ]])
end)

-- https://thesweetsetup.com/oopsiethings-applescript-for-things-on-mac/
Hyper:bind({}, "q", nil, function()
	hs.osascript.applescript([[
on appIsRunning(GTDAppName)
	tell application "System Events"
		return (count of (application processes whose name is GTDAppName)) is not 0
	end tell
end appIsRunning

if appIsRunning("Things3") then
	null
else
	tell application "Things3" to run
end if

tell application "Things3" to show quick entry panel
    ]])
end)

-- Jump to google hangout or zoom
Hyper:bind({}, "z", nil, function()
	if hs.application.find("us.zoom.xos") then
		hs.application.launchOrFocusByBundleID("us.zoom.xos")
	else
		if hs.application.find("com.hnc.Discord") then
			hs.application.launchOrFocusByBundleID("com.hnc.Discord")
			-- else
			-- 	Brave.jump("meet.google.com|hangouts.google.com.call|discord.com")
		end
	end
end)

-- https://github.com/dmitriiminaev/Hammerspoon-Yabai/blob/master/.hammerspoon/init.lua
local yabai = function(args, completion)
	local yabai_output = ""
	local yabai_error = ""
	-- Runs in background very fast
	local yabai_task = hs.task.new("/opt/homebrew/bin/yabai", function(err, stdout, stderr)
		print()
	end, function(task, stdout, stderr)
		-- print("stdout:"..stdout, "stderr:"..stderr)
		if stdout ~= nil then
			yabai_output = yabai_output .. stdout
		end
		if stderr ~= nil then
			yabai_error = yabai_error .. stderr
		end
		return true
	end, args)
	if type(completion) == "function" then
		yabai_task:setCallback(function()
			completion(yabai_output, yabai_error)
		end)
	end
	yabai_task:start()
end

HyperModal = spoon.HyperModal
HyperModal
	:start()
	-- my setup
	-- move between windows
	-- TODO: Implement moving focus across diplays
	-- https://github.com/koekeishiya/yabai/issues/526#issuecomment-639899511
	-- alt - h : yabai -m window --focus west || yabai -m display --focus west
	-- alt - j : yabai -m window --focus south || yabai -m display --focus south
	-- alt - k : yabai -m window --focus north || yabai -m display --focus north
	-- alt - l : yabai -m window --focus east || yabai -m display --focus east
	:bind(
		"",
		"h",
		function()
			yabai({ "-m", "window", "--focus", "west" })
			HyperModal:exit()
		end
	)
	:bind("", "j", function()
		yabai({ "-m", "window", "--focus", "south" })
		HyperModal:exit()
	end)
	:bind("", "k", function()
		yabai({ "-m", "window", "--focus", "north" })
		HyperModal:exit()
	end)
	:bind("", "l", function()
		yabai({ "-m", "window", "--focus", "east" })
		HyperModal:exit()
	end)
	-- move window to first (biggest) spot
	:bind("", "1", function()
		yabai({ "-m", "window", "--swap", "first" })
		HyperModal:exit()
	end)
	-- ratios (1/2, 1/3, 1/4)
	:bind("", "2", function()
		yabai({ "-m", "window", "--ratio", "abs:0.5" })
		HyperModal:exit()
	end)
	:bind("", "3", function()
		yabai({ "-m", "window", "--ratio", "abs:0.6" })
		HyperModal:exit()
	end)
	:bind("", "4", function()
		yabai({ "-m", "window", "--ratio", "abs:0.75" })
		HyperModal:exit()
	end)
	-- mirror on the y axis
	:bind("", "v", function()
		yabai({ "-m", "space", "--mirror", "y-axis" })
		HyperModal:exit()
	end)
	-- swap vertical/horizontal split
	:bind("", "x", function()
		yabai({ "-m", "window", "--toggle", "split" })
		HyperModal:exit()
	end)
	-- maximise window
	:bind("", "m", function()
		yabai({ "-m", "window", "--toggle", "zoom-fullscreen" })
		HyperModal:exit()
	end)
	-- move window to the direction (swap)
	:bind({ "ctrl" }, "h", function()
		yabai({ "-m", "window", "--swap", "west" })
		HyperModal:exit()
	end)
	:bind({ "ctrl" }, "j", function()
		yabai({ "-m", "window", "--swap", "south" })
		HyperModal:exit()
	end)
	:bind({ "ctrl" }, "k", function()
		yabai({ "-m", "window", "--swap", "north" })
		HyperModal:exit()
	end)
	:bind({ "ctrl" }, "l", function()
		yabai({ "-m", "window", "--swap", "east" })
		HyperModal:exit()
	end)
	-- move window to the direction (warp) - not sure what the difference is to swap
	:bind({ "alt" }, "h", function()
		yabai({ "-m", "window", "--warp", "west" })
		HyperModal:exit()
	end)
	:bind({ "alt" }, "j", function()
		yabai({ "-m", "window", "--warp", "south" })
		HyperModal:exit()
	end)
	:bind({ "alt" }, "k", function()
		yabai({ "-m", "window", "--warp", "north" })
		HyperModal:exit()
	end)
	:bind({ "alt" }, "l", function()
		yabai({ "-m", "window", "--warp", "east" })
		HyperModal:exit()
	end)
	-- move window to the display
	:bind({ "shift" }, "l", function()
		yabai({ "-m", "window", "--display", "east" })
		HyperModal:exit()
	end)
	:bind({ "shift" }, "h", function()
		yabai({ "-m", "window", "--display", "west" })
		HyperModal:exit()
	end)
	-- currently focused window stacks itself with window under mouse cursor
	:bind("", "s", function()
		yabai({ "-m", "window", "--stack", "mouse" })
		HyperModal:exit()
	end)
	-- balance windows
	:bind("", "e", function()
		yabai({ "-m", "space", "--balance" })
		HyperModal:exit()
	end)
	-- toggle stack / bsp layouts
	:bind({ "shift" }, "b", function()
		yabai({ "-m", "space", "--layout", "stack" })
		HyperModal:exit()
	end)
	:bind("", "b", function()
		yabai({ "-m", "space", "--layout", "bsp" })
		HyperModal:exit()
	end)

Hyper:bind({}, "s", function()
	HyperModal:toggle()
end)

-- yabai can't keep track of Bear, so we need to restart the yabai service whenever Bear is launched
-- https://github.com/koekeishiya/yabai/issues/1410
hs.application.watcher
	.new(function(appName, event, hsapp)
		if event == hs.application.watcher.launched and hsapp:bundleID() == "net.shinyfrog.bear" then
			-- hacky delay - it takes a moment for Bear to actually launched after the launch event fires
			hs.timer.delayed
				.new(1, function()
					-- hs.alert("Reloading yabai")
					yabai({ "--restart-service" })
				end)
				:start()
		end
	end)
	:start()
