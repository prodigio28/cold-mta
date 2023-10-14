function loadUI()
	local componentsHide = {
		"ammo",
		"area_name",
		"armour",
		"breath",
		"clock",
		"health",
		"money",
		"radar", 
		"vehicle_name",
		"weapon",
		"radio",
		"wanted"
	}
	for _, components in ipairs(componentsHide) do
		setPlayerHudComponentVisible(components, false)
	end
	setPedTargetingMarkerEnabled(false)
end
addEventHandler("onClientResourceStart", resourceRoot, loadUI)