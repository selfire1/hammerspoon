table.insert(Config.spaces, {
  text = "Journal",
  subText = "Write about the day.",
  image = hs.image.imageFromAppBundle('md.obsidian'),
  funcs = 'journal',
  togglProj = Config.projects.write,
  togglDescr = "Journaling",
  whitelist = {'writing'}
})

Config.funcs.journal = {
    setup = function ()
        -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '
        ]] .. hs.settings.get("secrets").toggl.projects.code .. [[
          ' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])

        -- Open Obsidian in workspace "blank"
        Obsidian.blank()

        -- Maximise Obsidian
        local obsidian = hs.application.find("Obsidian")
        if obsidian ~= nil then
        obsidian:mainWindow():moveToUnit(hs.layout.maximized)
        end
        
        Obsidian.today()
    end,
    teardown = function ()
        -- Write current headspace in textfile
    hs.osascript.applescript([[
      do shell script "echo '' > '/Users/Joschua/Documents/Projects/Scripts/marvin-toggl-config/current-headspace.txt'" ]])
        
        -- Quit Obsidian
        local toQuit = { 'md.obsidian' }

        for i = 1, #toQuit do
        if hs.application.find(toQuit[i]) ~= nil then
        hs.application.find(toQuit[i]):kill()
        end
        end

        
    end
}