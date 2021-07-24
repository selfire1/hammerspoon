table.insert(Config.spaces, {
  text = "D&D",
  subText = "Play some good-fun dnd.",
  image = hs.image.imageFromAppBundle('com.apple.Chess'),
  whitelist = {'browser', 'notes', 'communication', 'coding'},
  togglProj = Config.projects.communicate,
  togglDescr = "D&D",
  funcs = 'dnd'
})

Config.funcs.dnd = {
  setup = function ()
    -- Obsidian setup
    Obsidian.openWorkspace("dnd")
    
    -- Browser setup
    hs.urlevent.openURL(hs.settings.get("secrets").dnd.astral)
    hs.urlevent.openURL(hs.settings.get("secrets").dnd.beyond)
    
    -- Discord setup
    hs.application.open("com.hnc.Discord", 10, 10)

    return hs.osascript.applescript(
    [[
    set the clipboard to "]] .. hs.settings.get("secrets").dnd.login .. [["
    display notification with title "Login ready" subtitle "Email for login is ]] .. hs.settings.get("secrets").dnd.email .. [[."
  ]]
  )

    
end,

teardown = function ()
    
    Brave.killTabsByDomain("app.astraltabletop.com|dndbeyond.com")
    -- Quit Discord
    local toQuit = { 'com.hnc.Discord' }
    
    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end
    
  end
}