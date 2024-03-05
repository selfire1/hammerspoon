local autolayout = {}

Focusmode = require("../focusmode")

autolayout.start = function()
	print("Starting autolayout init")
	-- local focus = Focusmode.getCurrentFocus()
	local focus = "work"
	local layout = require("autolayout/" .. focus)
	layout.start()
end

return autolayout
