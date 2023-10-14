
function loadSpawn(player, x, y, z, skinID)
    fadeCamera(player, false, 1)
    setTimer(function()
        local accountPlayer = getPlayerAccount(player)
        local dataPlayer = getAccountData(accountPlayer, "cold:dataPlayer")
        if not dataPlayer then
            spawnPlayer(player, x, y, z, skinID)
        else
            spawnPlayer(player, dataPlayer.lastPosition[1], dataPlayer.lastPosition[2], dataPlayer.lastPosition[3], dataPlayer.lastSkin)
        end
        setCameraTarget(player)
        fadeCamera(player, true, 5)
    end, 1500, 1)
end