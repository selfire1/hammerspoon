local toggl = require('toggl')

table.insert(config.spaces, {
  text = "Pause 🏝️",
  subText = "Pause on screentime. Take a break, walk around.",
  funcs = "pause"
})

config.funcs.pause = {
  setup = function()
    toggl.stopToggl()
    hs.settings.clear("headspace")
end
}


Config.funcs.pause = {
    setup = function()
        spoon.Headspace.stopToggl()
        hs.settings.clear("headspace")
        
        hs.caffeinate.systemSleep()
  end,
  teardown = function()
    hs.application.launchOrFocusByBundleID("com.toggl.toggldesktop.TogglDesktop")
  end
}