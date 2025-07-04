hs.loadSpoon("Hyper")
Hyper = spoon.Hyper
Hyper:bindHotKeys({ hyperKey = { {}, "F12" } })

Arc = require("arc")

Config = {}
Config.applications = require("configApplications")

hs.fnutils.each(Config.applications, function(appConfig)
	if appConfig.hyperKey then
		-- has hyper key
		Hyper:bind({}, appConfig.hyperKey, function()
			if appConfig.focus or appConfig.focusExclude then
				local currentFocus = Focusmode.getCurrentFocus()
				local currentFocusNormalised = string.lower(currentFocus)

				local isOnBlacklist = appConfig.focusExclude ~= nil and appConfig.focusExclude == currentFocusNormalised
				local isNotOnWhitelist = appConfig.focus ~= nil and appConfig.focus ~= currentFocusNormalised

				if isOnBlacklist or isNotOnWhitelist then
					hs.alert.show("Not set in this focus")
					return
				else
					hs.application.launchOrFocusByBundleID(appConfig.bundleID)
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

Focusmode = require("focusmode")

Yabai = require("yabaiconfig")
Yabai.start()

-- Hyper bindings
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
	Arc.jump("http://localhost:3000")
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
	elseif hs.application.find("com.hnc.Discord") then
		hs.application.launchOrFocusByBundleID("com.hnc.Discord")
	elseif Arc.jump("https://teams.microsoft.com") then
		return true
	end
end)
