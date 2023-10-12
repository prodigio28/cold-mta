

function Initial()
    fadeCamera(source, true, 5)
    setCameraMatrix(source, 1335.1314697266, -1400.3842773438, 33.302700042725, 1334.1617431641, -1400.3864746094, 33.058326721191, 0, 90)
    local playerSerial = getPlayerSerial(source)
    if playerSerial then
        local accountsInSerial = getAccountsBySerial(playerSerial)
        if #accountsInSerial >= 1 then
            triggerClientEvent(source, "cold:initialLogin", source, "login")
        else
            triggerClientEvent(source, "cold:initialLogin", source, "register")
        end
    end
end
addEventHandler("onPlayerJoin", root, Initial)

function coldRegister(player, username, pass, auth)
    if player and username and pass and auth then
        local newAccount = addAccount(username, pass)
        if (newAccount) then
            print('sucess')
            triggerClientEvent(player, "cold:switchLogin", player, "login")
        else
            print('error')
            triggerClientEvent(player, "cold:switchLogin", player, "register")
        end
    else
        triggerClientEvent(player, "cold:switchLogin", player, "register")
    end
end
addEvent("cold:register", true)
addEventHandler("cold:register", root, coldRegister)

function coldLogin(player, username, pass)
    if player and username and pass then
        local account = getAccount(username, pass)
        if account then
            logIn(player, account, pass)
            triggerClientEvent(player, "cold:switchLogin", player, "hide")
        else
            triggerClientEvent(player, "cold:switchLogin", player, "login")
        end
    end
end
addEvent("cold:login", true)
addEventHandler("cold:login", root, coldLogin)

function coldSpawn(player)
    spawnPlayer(player, 0, 0, 5)
    fadeCamera(player, false, 1)
    setTimer(function()
        setCameraTarget(player)
        fadeCamera(player, true, 5)
    end, 1600, 1)
end
addEvent("cold:spawn", true)
addEventHandler("cold:spawn", root, coldSpawn)