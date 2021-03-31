table.insert(config.spaces, {
  text = "Code",
  subText = "Grow in understanding of coding.",
  image = hs.image.imageFromAppBundle('com.github.atom'),
  launch = {'coding'},
  whitelist = {'coding', 'browser', 'notes', 'tasks'},
  toggl_proj = config.projects.code,
  intentRequired = true,
  funcs = 'code'
})

config.funcs.code = {
  setup = function()
    hs.application.open('com.microsoft.VSCode')
  end,
  teardown = function()
    hs.application.find('com.microsoft.VSCode'):kill()
  end
}
