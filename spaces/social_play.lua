table.insert(Config.spaces, {
  text = "Social Gaming",
  subText = "Adventure with others in vast worlds.",
  image = hs.image.imageFromAppBundle('com.hnc.Discord'),
  togglProj = Config.projects.social_play,
  whitelist = {'gaming', 'messenger', 'voicechat', 'browser', 'notes'},
  funcs = 'social_play'
})

Config.funcs.social_play = {
setup = function()
    -- Open Discord
    hs.application.open('com.hnc.Discord')
end,
teardown = function()
    -- Quit Discord and GeForce NOW
    local toQuit = { 'com.hnc.Discord',
      "GeForceNOW" }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

end
}