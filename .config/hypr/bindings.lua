local function send_shortcut_once(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down", window = "activewindow" }))

    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up", window = "activewindow" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.exit())
hl.bind("SUPER + E", hl.dsp.exec_cmd("nautilus"))
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("helium-browser"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("walker --width 644 --maxheight 300 --minheight 300 '$@'"))
hl.bind("SUPER + C", send_shortcut_once("CTRL", "Insert"))
hl.bind("SUPER + V", send_shortcut_once("SHIFT", "Insert"))

-- Workspaces
for workspace = 1, 10 do
  local key = "code:" .. tostring(workspace + 9)
  hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = tostring(workspace) }))
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(workspace) }))
end

-- Window moving
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- System
hl.bind("XF86PowerOff", hl.dsp.exec_cmd("~/.local/bin/btr-system-menu"), { release = true, locked = true })

-- Screenshots
-- Full screen (output)
hl.bind("SUPER + CTRL + 3", hl.dsp.exec_cmd("hyprshot -m output"))

-- Region select
hl.bind("SUPER + CTRL + 4", hl.dsp.exec_cmd("hyprshot -m region"))

-- Window
hl.bind("SUPER + CTRL + 5", hl.dsp.exec_cmd("hyprshot -m window"))
