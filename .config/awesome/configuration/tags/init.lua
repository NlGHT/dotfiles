local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')

local icons = require('theme.icons')

local tags = {
	{
		icon = icons.terminal,
		type = 'terminal',
		default_app = 'alacritty',
		screen = 1
	},
	{
		icon = icons.web_browser,
		type = 'chrome',
		default_app = 'brave',
		screen = 1
	},
	{
		icon = icons.text_editor,
		type = 'code',
        default_app = 'smartgit',
        --default_app = 'alacritty -e nvim',
		screen = 1
	},
	{
		icon = icons.file_manager,
		type = 'files',
		default_app = 'nautilus',
		screen = 1
	},
	{
		icon = icons.multimedia,
		type = 'music',
		default_app = '/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=spotify --file-forwarding com.spotify.Client @@u %U @@',
		screen = 1
	},
	{
		icon = icons.games,
		type = 'game',
		default_app = 'steam',
		screen = 1
	},
	{
		icon = icons.graphics,
		type = 'art',
		default_app = '/home/night/Applications/photopea-desktop/release-builds/photopea-desktop-linux-x64/photopea-desktop',
		screen = 1
	},
	{
		icon = icons.sandbox,
		type = 'reaper',
		default_app = '/opt/REAPER/reaper',
		screen = 1
	},
	{
	  icon = icons.social,
	  type = 'social',
	  default_app = 'discord',
	  screen = 1
	},
	{
		icon = icons.development,
		type = 'any',
		default_app = '/tmp/.mount_UnityHYois2B/AppRun',
		screen = 1
	}
}


tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
		awful.layout.suit.spiral.dwindle,
		awful.layout.suit.tile,
		awful.layout.suit.max
    })
end)


screen.connect_signal("request::desktop_decoration", function(s)
	for i, tag in pairs(tags) do
		awful.tag.add(
			i,
			{
				icon = tag.icon,
				icon_only = true,
				layout = awful.layout.suit.spiral.dwindle,
				gap_single_client = false,
				gap = beautiful.useless_gap,
				screen = s,
				default_app = tag.default_app,
				selected = i == 1
			}
		)
	end
end)


tag.connect_signal(
	'property::layout',
	function(t)
		local currentLayout = awful.tag.getproperty(t, 'layout')
		if (currentLayout == awful.layout.suit.max) then
			t.gap = 0
		else
			t.gap = beautiful.useless_gap
		end
	end
)
