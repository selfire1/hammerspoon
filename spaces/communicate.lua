table.insert(config.spaces, {
  text = "Communicate",
  subText = "Be in touch with others.",
  image = hs.image.imageFromAppBundle('com.apple.iChat'),
  whitelist = {'communication', 'review', 'coding'},
  toggl_proj = config.projects.communicate,
  funcs = 'chat'
})

config.funcs.chat = {
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
    -- Kill a bunch of apps
    hs.application.find('desktop.WhatsApp'):kill()
    hs.application.find('com.facebook.archon'):kill()
    hs.application.find('org.epichrome.eng.Standard Gmail'):kill()
    hs.application.find('org.epichrome.eng.ProtonMail'):kill()
    hs.application.find('com.hnc.Discord'):kill()
    -- Close tabs by domain
    brave.killTabsByDomain("protonmail.com|facebook.com|gmail.com")
end
}