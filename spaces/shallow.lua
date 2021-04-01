table.insert(config.spaces, {
  text = "Quick tasks",
  subText = "Chip away on shallow work.",
  image = hs.image.imageFromAppBundle('com.todoist.mac.Todoist'),
  togglProj = config.projects.shallow,
  blacklist = {'distraction', 'coding', 'work'},
  funcs = "shallow",
  intentRequired = true
})

config.funcs.shallow = {
    setup = function ()
        -- Open Todoist and maximise it
    hs.application.open('com.todoist.mac.Todoist')
    local todoist = hs.application("Todoist")
    todoist:mainWindow():moveToUnit(hs.layout.maximized)
    end,
    teardown = function ()
        -- Quit Todoist and Brave
    hs.application.find('com.todoist.mac.Todoist'):kill()
    hs.application.find('com.brave.Browser'):kill()
    end
}