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
    -- Activate Obsidian's 'floating' mode
    hs.urlevent.openURL('obsidian://advanced-uri?vault=Vault&commandid=quickadd%253Achoice%253Ac9ac21ce-d33a-40e8-9887-c061c51c9277')
    -- Hide Todoist
    local toHide = {'com.todoist.mac.Todoist'}

    for i = 1, #toHide do
      if hs.application.find(toHide[i]) ~= nil then
      hs.application.find(toHide[i]):hide()
    end
    end

    end,
    teardown = function ()
      -- Open Obsidian in normal mode
      hs.urlevent.openURL('obsidian://advanced-uri?vault=Vault&commandid=quickadd%253Achoice%253A083294da-5cd3-4aa3-8318-633b8e37af29')
    
    -- Open todoist homescreen
    Todoist.home()
    end
}