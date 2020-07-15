local awful = require('awful')
local beautiful = require('beautiful')

require('awful.autofocus')

local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
local apps = require('configuration.apps')

-- Key bindings
local globalKeys = awful.util.table.join(

    -- Hotkeys
    awful.key(
        {modkey},
        'F1',
        hotkeys_popup.show_help,
        {description = '| Show help', group = 'awesome'}
    ),
    awful.key({modkey, 'Control'},
        'r',
        awesome.restart,
        {description = '| Reload awesome', group = 'awesome'}
    ),

    awful.key({modkey, 'Control'},
        'q',
        awesome.quit,
        {description = '| Quit awesome', group = 'awesome'}
    ),
    awful.key(
        {altkey, 'Shift'},
        'l',
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = '| Increase master width factor', group = 'layout'}
    ),
    awful.key(
        {altkey, 'Shift'},
        'h',
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = '| Decrease master width factor', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'h',
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {description = '| Increase the number of master clients', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'l',
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = '| Decrease the number of master clients', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Control'},
        'h',
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = '| Increase the number of columns', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Control'},
        'l',
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = '| Decrease the number of columns', group = 'layout'}
    ),
    awful.key(
        {modkey},
        'space',
        function()
            awful.layout.inc(1)
        end,
        {description = '| Select next layout', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'space',
        function()
            awful.layout.inc(-1)
        end,
        {description = '| Select previous layout', group = 'layout'}
    ),
    awful.key(
        {modkey},
        'w',
        awful.tag.viewprev,
        {description = '| View previous tag', group = 'tag'}
    ),

    awful.key(
        {modkey},
        's',
        awful.tag.viewnext,
        {description = '| View next tag', group = 'tag'}
    ),
    awful.key(
        {modkey},
        'Tab',
        awful.tag.history.restore,
        {description = '| Alternate between current and previous tag', group = 'tag'}
    ),
    awful.key({ modkey, "Control" },
        "w",
        function ()
            -- tag_view_nonempty(-1)
            local focused = awful.screen.focused()
            for i = 1, #focused.tags do
                awful.tag.viewidx(-1, focused)
                if #focused.clients > 0 then
                    return
                end
            end
        end,
        {description = '| View previous non-empty tag', group = 'tag'}
    ),
    awful.key({ modkey, "Control" },
        "s",
        function ()
            -- tag_view_nonempty(1)
            local focused =  awful.screen.focused()
            for i = 1, #focused.tags do
                awful.tag.viewidx(1, focused)
                if #focused.clients > 0 then
                    return
                end
            end
        end,
        {description = '| View next non-empty tag', group = 'tag'}
    ),
    awful.key(
        {modkey, 'Shift'},
        "F1",
        function()
            awful.screen.focus_relative(-1)
        end,
        { description = '| Focus the previous screen', group = 'screen'}
    ),
    awful.key(
        {modkey, 'Shift'},
        "F2",
        function()
            awful.screen.focus_relative(1)
        end,
        { description = '| Focus the next screen', group = 'screen'}
    ),
    awful.key(
        {modkey, 'Control'},
        'n',
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = '| Restore minimized', group = 'screen'}
    ),
    awful.key(
        {},
        'XF86MonBrightnessUp',
        function()
            awful.spawn('light -A 10', false)
            awesome.emit_signal('widget::brightness')
            awesome.emit_signal('module::brightness_osd:show', true)
        end,
        {description = '| Increase brightness by 10%', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86MonBrightnessDown',
        function()
            awful.spawn('light -U 10', false)
            awesome.emit_signal('widget::brightness')
            awesome.emit_signal('module::brightness_osd:show', true)
        end,
        {description = '| Decrease brightness by 10%', group = 'hotkeys'}
    ),
    -- ALSA volume control
    awful.key(
        {},
        'XF86AudioRaiseVolume',
        function()
            awful.spawn('amixer -D pulse sset Master 5%+', false)
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
        end,
        {description = '| Increase volume up by 5%', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioLowerVolume',
        function()
            awful.spawn('amixer -D pulse sset Master 5%-', false)
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
        end,
        {description = '| Decrease volume up by 5%', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioMute',
        function()
            awful.spawn('amixer -D pulse set Master 1+ toggle', false)
        end,
        {description = '| Toggle mute', group = 'hotkeys'}
    ),
    awful.key(
        {modkey},
        'i',
        function()
            awful.spawn('pavucontrol', false)
        end,
        {description = '| Audio settings', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioNext',
        function()
            awful.spawn('playerctl --player=spotify next', false)
        end,
        {description = '| Next music', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioPrev',
        function()
            awful.spawn('playerctl --player=spotify previous', false)
        end,
        {description = '| Previous music', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioPlay',
        function()
            awful.spawn('playerctl --player=spotify play-pause', false)
        end,
        {description = '| Play/pause music', group = 'hotkeys'}

    ),
    awful.key(
        {},
        'XF86AudioMicMute',
        function()
            awful.spawn('amixer set Capture toggle', false)
        end,
        {description = '| Mute microphone', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86PowerDown',
        function()
            --
        end,
        {description = '| Shutdown skynet', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86PowerOff',
        function()
            _G.exit_screen_show()
        end,
        {description = '| Toggle exit screen', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86Display',
        function()
            awful.spawn.single_instance('AutoRandR', false)
        end,
        {description = '| Auto X R and R', group = 'hotkeys'}
    ),
    awful.key(
        {modkey},
        '`',
        function()
            _G.toggle_quake()
        end,
        {description = '| Dropdown application', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'm',
        function()
            if awful.screen.focused().musicpop then
                awesome.emit_signal('widget::music', 'keyboard')
            end
        end,
        {description = '| Toggle music widget', group = 'launcher'}
    ),
    awful.key(
        { },
        "Print",
        function ()
            --awful.spawn.easy_async_with_shell(apps.bins.full_screenshot,function() end)
            awful.spawn("flameshot gui", false)
        end,
        {description = '| Take screenshot with flameshot', group = 'Utility'}
    ),
    awful.key(
        {modkey},
        'x',
        function()
            awesome.emit_signal("widget::blur:toggle")
        end,
        {description = '| Toggle blur effects', group = 'Utility'}
    ),
    awful.key(
        {modkey},
        ']',
        function()
            awesome.emit_signal("widget::blur:increase")
        end,
        {description = '| Increase blur effect by 10%', group = 'Utility'}
    ),
    awful.key(
        {modkey},
        '[',
        function()
            awesome.emit_signal("widget::blur:decrease")
        end,
        {description = '| Decrease blur effect by 10%', group = 'Utility'}
    ),
    awful.key(
        {modkey},
        't',
        function()
            awesome.emit_signal("widget::blue_light:toggle")
        end,
        {description = '| Toggle redshift filter', group = 'Utility'}
    ),
    awful.key(
        { 'Control' },
        'Escape',
        function ()
            if screen.primary.systray then
                if not screen.primary.tray_toggler then
                    local systray = screen.primary.systray
                    systray.visible = not systray.visible
                else
                    awesome.emit_signal("widget::systray:toggle")
                end
            end
        end,
        {description = '| Toggle systray visibility', group = 'Utility'}
    ),
    awful.key(
        {modkey},
        'l',
        function()
            awful.spawn(apps.default.lock, false)
        end,
        {description = '| Lock the screen', group = 'Utility'}
    ),
    awful.key(
        {modkey},
        'Return',
        function()
            awful.spawn(apps.default.terminal)
        end,
        {description = '| Open default terminal', group = 'launcher'}
    ),
    awful.key(
        {modkey, "Shift"},
        'e',
        function()
            awful.spawn(apps.default.file_manager)
        end,
        {description = '| Open default file manager', group = 'launcher'}
    ),
    awful.key(
        {modkey, "Shift"},
        'f',
        function()
            awful.spawn(apps.default.web_browser)
        end,
        {description = '| Open default web browser', group = 'launcher'}
    ),
    awful.key(
        {"Control", "Shift"},
        'Escape',
        function()
            awful.spawn(apps.default.terminal .. ' -e ' .. 'htop')
        end,
        {description = '| Open system monitor', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'e',
        function()
            local focused = awful.screen.focused()

            if focused.left_panel then
                focused.left_panel:HideDashboard()
                focused.left_panel.opened = false
            end
            if focused.right_panel then
                focused.right_panel:HideDashboard()
                focused.right_panel.opened = false
            end
            awful.spawn(apps.default.rofiappmenu, false)
        end,
        {description = '| Open application drawer', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'r',
        function()
            local focused = awful.screen.focused()

            if focused.right_panel and focused.right_panel.visible then
                focused.right_panel.visible = false
            end
            screen.primary.left_panel:toggle()
        end,
        {description = '| Open sidebar', group = 'launcher'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'r',
        function()
            local focused = awful.screen.focused()

            if focused.right_panel and focused.right_panel.visible then
                focused.right_panel.visible = false
            end
            screen.primary.left_panel:toggle(true)
        end,
        {description = '| Open sidebar and global search', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'F2',
        function()
            local focused = awful.screen.focused()

            if focused.left_panel and focused.left_panel.opened then
                focused.left_panel:toggle()
            end

            if focused.right_panel then
                if _G.right_panel_mode == 'today_mode' or not focused.right_panel.visible then
                    focused.right_panel:toggle()
                    switch_rdb_pane('today_mode')
                else
                    switch_rdb_pane('today_mode')
                end

                _G.right_panel_mode = 'today_mode'
            end
        end,
        {description = '| Open notification center', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'F3',
        function()
            local focused = awful.screen.focused()

            if focused.left_panel and focused.left_panel.opened then
                focused.left_panel:toggle()
            end

            if focused.right_panel then
                if _G.right_panel_mode == 'notif_mode' or not focused.right_panel.visible then
                    focused.right_panel:toggle()
                    switch_rdb_pane('notif_mode')
                else
                    switch_rdb_pane('notif_mode')
                end

                _G.right_panel_mode = 'notif_mode'
            end
        end,
        {description = '| Open today pane', group = 'launcher'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'x',
        function()
            local currentTag = awful.screen.focused().selected_tag
            awful.spawn(currentTag.default_app)
        end,
        {description = '| Launch default app of current tag', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'p',
        function()
            awful.spawn('peek', false)
        end,
        {description = '| Capture GIF of screen area with peek', group = 'Utility'}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = '| View tag #', group = 'tag'}
        descr_toggle = {description = '| Toggle tag #', group = 'tag'}
        descr_move = {description = '| Move focused client to tag #', group = 'tag'}
        descr_toggle_focus = {description = '| Toggle focused client on tag #', group = 'tag'}
    end
    globalKeys =
        awful.util.table.join(
        globalKeys,
        -- View tag only.
        awful.key(
            {modkey},
            '#' .. i + 9,
            function()
                local focused = awful.screen.focused()
                local tag = focused.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            descr_view
        ),
        -- Toggle tag display.
        awful.key(
            {modkey, 'Control'},
            '#' .. i + 9,
            function()
                local focused = awful.screen.focused()
                local tag = focused.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            descr_toggle
        ),
        -- Move client to tag.
        awful.key(
            {modkey, 'Shift'},
            '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            descr_move
        ),
        -- Toggle tag on focused client.
        awful.key(
            {modkey, 'Control', 'Shift'},
            '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            descr_toggle_focus
        )
    )
end

return globalKeys
