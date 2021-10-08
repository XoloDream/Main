local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/hoangsalty/Scripts/master/ZypherLIB"))()

local main = library:CreateMain({
    projName = "UILib",
    Resizable = true,
    MaxSize = UDim2.new(0,1000,0,1000),
})

local category = main:CreateCategory("Category")

local section = category:CreateSection("Section")

section:Create("Button", "Button Name",{animated = true},function()
    print("button pressed")
end)
section:Create("Toggle","Toggle Name",{default = true,},function(state)
    print("Current state:", state)
end)
section:Create("Slider","Slider Name",{min = 0, max = 5, default = 0, precise = false,},function(value)
    print(value)
end)
section:Create("TextBox","TextBox Name",{text = "I am a textbox"},function(input)
    print("Input changed to:", input)
end)
section:Create("KeyBind","KeyBind Name",{default = Enum.KeyCode.K},function()
    library:HideUI()
end)
local table = {
    "First",
    "Second",
    "Third",
    "4th",
    "5th",
    "6th"
}
section:Create("DropDown","DropDown Name", {options = table, default = table[1],search = true},function(current)
    print("Selected to:", current)
end)