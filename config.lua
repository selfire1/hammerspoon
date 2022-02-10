return {
  applications = {
  ['com.todoist.mac.Todoist'] = {
    bundleID = 'com.todoist.mac.Todoist',
    hyperKey = 't',
    tags = {'review', 'tasks'},
    layouts = {
      {nil, 2, hs.layout.maximized}
    },
    whitelisted = true,
    local_bindings = {'.', 'q'}

  },
  ['com.hnc.Discord'] = {
    bundleID = 'com.hnc.Discord',
    tags = {'communication', 'voicechat', 'distraction'}
  },
  ['org.mozilla.firefox'] = {
    bundleID = 'org.mozilla.firefox',
    tags = {'browser'}
  },
  ['com.brave.Browser'] = {
    bundleID = 'com.brave.Browser',
    hyperKey = 'b',
    tags = {'browser', 'research', 'transfer'}
  },
  ['desktop.WhatsApp'] = {
    bundleID = 'desktop.WhatsApp',
    hyperKey = 'n',
    tags = {'communication','messenger'}
  },
  ['com.facebook.archon'] = {
    bundleID = 'com.facebook.archon',
    hyperKey = 'm',
    tags = {'communication','messenger'}
  },
  ['org.epichrome.eng.YouTube'] = {
    bundleID = 'org.epichrome.eng.YouTube',
    tags = {'video', 'distraction'}
  },
  ['org.epichrome.eng.Standard Gmail'] = {
    bundleID = 'org.epichrome.eng.Standard Gmail',
    tags = {'communication','email'}
  },
  ['com.fluidapp.FluidApp2.try2 Gmail'] = {
    bundleID = 'com.fluidapp.FluidApp2.try2 Gmail',
    tags = {'communication','email'}
  },
  ['com.fluidapp.FluidApp2.YWAM Gmail'] = {
    bundleID = 'com.fluidapp.FluidApp2.YWAM Gmail',
    tags = {'work'},
    hyperKey = 'y',
    rules = {
      {nil, 2, hs.layout.right50}
    }
  },
  ['org.epichrome.eng.ProtonMail'] = {
    bundleID = 'org.epichrome.eng.ProtonMail',
    tags = {'communication','email'}
  },
  ['com.fluidapp.FluidApp2.YS Todoist'] = {
    bundleID = 'com.fluidapp.FluidApp2.YS Todoist',
    hyper = 'y',
    whitelisted = true,
    layouts = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.apple.iCal'] = {
    bundleID = 'com.apple.iCal',
    hyperKey = 'c',
    tags = {'planning', 'review', 'calendar'},
    whitelisted = true,
  },
  ['com.valvesoftware.steam'] = {
    bundleID = 'com.valvesoftware.steam',
    tags = {'distraction', 'gaming'}
  },
  ['com.nvidia.gfnpc.mall'] = {
    bundleID = 'com.nvidia.gfnpc.mall',
    tags = {'distraction', 'gaming'}
  },
  ['com.spotify.client'] = {
    bundleID = 'com.spotify.client',
    hyperKey = 's'
  },
  ['md.obsidian'] = {
    bundleID = 'md.obsidian',
    hyperKey = 'o',
    tags = {'research', 'notes', 'writing'},
  },
  ['com.twistapp.mac-sparkle.Twist'] = {
    bundleID = 'com.twistapp.mac-sparkle.Twist',
    tags = {'work', 'work_twist'},
    rules = {
      {nil, 2, hs.layout.left50}
    }
  },
  ['com.amazon.Kindle'] = {
    bundleID = 'com.amazon.Kindle',
    tags = {'transfer'},
  },
  ['com.evernote.Evernote'] = {
    bundleID = 'com.evernote.Evernote',
    tags = {'transfer'},
  },
  ['com.github.atom'] = {
    bundleID = 'com.github.atom',
    tags = {'coding'}
  },
  ['org.whispersystems.signal-desktop'] = {
    bundleID = 'org.whispersystems.signal-desktop',
    hyperKey = 'e',
    tags = {'distraction', 'communication'}
  },
  ['net.kovidgoyal.kitty'] = {
    bundleID = 'net.kovidgoyal.kitty',
    hyperKey = 'i'
  },
  ['com.microsoft.VSCode'] = {
    bundleID = 'com.microsoft.VSCode',
    hyperKey = 'a',
    tags = {'coding'}
  },
  ['com.toggl.toggldesktop.TogglDesktop'] = {
    bundleID = 'com.toggl.toggldesktop.TogglDesktop',
    hyperKey = 'd',
    whitelisted = true
  },
  ['com.google.Chrome.app.mdpkiolbdkhdjpekfbkbmhigcaggjagi'] = {
    bundleID = 'com.google.Chrome.app.mdpkiolbdkhdjpekfbkbmhigcaggjagi',
    hyperKey = 'x',
    tags = {'work'}
  },
  ['com.staysorted.Sorted'] = {
    bundleID = 'com.staysorted.Sorted'
  }

}
}
--
-- config.domains = {
-- ['twitter.com'] = {
-- url = 'twitter.com',
-- tags = {'distraction', 'socialmedia'}
-- },
-- ['instagram.com'] = {
-- url = 'instagram.com',
-- tags = {'distraction', 'socialmedia'}
-- },
-- ['reddit.com'] = {
-- url = 'reddit.com',
-- tags = {'distraction'}
-- },
-- ['instapaper.com'] = {
-- url = 'instapaper.com',
-- tags = {'distraction', 'reading'}
-- },
-- ['youtube.com'] = {
-- url = 'youtube.com',
-- tags = {'distraction', 'video'}
-- },
-- ['netlix.com'] = {
-- url = 'netflix.com',
-- tags = {'distraction', 'video'}
-- },
-- ['forum.obsidian.md'] = {
-- url = 'forum.obsidian.md',
-- tags = {'distraction', 'communication'}
-- }
-- }
