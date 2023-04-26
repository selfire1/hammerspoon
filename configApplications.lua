return {
	["com.todoist.mac.Todoist"] = {
		bundleID = "com.todoist.mac.Todoist",
		tags = { "review", "tasks" },
		layouts = {
			{ nil, 2, hs.layout.maximized },
		},
		whitelisted = true,
		hyperKey = "t",
		local_bindings = { ".", "q" },
	},
	["com.tinyspeck.slackmacgap"] = {
		bundleID = "com.tinyspeck.slackmacgap",
		hyperKey = "g",
	},
	["com.clickup.desktop-app"] = {
		bundleID = "com.clickup.desktop-app",
		hyperKey = "p",
	},

	["com.figma.Desktop"] = {
		bundleID = "com.figma.Desktop",
		hyperKey = "f",
	},
	["com.hnc.Discord"] = {
		bundleID = "com.hnc.Discord",
		hyperKey = "d",
		tags = { "communication", "voicechat", "distraction" },
	},
	["org.mozilla.firefox"] = {
		bundleID = "org.mozilla.firefox",
		tags = { "browser" },
	},
	["company.thebrowser.Browser"] = {
		bundleID = "company.thebrowser.Browser",
		hyperKey = "l",
	},
	["com.brave.Browser"] = {
		bundleID = "com.brave.Browser",
		-- hyperKey = "l",
		tags = { "browser", "research", "transfer" },
	},
	["desktop.WhatsApp"] = {
		bundleID = "desktop.WhatsApp",
		-- hyperKey = "n",
		tags = { "communication", "messenger" },
	},
	["com.facebook.archon"] = {
		bundleID = "com.cacebook.archon",
		-- hyperKey = "m",
		tags = { "communication", "messenger" },
	},
	["com.flexibits.fantastical2.mac"] = {
		bundleID = "com.flexibits.fantastical2.mac",
		hyperKey = "c",
		tags = { "planning", "review", "calendar" },
		whitelisted = true,
	},
	["com.valvesoftware.steam"] = {
		bundleID = "com.valvesoftware.steam",
		tags = { "distraction", "gaming" },
	},
	["com.nvidia.gfnpc.mall"] = {
		bundleID = "com.nvidia.gfnpc.mall",
		tags = { "distraction", "gaming" },
	},
	["com.spotify.client"] = {
		bundleID = "com.spotify.client",
		hyperKey = "s",
	},
	["md.obsidian"] = {
		bundleID = "md.obsidian",
		hyperKey = "o",
		tags = { "research", "notes", "writing" },
	},
	["com.twistapp.mac-sparkle.Twist"] = {
		bundleID = "com.twistapp.mac-sparkle.Twist",
		tags = { "work", "work_twist" },
		rules = {
			{ nil, 2, hs.layout.left50 },
		},
	},
	["com.amazon.Kindle"] = {
		bundleID = "com.amazon.Kindle",
		tags = { "transfer" },
	},
	["com.evernote.Evernote"] = {
		bundleID = "com.evernote.Evernote",
		tags = { "transfer" },
	},
	["com.github.atom"] = {
		bundleID = "com.github.atom",
		tags = { "coding" },
	},
	["org.whispersystems.signal-desktop"] = {
		bundleID = "org.whispersystems.signal-desktop",
		tags = { "distraction", "communication" },
		-- hyperKey = "e",
	},
	["maccatalyst.com.endel.endel"] = {
		bundleID = "maccatalyst.com.endel.endel",
	},
	["com.googlecode.iterm2 "] = {
		bundleID = "com.googlecode.iterm2",
		hyperKey = "y",
	},
	["net.kovidgoyal.kitty"] = {
		bundleID = "net.kovidgoyal.kitty",
		hyperKey = "i",
	},
	-- ["com.microsoft.VSCode"] = {
	-- 	bundleID = "com.microsoft.VSCode",
	-- 	tags = { "coding" },
	-- },
	["com.toggl.toggldesktop.TogglDesktop"] = {
		bundleID = "com.toggl.toggldesktop.TogglDesktop",
		whitelisted = true,
	},
	["com.google.Chrome.app.mdpkiolbdkhdjpekfbkbmhigcaggjagi"] = {
		bundleID = "com.google.Chrome.app.mdpkiolbdkhdjpekfbkbmhigcaggjagi",
		-- hyperKey = "x",
		tags = { "work" },
	},
	["com.staysorted.Sorted"] = {
		bundleID = "com.staysorted.Sorted",
	},
}
