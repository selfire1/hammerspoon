hs.loadSpoon("Hyper")
Hyper = spoon.Hyper
Hyper:bindHotKeys({ hyperKey = { {}, "F19" } })

Config = {}
Config.applications = require("configApplications")

hs.fnutils.each(Config.applications, function(appConfig)
	if appConfig.hyperKey then
		Hyper:bind({}, appConfig.hyperKey, function()
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

Brave = require("brave")
Brave.start(Config)

Obsidian = require("obsidian")
Obsidian.start(Config)

Url = require("urlscheme")
Url.start(Config)

Todoist = require("todoist")
Todoist.start(Config)

Hyper:bind({}, "space", nil, function()
	hs.eventtap.keyStroke("ctrl", "b")
end)

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
		-- Copy markdown link and tab title from brave
		return hs.osascript.applescript([[
    tell application "Brave Browser" to set vTitle to (title of active tab of front window)
  tell application "Brave Browser" to set vURL to URL of active tab of front window
  
  display notification vURL with title "Copied from Brave" subtitle vTitle
  
  set the clipboard to "[" & vTitle & "](" & vURL & ")"
    ]])
	end
end)

-- Jump to google hangout or zoom
Hyper:bind({}, "z", nil, function()
	if hs.application.find("us.zoom.xos") then
		hs.application.launchOrFocusByBundleID("us.zoom.xos")
	else
		if hs.application.find("com.hnc.Discord") then
			hs.application.launchOrFocusByBundleID("com.hnc.Discord")
		else
			Brave.jump("meet.google.com|hangouts.google.com.call|discord.com")
		end
	end
end)

-- Todoist global quick add
Hyper:bind({}, "u", nil, function()
	hs.application.launchOrFocusByBundleID("com.microsoft.VSCode")
	hs.eventtap.keyStroke({ "cmd" }, "s")
	hs.application.launchOrFocusByBundleID("com.brave.Browser")
	hs.eventtap.keyStroke({ "cmd" }, "r")
	hs.application.launchOrFocusByBundleID("com.microsoft.VSCode")
end)

-- URL binding
hs.urlevent.bind("move", function(eventName, params)
	Url.move(eventName, params)
end)

Hyper:bind({}, "w", nil, function()
	local window = hs.window.frontmostWindow()
	hs.alert.show(window)
	window:moveToUnit(hs.layout.left50)
end)
