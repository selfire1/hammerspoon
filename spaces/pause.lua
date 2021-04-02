table.insert(Config.spaces, {
  text = "Pause 🏝️",
  subText = "Pause on screentime. Take a break, walk around.",
  funcs = "pause"
})

Config.funcs.pause = {
  setup = function()
    spoon.Headspace.stopToggl()
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