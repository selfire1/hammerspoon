table.insert(Config.spaces, {
  text = "Binge",
  subText = "Grab some popcorn and enjoy watching videos.",
  image = hs.image.imageFromAppBundle('org.epichrome.eng.YouTube'),
  togglProj = Config.projects.binge,
  togglDescr = "Binge",
  whitelist = {'video', 'browser'},
  funcs = 'binge'
})

-- Previous function
-- Config.funcs.binge = {
--   setup = function()
--     -- Open YouTube with Brave
--     hs.urlevent.openURLWithBundle("https://www.youtube.com/feed/subscriptions", "com.brave.Browser")
--   end,
--   teardown = function()
--     -- Close YouTube und Netflix tabs
--     Brave.killTabsByDomain("youtube.com|netflix.com")
--   end
-- }

-- Trying having another chooser
Config.funcs.binge = {
  setup = function ()
    
    hs.chooser.new(function(choice)
    hs.urlevent.openURL(choice.url)
    spoon.Headspace.startTimer(hs.settings.get("secrets").toggl.binge, choice.text)
    end)
    :choices({
      {
        text = 'Netflix',
        url = 'http://netflix.com/'
      },
      {
        text = 'Youtube',
        url = 'https://www.youtube.com/feed/subscriptions/'
      },
    })
    :placeholderText("What do you want to binge?")
    :show()

  end
}


