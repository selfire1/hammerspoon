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
    Obsidian.openWorkspace("weekly_review")
    -- Move Obsidian to the left
    local obsidian = hs.application.find("Obsidian")
    obsidian:mainWindow():moveToUnit(hs.layout.left50)

    -- Open Todoist and move it to the right
    hs.application.open('com.todoist.mac.Todoist', 10, 10)
    local todoist = hs.application.find("Todoist")
    todoist:mainWindow():moveToUnit(hs.layout.right50)
  end,
  teardown = function()
    -- Quit Todoist and Obsidian

    local toQuit = { 'com.todoist.mac.Todoist',
      'md.obsidian' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

  end
  }