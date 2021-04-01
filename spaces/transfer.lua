local obsidian = require "obsidian"
table.insert(config.spaces, {
  text = "Transfer",
  subText = "Outline, transfer and discover new and old ideas.",
  image = hs.image.imageFromAppBundle('com.amazon.Kindle'),
  togglProj = config.projects.write,
  togglDescr = "Transferring Notes from Kindle or Evernote",
  whitelist = {'writing', 'transfer'},
  funcs = "transfer"
})

config.funcs.transfer = {
  setup = function()
    -- Open workspace "Transfer" in Obsidian
    obsidian.openWorkspace("transfer")
    -- Open Obsidian and move to right half
    local obsidian = hs.application("Obsidian")
    obsidian:mainWindow():moveToUnit(hs.layout.right50)
    
    -- Open Kindle and move to left half
    hs.application.open('com.amazon.Kindle', 10, 10)
    local kindle = hs.application("Kindle")
    kindle:mainWindow():moveToUnit(hs.layout.left50)
  end,
  teardown = function()
    -- Quit Kindle and Obsidian
    hs.application.find('com.amazon.Kindle'):kill()
    hs.application.find('md.obsidian'):kill()
  end
  }