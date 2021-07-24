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
    -- Open Brave
    hs.application.open('com.brave.Browser')

    
  end,
  teardown = function ()
    -- Quit Brave
    local toQuit = { 'com.brave.Browser' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    Todoist.openHomeview()
  end
}
