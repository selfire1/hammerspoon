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
    hs.application.open('com.todoist.mac.Todoist')
    local todoist = hs.application("Todoist")
    todoist:mainWindow():moveToUnit(hs.layout.maximized)
    end,
    teardown = function ()
        -- Quit Todoist and Brave
    hs.application.find(
        'com.todoist.mac.Todoist',
        'com.brave.Browser'
    ):kill()
    end
}