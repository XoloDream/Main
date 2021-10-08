local mt = getrawmetatable(game)
setreadonly(mt, false)

local old_index
old_index = hookmetamethod(game, "__index", function(self, index)
	if not checkcaller() and self == Enum.HumanoidStateType and index == "StrafingNoPhysics" then 
		return
	end
	return old_index(self, index)
end)