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
    -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '
        ]] .. hs.settings.get("secrets").toggl.projects.binge .. [[
          ' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])
    -- Open YouTube with Brave
    hs.urlevent.openURLWithBundle("https://www.youtube.com/feed/subscriptions", "com.brave.Browser")
    
  end,
  teardown = function()
    -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])

    -- Close YouTube und Netflix tabs
    Brave.killTabsByDomain("youtube.com|netflix.com|disneyplus.com")
    
    

  end
}