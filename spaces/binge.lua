table.insert(Config.spaces, {
  text = "Binge",
  subText = "Grab some popcorn and enjoy watching videos.",
  image = hs.image.imageFromAppBundle('org.epichrome.eng.YouTube'),
  -- togglProj = Config.projects.binge,
  whitelist = {'video', 'browser'},
  funcs = 'binge'
})

-- Trying having another chooser

Config.funcs.binge = {
  setup = function ()
    
    hs.chooser.new(function(choice)
      -- Trying to get starting timer to work. Different attempts:
      -- spoon.Headspace.startTimer(hs.settings.get("secrets").toggl.projects.binge, choice.text)
      -- local toggl = dofile(hs.spoons.resourcePath('Headspace.spoon/toggl.lua'))
      -- spoon.Headspace.startTimer(hs.settings.get("secrets").toggl.projects.binge, 'test')
      local toggl = require('Spoons/Headspace/toggl')
      toggl.startTimer(hs.settings.get("secrets").toggl.projects.binge, choice.text)

      -- Open URL of choice
      hs.urlevent.openURL(choice.url)
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
      
  end,
  teardown = function()
    -- Close YouTube und Netflix tabs
    Brave.killTabsByDomain("youtube.com|netflix.com")
  end
}


