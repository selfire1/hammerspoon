table.insert(Config.spaces, {
  text = "Shutdown",
  subText = "Screentime is done, shut down everything.",
  funcs = "shutdown"
})

Config.funcs.shutdown = {
  setup = function()
    spoon.Headspace.stopToggl()
    hs.settings.clear("headspace")

    -- shut down everything
    hs.fnutils.map(Config.applications, function(app)
      hs.fnutils.map(hs.application.applicationsForBundleID(app.bundleID), function(a) a:kill() end)
    end)

    -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])
    
    hs.caffeinate.systemSleep()
  end,
  teardown = function ()
      hs.application.launchOrFocusByBundleID("com.toggl.toggldesktop.TogglDesktop")
  end
}
