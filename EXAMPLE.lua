--[[
    Oxidelib — Example Usage
    Load library dulu, lalu jalankan contoh ini.
]]

local Library = loadstring(readfile("Oxidelib/Oxidelib.lua"))()
-- Alternatif URL:
-- local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/.../Oxidelib.lua"))()

local Window = Library:CreateWindow({
    Name              = "Example Hub",
    BrandSubtitle     = "Oxidelib v" .. Library.Version,
    Size              = UDim2.fromOffset(700, 490),
    ToggleKey         = Enum.KeyCode.RightControl,
    LoadingAnimation  = true,
    LoadingText       = "Oxidelib",
    LoadingSubtitle   = "EXAMPLE",
    LoadingFooter     = "Oxidelib",
})

-- ── Main Tab ──────────────────────────────────────────────────────────────
local MainTab = Window:AddTab({ Name = "Main", Icon = "home", Subtitle = "Core features" })
local General = MainTab:AddSubTab("General")

General:AddSection("Player")
General:AddToggle({
    Name = "Speed Boost",
    Description = "Increase walk speed",
    Default = false,
    Flag = "SpeedBoost",
    Callback = function(enabled)
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = enabled and 50 or 16
        end
    end,
})

General:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 200,
    Default = 16,
    Suffix = "",
    Flag = "WalkSpeed",
    Callback = function(value)
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = value end
    end,
})

General:AddKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.LeftAlt,
    Flag = "UIToggle",
    OnPress = function()
        Window:ToggleUI()
    end,
})

General:AddDivider()
General:AddSection("Actions")
General:AddButton({
    Name = "Notify Success",
    Primary = true,
    Callback = function()
        Window:Notify({
            Title = "Success",
            Content = "Everything works!",
            Type = "success",
            Duration = 3,
        })
    end,
})

General:AddButton({
    Name = "Save Config",
    Callback = function()
        if Library:SaveConfig("example") then
            Window:Notify({ Title = "Config", Content = "Saved as example.json", Type = "success" })
        else
            Window:Notify({ Title = "Config", Content = "Save failed (no file API?)", Type = "error" })
        end
    end,
})

General:AddButton({
    Name = "Load Config",
    Callback = function()
        if Library:LoadConfig("example") then
            Window:Notify({ Title = "Config", Content = "Loaded example.json", Type = "info" })
        else
            Window:Notify({ Title = "Config", Content = "No config found", Type = "warning" })
        end
    end,
})

-- ── Visuals Tab ───────────────────────────────────────────────────────────
local VisTab = Window:AddTab({ Name = "Visuals", Icon = "eye", Subtitle = "ESP & colors" })
local ESP = VisTab:AddSubTab("ESP")

ESP:AddSection("Appearance")
ESP:AddColorPicker({
    Name = "ESP Color",
    Default = Color3.fromRGB(167, 200, 244),
    Flag = "ESPColor",
    Callback = function(color)
        print("ESP color:", color)
    end,
})

ESP:AddDropdown({
    Name = "ESP Mode",
    Options = { "Box", "Highlight", "Name", "Off" },
    Default = "Highlight",
    Flag = "ESPMode",
    Searchable = true,
    Callback = function(mode)
        print("Mode:", mode)
    end,
})

ESP:AddMultiDropdown({
    Name = "Show",
    Options = { "Players", "NPCs", "Items", "Vehicles" },
    Default = { "Players" },
    Flag = "ESPShow",
    Callback = function(list)
        print("Show:", table.concat(list, ", "))
    end,
})

-- ── Settings Tab ──────────────────────────────────────────────────────────
local SetTab = Window:AddTab({ Name = "Settings", Icon = "settings", Subtitle = "Library options" })
local ThemeSub = SetTab:AddSubTab("Theme")

ThemeSub:AddSection("Theme")
ThemeSub:AddDropdown({
    Name = "Theme",
    Options = { "Dark", "Light", "OLED" },
    Default = "Dark",
    Flag = "Theme",
    Callback = function(name)
        Library:SetTheme(name)
        Window:Notify({ Title = "Theme", Content = "Switched to " .. name, Type = "info" })
    end,
})

ThemeSub:AddParagraph({
    Title = "About Oxidelib",
    Text = "Modern UI library for Roblox script hubs. Supports themes, flags, config persistence, tags, admin panel, and music player.",
})

ThemeSub:AddLabel({ Text = "Version: " .. Library.Version })

-- Optional: auto-load last config
pcall(function()
    Library:LoadConfig("example")
end)

Window:Notify({
    Title = "Oxidelib",
    Content = "Example loaded. Press RightControl to toggle UI.",
    Type = "info",
    Duration = 5,
})
