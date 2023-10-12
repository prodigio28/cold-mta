local components = {"ammo", "area_name", "armour", "breath", "clock", "health", "money", "radar", "vehicle_name", "weapon", "radio", "wanted"}

addEventHandler("onClientResourceStart", resourceRoot,
function ()
	for _, component in ipairs( components ) do
		setPlayerHudComponentVisible( component, false )
	end
    setPedTargetingMarkerEnabled(false)
end)