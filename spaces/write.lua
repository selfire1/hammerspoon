local obsidian = require "obsidian"
table.insert(config.spaces, {
  text = "Write",
  subText = "Write deeply. Grow notes.",
  image = hs.image.imageFromAppBundle('md.Obsidian'),
  togglProj = config.projects.write,
  whitelist = {'writing', 'transfer'},
  funcs = "write"
})

config.funcs.write = {
  setup = function()
    -- Open Obsidian workspace "weekly_review"
    obsidian.openWorkspace("blank")
  end,
  teardown = function()
    -- Quit Todoist and Obsidian
    hs.application.find('md.obsidian'):kill()
  end
  }