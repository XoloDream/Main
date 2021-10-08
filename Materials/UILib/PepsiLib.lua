local Lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/0306191026/scripts/main/Materials/UILib/UISource/PepsiLib.lua', true))()
local Window = Lib:CreateWindow({
    Name = "Test",
    Themeable = {
        Image = "rbxassetid://7483871523",
        Credit = false,
    }
})

local Tab = Window:CreateTab({Name = "Tab"})
local Section = Tab:CreateSection({Name = "Section"})

local Label = Section:AddLabel({Name = "Label"})
--Label.Set("Updated Label")

Section:AddToggle({
    Name = "Toggle",
    Enabled = false,
    Keybind = 1,
    Callback = function(state)
        print(state)
    end
})

Section:AddSlider({
    Name = "Slider",
    Min = 0,
    Max = 20,
    Value = 5,
    Textbox = true,
    Callback = function(value)
        print(value)
    end
})

local Table = {1,2,3,4,5,6,7,8,9,10}
local Dropdown = Section:AddSearchBox({
    Name = "Dropdown",
    List = Table,
    Value = Table[1],
    Callback = function(value)
        print(value)
    end
})
--Dropdown:Update(newtable)

local PlayerDropDown = Section:AddDropdown({
    Name = "Select Player",
    Nothing = "No Selection", -- You can optionaly allow the dropdown to have no value.
    List = {1,2,3,4,5,6,7}, -- calls 'Method' (or GetChildren) on specifyed instance
    Callback = function(value)
        print("Selected Player:", value, "| UserID:", value.UserId)
    end
})
--PlayerDropDown:Update(newtable)