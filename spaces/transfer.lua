table.insert(Config.spaces, {
  text = "Transfer",
  subText = "Outline, transfer and discover new and old ideas.",
  image = hs.image.imageFromAppBundle('com.amazon.Kindle'),
  togglProj = Config.projects.write,
  togglDescr = "Transferring Notes from Kindle or Evernote",
  whitelist = {'writing', 'transfer'},
  funcs = "transfer",
  intentRequired = true
})

Config.funcs.transfer = {
  setup = function()
    -- Open Kindle app hidden
    hs.application.open('com.amazon.Kindle', 20, 20)
    hs.application.find('com.amazon.Kindle'):hide()

    -- Open workspace "Transfer" in Obsidian
    Obsidian.openWorkspace("transfer")
    -- Open Obsidian and move to right half
    local obsidian = hs.application("Obsidian")
    obsidian:mainWindow():moveToUnit(hs.layout.right50)
    
    -- Open kindle notes website
    hs.application.open('com.brave.Browser', 20, 20)
    hs.urlevent.openURLWithBundle("https://read.amazon.com/notebook", 'com.brave.Browser')
    -- Open Kindle extractor plugin
    hs.eventtap.keyStroke({"alt"}, "x")
    -- Move to left
    local brave = hs.application("Brave Browser")
    brave:mainWindow():moveToUnit(hs.layout.left50)
  end,
  teardown = function()
    -- Quit Kindle and Obsidian
    hs.application.find('md.obsidian', 'com.amazon.Kindle'):kill()
    -- Close Brave tab
    Brave.killTabsByDomain("read.amazon.com")
  end
  }