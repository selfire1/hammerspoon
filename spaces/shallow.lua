table.insert(Config.spaces, {
  text = "Shallow",
  subText = "Chip away on shallow work.",
  image = hs.image.imageFromAppBundle('com.apple.exposelauncher'),
  togglProj = Config.projects.shallow,
  blacklist = {'distraction', 'coding', 'work'},
  funcs = "shallow",
  intentRequired = true
})

Config.funcs.shallow = {
    setup = function ()
        -- Open Todoist and maximise it
    hs.application.open('com.todoist.mac.Todoist', 10, 10)
    local todoist = hs.application.find("Todoist")
    if todoist ~= nil then
      todoist:mainWindow():moveToUnit(hs.layout.maximized)
    end

    Sorted.openTag(hs.settings.get("secrets").sorted.tags.shallow)

    end,
    teardown = function ()
        -- Quit Todoist and Brave
        local toQuit = { 'com.todoist.mac.Todoist',
        'com.brave.Browser' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    Sorted.today()

    end
}