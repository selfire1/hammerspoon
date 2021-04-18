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

    -- Open Sorted on tag
    Sorted.openTag(hs.settings.get("secrets").sorted.tags.code)
  end,
  teardown = function()

    -- Quit VSCode
    local toQuit = { 'com.microsoft.VSCode' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

    Brave.killTabsByDomain("github.com|hammerspoon.org")

    -- Open Sorted in today view
    Sorted.today()
  end
}
