local yabaiconfig = {}

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

yabaiconfig.start = function()
	hs.loadSpoon("HyperModal")
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
		--
		-- or: alt - right : yabai -m window --focus east || \
		-- yabai -m window --focus $(yabai -m query --windows --display east | \
		-- jq 'map(select(.visible == 1)) | sort_by(.frame.x, .frame.y) | first | .id') || \
		-- from https://github.com/koekeishiya/yabai/issues/953#issuecomment-874406181
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
		-- ratios: 5 for 50%, 4 for 40% (ish) and so on
		:bind("", "8", function()
			yabai({ "-m", "window", "--ratio", "abs:0.8" })
			HyperModal:exit()
		end)
		:bind("", "7", function()
			yabai({ "-m", "window", "--ratio", "abs:0.7" })
			HyperModal:exit()
		end)
		:bind("", "6", function()
			yabai({ "-m", "window", "--ratio", "abs:0.6" })
			HyperModal:exit()
		end)
		:bind("", "5", function()
			yabai({ "-m", "window", "--ratio", "abs:0.5" })
			HyperModal:exit()
		end)
		:bind("", "4", function()
			yabai({ "-m", "window", "--ratio", "abs:0.4" })
			HyperModal:exit()
		end)
		:bind("", "3", function()
			yabai({ "-m", "window", "--ratio", "abs:0.3" })
			HyperModal:exit()
		end)
		:bind("", "2", function()
			yabai({ "-m", "window", "--ratio", "abs:0.2" })
			HyperModal:exit()
		end)
		-- mirror on the y axis
		:bind("", "v", function()
			yabai({ "-m", "space", "--mirror", "y-axis" })
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
		:bind(
			{ "alt" },
			"h",
			function()
				yabai({ "-m", "window", "--warp", "west" })
				HyperModal:exit()
			end
		)
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
end

return yabaiconfig
