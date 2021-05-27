table.insert(Config.spaces, {
  text = "Code",
  subText = "Grow in understanding of coding.",
  image = hs.image.imageFromAppBundle('com.microsoft.VSCode'),
  whitelist = {'coding', 'browser', 'notes', 'tasks'},
  togglProj = Config.projects.code,
  intentRequired = true,
  intentSuggestions = hs.settings.get("secrets").intentCode,
  funcs = 'code'
})


Config.funcs.code = {
  setup = function ()
    -- Open VS Code
    hs.application.open('com.microsoft.VSCode')

    -- Open code tag in Todoist
    Todoist.searchAndOpen('code')
  end,

  teardown = function ()
        -- Quit VS Code
    local toQuit = { 'com.microsoft.VSCode' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    Todoist.searchAndOpen('Daily Focus')
  end
}