hs.loadSpoon("Hyper")
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

-- Brave = require("brave")
-- Brave.start(Config)

-- Obsidian = require("obsidian")
-- Obsidian.start(Config)

-- Url = require("urlscheme")
-- Url.start(Config)

-- Todoist = require("todoist")
-- Todoist.start(Config)

-- Hyper:bind({}, "space", nil, function()
-- 	hs.eventtap.keyStroke("ctrl", "b")
-- end)

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

-- Hyper:bind({}, "t", nil, function()
-- hs.http.asyncGet("https://api.clickup.com/api/v2/team/6920852/time_entries/current",
--     {
--       ["Content-Type"] = "application/json",
--       ["Authorization"] = "pk_60680541_ZVYIQDJVDPGOQTL2X6GWX5JKWC1SH9I2",
--     },
--     function(http_number, body, headers)
--       print(hs.json.decode(body).data.task.custom_id)
--     end
--   )
-- end)

-- focus messenger
-- Hyper:bind({}, "m", nil, function()
-- 	hs.osascript.applescript([[
-- tell application "Arc"
-- 	tell front window
-- 		tell space "Personal"
-- 			tell tab 1 to select
-- 		end tell
-- 	end tell
-- 	activate
-- end tell
--     ]])
-- end)

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

-- Todoist global quick add
-- Hyper:bind({}, "u", nil, function()
-- 	hs.application.launchOrFocusByBundleID("com.microsoft.VSCode")
-- 	hs.eventtap.keyStroke({ "cmd" }, "s")
-- 	hs.application.launchOrFocusByBundleID("com.brave.Browser")
-- 	hs.eventtap.keyStroke({ "cmd" }, "r")
-- 	hs.application.launchOrFocusByBundleID("com.microsoft.VSCode")
-- end)

-- URL binding
-- hs.urlevent.bind("move", function(eventName, params)
-- 	Url.move(eventName, params)
-- end)

-- Hyper:bind({}, "w", nil, function()
-- 	local window = hs.window.frontmostWindow()
-- 	hs.alert.show(window)
-- 	window:moveToUnit(hs.layout.left50)
-- end)
