-- OBSIDIAN
--
-- Some utility functions for controlling Obsidian.

-- Plugins required:
-- * "Obsidian Advanced URI" plugin (https://github.com/Vinzent03/obsidian-advanced-uri)

local module = {}

module.start = function(config_table)
  module.config = config_table
end

module.blank = function()
    -- Open Obsidian
    hs.application.open('md.obsidian', 10, 10)
    -- Open "blank" workspace via "Obsidian Advanced URI" plugin
        
    hs.urlevent.openURLWithBundle("obsidian://advanced-uri?vault=Vault&workspace=blank", 'md.obsidian')
end

module.openWorkspace = function(workspace)
    -- Open Obsidian
    hs.application.open('md.obsidian', 10, 10)
    -- Open workspace via "Obsidian Advanced URI" plugin
    hs.urlevent.openURLWithBundle("obsidian://advanced-uri?vault=Vault&workspace=" .. string.gsub(workspace, "%s+", "%20") , "md.obsidian")
end

module.today = function()
    -- Open Obsidian in blank
    module.blank()
    -- Open today's journal
    hs.urlevent.openURLWithBundle('obsidian://advanced-uri?vault=Vault&daily=true', 'md.obsidian')
end

module.untick = function(url)

    hs.application.open('md.obsidian', 10, 10)
    -- Open workspace via "Obsidian Advanced URI" plugin
    hs.urlevent.openURLWithBundle(url .. "&search=[x]&replace=[%20]" , "md.obsidian")

end


module.openObsUri = function(uri)
    -- Open Obsidian in blank
    module.blank()
    -- Open note
    hs.urlevent.openURLWithBundle(uri, 'md.obsidian')
end

return module
