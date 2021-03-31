table.insert(Config.spaces, {
  text = "Deep",
  subText = "Work with focus",
  image = hs.image.imageFromAppBundle('com.todoist.mac.Todoist'),
  togglProj = Config.projects.deep,
  blacklist = {'distraction'},
  intentRequired = true,
  funcs = 'deep'
})

Config.funcs.deep = {
  setup = function()
    hs.application.open('com.todoist.mac.Todoist')
  end,
  teardown = function()
    hs.application.find('com.todoist.mac.Todoist'):kill()
    hs.application.find('org.epichrome.eng.ProtonMail'):kill()
  end
}
