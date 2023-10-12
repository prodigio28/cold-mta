local function spawnInitial(source)
    spawnPlayer( source, 0, 0, 5, 0 )
end
addEventHandler("onPlayerJoin", root, spawnInitial)