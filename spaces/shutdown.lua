local toggl = require('toggl')

table.insert(Config.spaces, {
  text = "Shutdown",
  subText = "Screentime is done, shut down everything.",
  funcs = "shutdown"
})

Config.funcs.shutdown = {
  setup = function()
    toggl.stopToggl()
    hs.settings.clear("headspace")

    -- shut down everything
    hs.fnutils.map(Config.applications, function(app)
      hs.fnutils.map(hs.application.applicationsForBundleID(app.bundleID), function(a) a:kill() end)
    end)
    
    hs.caffeinate.systemSleep()
  end,
  teardown = function ()
      hs.application.launchOrFocusByBundleID("com.toggl.toggldesktop.TogglDesktop")
  end
}
