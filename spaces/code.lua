table.insert(Config.spaces, {
  text = "Code",
  subText = "Grow in understanding of coding.",
  image = hs.image.imageFromAppBundle('com.github.atom'),
  whitelist = {'coding', 'browser', 'notes', 'tasks'},
  togglProj = Config.projects.code,
  intentRequired = true,
  intentSuggestions = hs.settings.get("secrets").intentCode,
  funcs = 'code'
})

Config.funcs.code = {
  setup = function()
    -- Open VS Code
    hs.application.open('com.microsoft.VSCode')
  end,
  teardown = function()

    -- Quit VSCode
    local toQuit = { 'com.microsoft.VSCode' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end
  end
}
