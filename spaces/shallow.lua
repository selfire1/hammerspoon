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
      -- Open shallow tag in Todoist
    Todoist.searchAndOpen('shallow')
    end,
    teardown = function ()
        -- Quit Todoist and Brave
        local toQuit = { 'com.brave.Browser' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    Todoist.home()

    end
}