table.insert(Config.spaces, {
  text = "Pause 🏝️",
  subText = "Pause on screentime. Take a break, walk around.",
  funcs = "pause"
})

Config.funcs.pause = {
    setup = function()
      -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])
        
        spoon.Headspace.stopToggl()
        hs.settings.clear("headspace")
        
        hs.caffeinate.systemSleep()
  end,
  teardown = function()
    hs.application.launchOrFocusByBundleID("com.toggl.toggldesktop.TogglDesktop")
    
  end
}