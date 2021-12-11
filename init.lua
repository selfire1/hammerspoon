local secrets = require('secrets')
      secrets.start('.secrets.json')

hs.loadSpoon('Hyper')
hs.loadSpoon('Headspace')

Config = require('config')

-- configure spaces for headspace
Config.spaces = {}
Config.funcs = {}
Config.projects = hs.settings.get("secrets").toggl.projects

-- SPACES
-- Deep
require('spaces/deep')
require('spaces/code')
require('spaces/note-taking')
require('spaces/write')
require('spaces/transfer')
-- Shallow
require('spaces/shallow')
require('spaces/browse')
require('spaces/communicate')
require('spaces/social_play')
-- Relax
require('spaces/binge')
require('spaces/play')

-- Events
require('spaces/dnd')
require('spaces/journal')
require('spaces/pause')
require('spaces/weekly_review')
require('spaces/shutdown')

-- Outside
require('spaces/ys_work')

Hyper = spoon.Hyper

-- provide the ability to override config per computer
if (hs.fs.displayName('./local_config.lua')) then
  require('local_config')
end

Hyper
:start(Config)
:setHyperKey('F19')

Movewindows = require('movewindows')
Movewindows.start()

local autolayout = require('autolayout')
      autolayout.start(Config)
      Hyper:bind({}, 'return', nil, autolayout.autoLayout)

Brave = require('brave')
Brave.start(Config)

Obsidian = require('obsidian')
Obsidian.start(Config)

Url = require('urlscheme')
Url.start(Config)

Todoist = require('todoist')
Todoist.start(Config)


spoon.Headspace:start()
               :loadConfig(Config)
               :setTogglKey(hs.settings.get('secrets').toggl.key)

-- Hyper:bind({}, 'space', nil, spoon.Headspace.choose)

-- Hammerspoon bindings
Hyper:bind({}, 'h', nil, function()
hs.application.launchOrFocusByBundleID('org.hammerspoon.Hammerspoon')
end)

Hyper:bind({}, 'r', nil, function()
  hs.reload()
end)

-- Link Wizard: Hyper + K gets me the link wherever
Hyper:bind({}, 'k', nil, function()
  -- If in Obsidian, copy link to note
  if string.find(tostring(hs.window.frontmostWindow()), "Vault") then
    hs.eventtap.keyStroke("cmd", 'k')
    return hs.osascript.applescript(
      [[
      display notification with title "Copied from Obsidian"
    ]]
  )
  else
    -- Copy markdown link and tab title from brave
    return hs.osascript.applescript(
    [[
    tell application "Brave Browser" to set vTitle to (title of active tab of front window)
  tell application "Brave Browser" to set vURL to URL of active tab of front window
  
  display notification vURL with title "Copied from Brave" subtitle vTitle
  
  set the clipboard to "[" & vTitle & "](" & vURL & ")"
    ]]
  )
  end
end)

-- Jump to google hangout or zoom
Hyper:bind({}, 'z', nil, function()
  if hs.application.find('us.zoom.xos') then
    hs.application.launchOrFocusByBundleID('us.zoom.xos')
  else
    brave.jump("meet.google.com|hangouts.google.com.call")
  end
end)

-- Todoist global quick add
Hyper:bind({}, 'u', nil, function()
  hs.eventtap.keyStroke({"cmd", "ctrl"}, "t")
end)

Hyper:bind({}, 'f', nil, function()
  Obsidian.float()
end)

Hyper:bind({}, 'g', nil, function()
  Obsidian.defloat()
end)

-- URL binding
hs.urlevent.bind("move", function(eventName, params)
  Url.move(eventName, params)
end)

Hyper:bind({}, 'w', nil, function()
  local window = hs.window.frontmostWindow()
  hs.alert.show(window)
  window:moveToUnit(hs.layout.left50)
end)