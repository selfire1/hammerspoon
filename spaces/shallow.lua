table.insert(Config.spaces, {
  text = "Shallow",
  subText = "Chip away on shallow tasks.",
  image = hs.image.imageFromAppBundle('com.apple.exposelauncher'),
  togglProj = Config.projects.shallow,
  blacklist = {'distraction', 'coding', 'work'},
  funcs = "shallow",
  intentRequired = true
})

Config.funcs.shallow = {
    setup = function ()
    -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '
        ]] .. hs.settings.get("secrets").toggl.projects.shallow .. [[
          ' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])
    
    end,
    teardown = function ()
      -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])

        -- Quit Todoist and Brave
        local toQuit = { 'com.brave.Browser' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    

    end
}