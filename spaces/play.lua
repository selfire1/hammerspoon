table.insert(config.spaces, {
  text = "Play",
  subText = "Take a break, head into another world... but not for long.",
  image = hs.image.imageFromAppBundle('com.nvidia.gfnpc.mall'),
  togglProj = config.projects.play,
  whitelist = {'gaming', 'notes', 'browser', 'notes'},
  funcs = 'play',
  intentRequired = true
})

config.funcs.play = {
    teardown = function ()
        hs.application.find("GeForceNOW"):kill()
    end
}