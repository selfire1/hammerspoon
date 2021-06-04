table.insert(Config.spaces, {
  text = "Play",
  subText = "Take a break, head into another world... but not for long.",
  image = hs.image.imageFromAppBundle('com.nvidia.gfnpc.mall'),
  togglProj = Config.projects.play,
  whitelist = {'gaming', 'notes', 'browser', 'notes'},
  funcs = 'play',
  intentRequired = true
})

Config.funcs.play = {
  setup = function ()
    -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '
        ]] .. hs.settings.get("secrets").toggl.projects.play .. [[
          ' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])
  end,
    teardown = function ()
      -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])
        
      -- Quit GeForceNOW
    local toQuit = { 'GeForceNOW' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end
    
    
    
    end
}