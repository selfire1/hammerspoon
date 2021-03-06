table.insert(Config.spaces, {
  text = "Communicate",
  subText = "Be in touch with others.",
  image = hs.image.imageFromAppBundle('com.facebook.archon'),
  whitelist = {'communication', 'review', 'coding'},
  togglProj = Config.projects.communicate,
  funcs = 'chat'
})

Config.funcs.chat = {
setup = function()
    -- Open communicate tag in Todoist
    Todoist.searchAndOpen('communicate')
end,
teardown = function()
  -- Quit a bunch of apps
  local toQuit = {
    'desktop.WhatsApp',
    'com.facebook.archon',
    'org.epichrome.eng.Standard Gmail',
    'org.epichrome.eng.ProtonMail',
    'com.hnc.Discord' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    -- Close tabs by domain
    Brave.killTabsByDomain("protonmail.com|facebook.com|gmail.com")

    Todoist.searchAndOpen('Daily Focus')
end
}