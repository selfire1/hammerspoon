table.insert(config.spaces, {
  text = "Journal",
  subText = "Write about the day.",
  image = hs.image.imageFromAppBundle('md.obsidian'),
  funcs = 'journal',
  togglProj = config.projects.writing,
  togglDescr = "Journaling",
  whitelist = {'writing'}
})

config.funcs.journal = {
    setup = function ()
        -- Open Obsidian in workspace "blank"
        -- Commented out because plugin is yet to be released!
        -- obsidian.blank()

        -- Maximise Obsidian
        local obsidian = hs.application("Obsidian")
        obsidian:mainWindow():moveToUnit(hs.layout.maximized)
        
        -- Open today's note via nl-dates plugin URI (https://github.com/argenos/nldates-obsidian)
        obsidian.today()
    end,
    teardown = function ()
        -- Quit Obsidian
        hs.application.find('md.obsidian'):kill()
    end
}