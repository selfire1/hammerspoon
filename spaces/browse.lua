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
  end
}
