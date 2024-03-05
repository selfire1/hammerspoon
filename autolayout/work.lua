local work = {}

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

work.start = function()
	print("Starting work layout")
	local whitelisted = { '"Arc"', '"ClickUp"', '"kitty"', '"Slack"' }
	local joinedString = table.concat(whitelisted, " and name is not ")

	local cmd = 'tell application "Finder" to set visible of every process whose visible is true and name is not "Finder" and name is not '
		.. joinedString
		.. " to false"
	hs.osascript.applescript(cmd)
end

return work
