local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/hoangsalti/roblox-scripts/main/ProtonLib.lua", true))()
local Window = Lib:Window("World//Zero")
local Tab = Window:Tab("Tab")

local Section = Tab:Section("Section")

local label = Section:Label("Label")
Section:Button("Change label", function()
    label:Update("Changed label")
end)

Section:Toggle("Toggle", false, function(state)
    print(state)
end)

Section:Slider("Slider", {min = 1, default = 1, max = 100},function(value)
    print(value)
end)

Section:Button("Button", function()
    print("Clicked")
end)

Section:Box("Text box","Value", function(value)
    print(value)
end)

local dropdown = Section:SearchBox("Dropdown", {1,2,3,4,5}, nil, function(value)
    print(value)
end)
Section:Button("Change dropdown", function()
    dropdown:Update({"a","b","c"})
end)

Section:Keybind("Keybind", Enum.KeyCode.Delete, function()
    Window.Toggle()
end)