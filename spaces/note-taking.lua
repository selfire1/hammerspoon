table.insert(Config.spaces, {
  text = "Note taking",
  subText = "Take notes on interesting content.",
  image = hs.image.imageFromAppBundle('com.apple.TextEdit'),
  togglProj = Config.projects.shallow,
  togglDesc = "Taking notes",
  funcs = "notetaking",
})

Config.funcs.notetaking = {
    setup = function ()
    -- Open Obsidian
    hs.application.open('md.obsidian', 10, 10)

    -- Hide Todoist
    local toHide = {'com.todoist.mac.Todoist'}

    for i = 1, #toHide do
      if hs.application.find(toHide[i]) ~= nil then
      hs.application.find(toHide[i]):hide()
    end
    end

    end,
    teardown = function ()
    -- Open todoist homescreen
    Todoist.home()

    end
}