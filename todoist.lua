-- TODOIST
-- Functions to automate todoist

local module = {}

module.start = function(config_table)
  module.config = config_table
end

module.searchAndOpen = function(query)
    -- Open Todoist
    
    hs.application.open('com.todoist.mac.Todoist', 10, 10)
    -- Enter query
    hs.osascript.applescript([[
        set delayTimer to "0.1"

tell application "System Events"
	activate application "Todoist"
	delay delayTimer
	keystroke "f"
	delay delayTimer
	keystroke "]] .. query .. [["
	delay delayTimer
	key code 125
	delay delayTimer
	key code 36
end tell
    ]])
end

module.openHomeview = function ()
	hs.application.open('com.todoist.mac.Todoist', 10, 10)
	hs.eventtap.keyStroke(nil, "h")
end

return module