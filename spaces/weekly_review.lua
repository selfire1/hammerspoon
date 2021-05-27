table.insert(Config.spaces, {
  text = "Weekly Review",
  subText = "Plan the week.",
  image = hs.image.imageFromAppBundle('com.apple.iCal'),
  togglProj = Config.projects.deep,
  togglDescr = "Weekly Review",
  whitelist = {'writing', 'transfer'},
  funcs = "weekly_review"
})

Config.funcs.weekly_review = {
  setup = function()
    -- Open Todoist and move it to the right
    hs.application.open('com.todoist.mac.Todoist', 10, 10)
    local todoist = hs.application.find("com.todoist.mac.Todoist")
    todoist:mainWindow():moveToUnit(hs.layout.right50)
    Todoist.searchAndOpen('📥 Inbox')

    -- Open Obsidian workspace, move to the left, untick elements
    Obsidian.openWorkspace("weekly_review")
    local obsidian = hs.application.find("Obsidian")
    obsidian:mainWindow():moveToUnit(hs.layout.maximized)
    Obsidian.untick('obsidian://advanced-uri?vault=Vault&filepath=Current%2520Weekly%2520Review.md&heading=Weekly%2520Review')

  end,
  teardown = function()
    -- Quit Todoist and Obsidian
    local toQuit = { 'md.obsidian', 'com.staysorted.Sorted' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    Todoist.searchAndOpen('Daily Focus')

  end
  }