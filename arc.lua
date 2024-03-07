-- ARC
--
-- Some utility functions for controlling Arc Browser.

local module = {}

module.jump = function(url)
	local prefixedUrl = "https://" .. url
	local function getLocationOfTab(tab)
		local _success, _object, output = hs.osascript.applescript([[
set _output to ""

tell application "Arc"
	set _window_index to 1
	
	repeat with _window in windows
		set _tab_index to 1
		
		repeat with _tab in tabs of _window
			set _url to get URL of _tab
			
			if _url contains "]] .. tab .. [["  then				set _output to (_window_index as string) & " " & (_tab_index as string)								return _output			end if						set _tab_index to _tab_index + 1		end repeat				set _window_index to _window_index + 1	end repeatend tellreturn _output
  ]])
		return _object
	end

	function jumpToTab(position)
		local output = [[
	    set input to "]] .. position .. [["
      set split to words of input
	tell application "Arc"
		tell window (item 1 of split as number)
			tell tab (item 2 of split as number) to select
		end tell
		activate
	end tell
	  ]]
		hs.osascript.applescript(output)
	end

	local position = getLocationOfTab(prefixedUrl)

	if position ~= "" then
		jumpToTab(position)
	else
		hs.osascript.applescript(
			'tell application "Arc" to tell front window to make new tab with properties {URL:"' .. prefixedUrl .. '"}'
		)
		hs.osascript.applescript('tell application "Arc" to activate')
	end
end

return module
