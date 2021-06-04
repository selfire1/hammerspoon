table.insert(Config.spaces, {
  text = "Browse",
  subText = "Roam around the internet … but not for long!",
  image = hs.image.imageFromAppBundle('com.brave.Browser'),
  togglProj = Config.projects.browse,
  funcs = 'browse',
  whitelist = {'browser'},
  intentRequired = true
})

Config.funcs.browse = {
  setup = function()
    -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '
        ]] .. hs.settings.get("secrets").toggl.projects.browse .. [[
          ' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])

    -- Open Brave
    hs.application.open('com.brave.Browser')

    
  end,
  teardown = function ()
    -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])
    -- Quit Brave
    local toQuit = { 'com.brave.Browser' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    
  end
}
