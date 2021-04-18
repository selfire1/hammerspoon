-- OBSIDIAN
--
-- Some utility functions for controlling Sorted³.

local module = {}

module.start = function(config_table)
  module.config = config_table
end

module.openTag = function(tag)
    -- Open Sorted
    hs.application.open('com.staysorted.Sorted', 10, 10)
    -- Open tag with url scheme
    hs.urlevent.openURLWithBundle("sorted://x-callback-url/open?tag=" .. tag, "com.staysorted.Sorted")
end

module.today = function ()
    -- Open Sorted
    hs.application.open('com.staysorted.Sorted', 10, 10)
    -- Open today view with url scheme
    hs.urlevent.openURLWithBundle("sorted://x-callback-url/open?item=today", "com.staysorted.Sorted")
end

return module

