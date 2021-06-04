table.insert(Config.spaces, {
  text = "Code",
  subText = "Grow in understanding of coding.",
  image = hs.image.imageFromAppBundle('com.microsoft.VSCode'),
  whitelist = {'coding', 'browser', 'notes', 'tasks'},
  togglProj = Config.projects.code,
  intentRequired = true,
  intentSuggestions = hs.settings.get("secrets").intentCode,
  funcs = 'code'
})

Config.funcs.code = {
  setup = function ()
    -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '
        ]] .. hs.settings.get("secrets").toggl.projects.code .. [[
          ' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])

    -- Open VS Code
    hs.application.open('com.microsoft.VSCode')
  end,

  teardown = function ()
    -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])
        
    -- Quit VS Code
    local toQuit = { 'com.microsoft.VSCode' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    
  end
}