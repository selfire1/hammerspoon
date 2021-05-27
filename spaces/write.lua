table.insert(Config.spaces, {
  text = "Write",
  subText = "Write deeply. Grow notes.",
  image = hs.image.imageFromAppBundle('md.Obsidian'),
  togglProj = Config.projects.write,
  whitelist = {'writing', 'transfer'},
  funcs = "write"
})

Config.funcs.write = {
  setup = function()
    -- Open Obsidian workspace "weekly_review"
    Obsidian.openWorkspace("blank")

    -- Open write tag in Todoist
    Todoist.searchAndOpen('write')
  end,
  teardown = function()
    -- Quit Todoist and Obsidian
    local toQuit = { 'md.obsidian' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    Todoist.searchAndOpen('Daily Focus')
    
  end
  }