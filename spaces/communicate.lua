table.insert(Config.spaces, {
  text = "Communicate",
  subText = "Be in touch with others.",
  image = hs.image.imageFromAppBundle('com.apple.iChat'),
  whitelist = {'communication', 'review', 'coding'},
  togglProj = Config.projects.communicate,
  funcs = 'chat'
})

Config.funcs.chat = {
setup = function()
    -- Open WhatsApp and move it to the left
    hs.application.open('desktop.WhatsApp')
    local whatsapp = hs.application("WhatsApp")
    whatsapp:mainWindow():moveToUnit(hs.layout.left50)
    -- Open Facebook and move it to the right
    hs.application.open('com.facebook.archon')
    local messenger = hs.application("Messenger")
    messenger:mainWindow():moveToUnit(hs.layout.right50)
end,
teardown = function()
    -- Quit a bunch of apps
    hs.application.find(
    'desktop.WhatsApp', 
    'com.facebook.archon',
    'org.epichrome.eng.Standard Gmail',
    'org.epichrome.eng.ProtonMail',
    'com.hnc.Discord')
    :kill()
    -- Close tabs by domain
    Brave.killTabsByDomain("protonmail.com|facebook.com|gmail.com")
end
}