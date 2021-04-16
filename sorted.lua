-- OBSIDIAN
--
-- Some utility functions for controlling Sorted³.

local module = {}

module.start = function(config_table)
  module.config = config_table
end

module.openTag = function(tag)
    -- Open Obsidian
    hs.application.open('com.staysorted.Sorted', 10, 10)
    -- Open workspace via "Obsidian Advanced URI" plugin
    hs.urlevent.openURLWithBundle("sorted://x-callback-url/open?tag=" .. tag, "com.staysorted.Sorted")
end

return module
