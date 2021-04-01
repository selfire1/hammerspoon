local obsidian = require "obsidian"
table.insert(Config.spaces, {
  text = "Weekly Review",
  subText = "Plan the week in Todoist.",
  image = hs.image.imageFromAppBundle('com.apple.iCal'),
  togglProj = Config.projects.deep,
  togglDescr = "Weekly Review",
  whitelist = {'writing', 'transfer'},
  funcs = "weekly_review"
})

Config.funcs.weekly_review = {
  setup = function()
    -- Open Obsidian workspace "weekly_review"
    obsidian.openWorkspace("weekly_review")
    -- Move Obsidian to the left
    local obsidian = hs.application("Obsidian")
    obsidian:mainWindow():moveToUnit(hs.layout.left50)

    -- Open Todoist and move it to the right
    hs.application.open('com.todoist.mac.Todoist', 10, 10)
    local todoist = hs.application("Todoist")
    todoist:mainWindow():moveToUnit(hs.layout.right50)
  end,
  teardown = function()
    -- Quit Todoist and Obsidian
    hs.application.find('com.todoist.mac.Todoist'):kill()
    hs.application.find('md.obsidian'):kill()
  end
  }