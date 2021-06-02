table.insert(Config.spaces, {
  text = "Binge",
  subText = "Grab some popcorn and enjoy watching videos.",
  image = hs.image.imageFromAppBundle('org.epichrome.eng.YouTube'),
  togglProj = Config.projects.binge,
  togglDescr = "Binge",
  whitelist = {'video', 'browser'},
  funcs = 'binge',
  intentRequired = true,
  intentSuggestions = hs.settings.get("secrets").intentBinge
})

Config.funcs.binge = {
  setup = function()
    -- Open YouTube with Brave
    hs.urlevent.openURLWithBundle("https://www.youtube.com/feed/subscriptions", "com.brave.Browser")
    -- Open binge tag in Todoist
    
  end,
  teardown = function()
    -- Close YouTube und Netflix tabs
    Brave.killTabsByDomain("youtube.com|netflix.com|disneyplus.com")
    
    

  end
}