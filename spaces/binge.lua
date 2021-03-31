table.insert(config.spaces, {
  text = "Binge",
  subText = "Grab some popcorn and enjoy watching videos.",
  image = hs.image.imageFromAppBundle('org.epichrome.eng.YouTube'),
  toggl_proj = config.projects.binge,
  toggl_desc = "Binge",
  whitelist = {'video', 'browser'},
  funcs = 'binge'
})

config.funcs.binge = {
  setup = function()
    hs.urlevent.openURLWithBundle("https://www.youtube.com/feed/subscriptions", "com.brave.Browser")
  end,
  teardown = function()
    brave.killTabsByDomain("youtube.com|netflix.com")
  end
}
