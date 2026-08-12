**Oxidelib**

Modern Roblox UI library (Luau) — open source.

**Version:** 1.0.0  
**Platform:** Roblox Executor / Script Hub (requires executor APIs for config, music, tags)
**need update join discord** https://discord.gg/CuCvsRHEb

---

## Main Features

- Window with sidebar, hotbar tabs, and pill-style sub-tabs
- Themes: **Dark**, **Light**, **OLED** + custom themes
- Elements: Toggle, Button, Slider, Dropdown, MultiDropdown, Keybind, Input, ColorPicker, Section, Label, Paragraph, Divider
- Notification system
- Config save/load (JSON via executor file API)
- Tag system (player tags + outline) with presence server
- Admin panel (disconnect clients)
- Built-in Music Player
- Performance panel (FPS graph)
- Profile panel
- Mobile responsive + floating toggle button
- Loading animation

---

## Quick Start

### 1. Load the library

```lua
-- Load from local file (executor)
local Library = loadstring(game:HttpGet("https://getolympushub.xyz/olympus/library/Oxidelib.lua"))()

### 2. Create a window

```lua
local Window = Library:CreateWindow({
    Name            = "My Script",
    BrandSubtitle   = "Oxidelib v" .. Library.Version,
    Logo            = "rbxassetid://114345069590059", -- optional
    LogoZoom        = 2.4,
    Size            = UDim2.fromOffset(700, 490),
    GuiName         = "Oxidelib",
    ToggleKey       = Enum.KeyCode.RightControl, -- optional
    LoadingAnimation = true,
    LoadingText     = "Oxidelib",
    LoadingSubtitle = "HUB",
    LoadingFooter   = "Oxidelib",
})
```

### 3. Tabs & SubTabs

```lua
local Tab = Window:AddTab({
    Name = "Main",
    Icon = "home", -- see Library:GetIcons()
    Subtitle = "Main features",
})

local Sub = Tab:AddSubTab("General")
```

### 4. Elements

```lua
-- Toggle
Sub:AddToggle({
    Name = "Enable Feature",
    Description = "Turns the feature on/off",
    Default = false,
    Flag = "EnableFeature",
    Callback = function(v)
        print("Toggle:", v)
    end,
})

-- Button
Sub:AddButton({
    Name = "Click Me",
    Primary = true,
    Callback = function()
        Library:Notify({ Title = "Hello", Content = "Button pressed!", Type = "success" })
    end,
})

-- Slider
Sub:AddSlider({
    Name = "Speed",
    Min = 0,
    Max = 100,
    Default = 16,
    Suffix = "%",
    Flag = "Speed",
    Callback = function(v) print(v) end,
})

-- Dropdown
Sub:AddDropdown({
    Name = "Mode",
    Options = { "Easy", "Normal", "Hard" },
    Default = "Normal",
    Flag = "Mode",
    Searchable = true,
    Callback = function(v) print(v) end,
})

-- Multi Dropdown
Sub:AddMultiDropdown({
    Name = "Targets",
    Options = { "A", "B", "C" },
    Default = { "A" },
    Flag = "Targets",
    Callback = function(list) print(table.concat(list, ", ")) end,
})

-- Keybind
Sub:AddKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.LeftAlt,
    Flag = "ToggleUI",
    OnPress = function() Window:ToggleUI() end,
})

-- Input
Sub:AddInput({
    Name = "Username",
    Placeholder = "Enter name...",
    Default = "",
    Flag = "Username",
    Callback = function(text) print(text) end,
})

-- Color Picker
Sub:AddColorPicker({
    Name = "ESP Color",
    Default = Color3.fromRGB(167, 200, 244),
    Flag = "ESPColor",
    Callback = function(c) print(c) end,
})

-- Section / Label / Paragraph / Divider
Sub:AddSection({ Name = "Combat" })
Sub:AddLabel({ Text = "Status: Ready" })
Sub:AddParagraph({
    Title = "Info",
    Text = "This is a longer description text that wraps.",
})
Sub:AddDivider()
```

### 5. Notifications

```lua
Window:Notify({
    Title = "Success",
    Content = "Settings saved.",
    Type = "success", -- info | success | warning | error
    Duration = 4,
})

-- Or via Library (uses the last window)
Library:Notify({ Content = "Quick notify", Type = "info" })
```

### 6. Theme

```lua
Library:SetTheme("Dark")   -- Dark | Light | OLED
Library:SetTheme("Light")
Library:GetTheme()         -- returns current theme name
```

### 7. Config (requires writefile / readfile)

```lua
Library:SaveConfig("myconfig")
Library:LoadConfig("myconfig")
Library:ListConfigs()
Library:DeleteConfig("myconfig")

-- Manual
local data = Library:GetConfig()
Library:LoadConfigData(data)

-- Per-flag
Library:GetFlag("Speed", 16)
Library:SetFlag("Speed", 50)
```

### 8. Window API

```lua
Window:SetVisible(true)
Window:Toggle()
Window:SetUIVisible(true)
Window:ToggleUI()
Window:SetProfileVisible(true)
Window:ToggleProfile()
Window:SetLogo("rbxassetid://123")
Window:Destroy()
Library:DestroyAll()
```

### 9. Icons

```lua
local icons = Library:GetIcons()
print(Library:GetIcon("home")) -- rbxassetid://...
-- Icon keys: home, settings, combat, eye, shield, sword, fire, star, player, ...
```

---

## Full Example Script

```lua
local Library = loadstring(game:HttpGet("https://getolympushub.xyz/olympus/library/Oxidelib.lua"))()

local Window = Library:CreateWindow({
    Name = "Example Hub",
    Size = UDim2.fromOffset(700, 490),
    ToggleKey = Enum.KeyCode.RightControl,
})

local Main = Window:AddTab({ Name = "Main", Icon = "home" })
local Gen  = Main:AddSubTab("General")

Gen:AddSection("Settings")
Gen:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Flag = "AutoFarm",
    Callback = function(v)
        -- your logic
    end,
})
Gen:AddSlider({
    Name = "WalkSpeed",
    Min = 16, Max = 200, Default = 16,
    Flag = "WalkSpeed",
    Callback = function(v)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end,
})
Gen:AddButton({
    Name = "Save Config",
    Primary = true,
    Callback = function()
        Library:SaveConfig("default")
        Window:Notify({ Title = "Config", Content = "Saved!", Type = "success" })
    end,
})

-- Load config on start (optional)
pcall(function() Library:LoadConfig("default") end)
```

---

## Executor Notes

| Feature            | Required APIs                                      |
|--------------------|----------------------------------------------------|
| Config save/load   | `writefile`, `readfile`, `makefolder`, `isfile`, `listfiles`, `delfile` |
| Music player       | `listfiles`, `isfolder`, `makefolder`, `getcustomasset` / `getsynasset` |
| Tag system         | `syn.request` / `http.request` / `request`         |
| Safe GUI parenting | `gethui` (optional, falls back to PlayerGui)       |

Without these APIs the UI still works; related features will simply be disabled or show a warning.

---

## File Structure (after extract)

```
Oxidelib/
├── Oxidelib.lua    -- Main library
├── README.md       -- This documentation
└── EXAMPLE.lua     -- Ready-to-copy usage example
```

---

## License / Credit

**Oxidelib** is open source.  
Use responsibly. Intended for script hubs & executors only.
