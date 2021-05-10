table.insert(Config.spaces, {
  text = "Weekly Review",
  subText = "Plan the week.",
  image = hs.image.imageFromAppBundle('com.apple.iCal'),
  togglProj = Config.projects.deep,
  togglDescr = "Weekly Review",
  whitelist = {'writing', 'transfer'},
  funcs = "weekly_review"
})

Config.funcs.weekly_review = {
  setup = function()
    -- Open Obsidian workspace "weekly_review"
    Obsidian.openWorkspace("weekly_review")
    -- Move Obsidian to the left
    local obsidian = hs.application.find("Obsidian")
    obsidian:mainWindow():moveToUnit(hs.layout.left50)

    -- Open Todoist and move it to the right
    local todoist = hs.application.find("com.todoist.mac.Todoist")
    todoist:mainWindow():moveToUnit(hs.layout.right50)

    -- Clean up ticked items
    -- This runs a little script that unticks items in Obsidian:
    -- perl -pi -e 's/\[x\]/[ ]/g' /path/to/file.md
    hs.osascript.applescript(
      [[
        do shell script quoted form of "./Users/Joschua/Documents/Projects/Scripts/untick.sh"
      ]]
    )

    -- Add template to clipboard
    return hs.osascript.applescript(
      [[
set weeknum to do shell script "date +%V"

set the clipboard to "### Week " & weeknum & "
**How did my goals go last week?**
* 

**Which *essential* things am I *under*-investing in?**
* 
*What is an appropriate time?*
* 

**Which *non-essential* thing am I *over*-investing in?**
* 
*What is an appropriate time?*"

display notification "Weekly Reflection in clipboard." with title "Weekly Review"
      ]]
    )
  end,
  teardown = function()
    -- Quit Todoist and Obsidian
    local toQuit = { 'com.todoist.mac.Todoist',
      'md.obsidian', 'com.staysorted.Sorted' }

    for i = 1, #toQuit do
      if hs.application.find(toQuit[i]) ~= nil then
      hs.application.find(toQuit[i]):kill()
    end
    end

  end
  }