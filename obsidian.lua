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

module.float = function()

    if hs.application.find('md.obsidian') == nil then
        hs.application.open('md.obsidian', 10, 10)
    end

    hs.urlevent.openURL('obsidian://advanced-uri?vault=Vault&commandid=quickadd%253Achoice%253Ac9ac21ce-d33a-40e8-9887-c061c51c9277')
end

module.defloat = function()
    hs.urlevent.openURL('obsidian://advanced-uri?vault=Vault&commandid=quickadd%253Achoice%253A083294da-5cd3-4aa3-8318-633b8e37af29')
    hs.application.find('md.obsidian'):hide()
end

return module