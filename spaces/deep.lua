table.insert(Config.spaces, {
  text = "Deep",
  subText = "Focus deeply.",
  image = hs.image.imageFromAppBundle('com.todoist.mac.Todoist'),
  togglProj = Config.projects.deep,
  blacklist = {'distraction'},
  intentRequired = true,
  funcs = 'deep'
})

Config.funcs.deep = {
  setup = function()
    -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '
        ]] .. hs.settings.get("secrets").toggl.projects.code .. [[
          ' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])
    
  end,
  teardown = function()
    -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])
    -- Quit Todoist and ProtonMail
    local toQuit = { 'org.epichrome.eng.ProtonMail' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    
    
  end
}
