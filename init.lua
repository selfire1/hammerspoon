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

local brave = require('brave')
      brave.start(Config)

local obsidian = require('obsidian')
      obsidian.start(Config)


spoon.Headspace:start()
               :loadConfig(Config)
               :setTogglKey(hs.settings.get('secrets').toggl.key)

Hyper:bind({}, 'space', nil, spoon.Headspace.choose)

-- Hammerspoon bindings
hyper:bind({}, 'h', nil, function()
hs.application.launchOrFocusByBundleID('org.hammerspoon.Hammerspoon')
end)

hyper:bind({}, 'r', nil, function()
  hs.reload()
end)

-- Copy markdown link and tab title from brave
hyper:bind({}, 'k', nil, function()
  return hs.osascript.applescript(
  [[
  tell application "Brave Browser" to set vTitle to (title of active tab of front window)
tell application "Brave Browser" to set vURL to URL of active tab of front window

display notification vURL with title "Copied from Brave" subtitle vTitle

set the clipboard to "[" & vTitle & "](" & vURL & ")"
  ]]
)
end)

-- Jump to google hangout or zoom
Hyper:bind({}, 'z', nil, function()
  if hs.application.find('us.zoom.xos') then
    hs.application.launchOrFocusByBundleID('us.zoom.xos')
  else
    brave.jump("meet.google.com|hangouts.google.com.call")
  end
end)
