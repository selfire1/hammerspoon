-- URL SCHEME
--
-- Some utility functions for controlling Obsidian.

-- Plugins required:
-- * "Obsidian Advanced URI" plugin (https://github.com/Vinzent03/obsidian-advanced-uri)

local module = {}

module.start = function(config_table)
  module.config = config_table
end

module.move = function(eventName, params)
    local direction = params.dir
    local window = hs.window(params.app)

 if direction == "l30"  then
    window:moveToUnit(hs.layout.left30)

elseif direction == "l50" then
    window:moveToUnit(hs.layout.left50)

elseif direction == "l70" then
    window:moveToUnit(hs.layout.left70)

elseif direction == "r30"  then
    window:moveToUnit(hs.layout.right30)

elseif direction == "r50" then
    window:moveToUnit(hs.layout.right50)

elseif direction == "r70" then
    window:moveToUnit(hs.layout.right70)

elseif direction == "max" then
    window:moveToUnit(hs.layout.maximized)

 end
    
end

return module