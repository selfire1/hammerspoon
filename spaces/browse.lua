table.insert(config.spaces, {
  text = "Browse",
  subText = "Roam around the internet … but not for long!",
  image = hs.image.imageFromAppBundle('com.brave.Browser'),
  togglProj = config.projects.browse,
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
