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
    -- Open deep tag in Todoist
    Todoist.searchAndOpen('deep')
  end,
  teardown = function()
    -- Quit Todoist and ProtonMail
    local toQuit = { 'org.epichrome.eng.ProtonMail' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    Todoist.openHomeview()
    
  end
}
