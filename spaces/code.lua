table.insert(config.spaces, {
  text = "Code",
  subText = "Grow in understanding of coding.",
  image = hs.image.imageFromAppBundle('com.github.atom'),
  launch = {'coding'},
  whitelist = {'coding', 'browser', 'notes', 'tasks'},
  togglProj = config.projects.code,
  intentRequired = true,
  funcs = 'code'
})

config.funcs.code = {
  setup = function()
    -- Open VS Code
    hs.application.open('com.microsoft.VSCode')
  end,
  teardown = function()
    -- Quit VS Code
    hs.application.find('com.microsoft.VSCode'):kill()
  end
}
