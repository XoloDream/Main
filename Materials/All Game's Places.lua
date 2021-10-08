y = 1
local pages = game:GetService("AssetService"):GetGamePlacesAsync()
while true do
     for _,place in pairs(pages:GetCurrentPage()) do
           if y == 1 then 
                x="\nName: " .. place.Name .. "\nPlaceId: " .. place.PlaceId
                y=0
           else
              x=x .. "\n\nName: " .. place.Name .. "\nPlaceId: " .. place.PlaceId
          end
     end
     if pages.IsFinished then
          break
     end
     pages:AdvanceToNextPageAsync()
end

print(x)