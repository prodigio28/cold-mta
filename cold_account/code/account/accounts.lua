local assets = exports.cold_assets
local cold = exports.cold

local function Initial()
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

function requestToRegister(player, username, pass, auth)
    if player and username and pass and auth then
        local newAccount = addAccount(username, pass)
        if (newAccount) then
            assets:createMessage(player, "success", "Conta criada com sucesso.", 5)
            triggerClientEvent(player, "cold:loginPanelSwitch", player, "login")
        else
            assets:createMessage(player, "error", "Ocorreu algum erro tente novamente.", 5)
            triggerClientEvent(player, "cold:loginPanelSwitch", player, "register")
        end
    else
        assets:createMessage(player, "error", "Ocorreu algum erro tente novamente.", 5)
        triggerClientEvent(player, "cold:loginPanelSwitch", player, "register")
    end
end
addEvent("cold:register", true)
addEventHandler("cold:register", root, requestToRegister)

function requestToLogin(player, username, pass)
    if player and username and pass then
        local account = getAccount(username, pass)
        if account then
            logIn(player, account, pass)
            assets:createMessage(player, "success", "Seja muito bem vindo(a) "..getPlayerName(player)..".", 5)
            setTimer(function() 
                triggerClientEvent(player, "cold:loginPanelSwitch", player, "hide")
            end, 1000, 1)
        else
            assets:createMessage(player, "error", "Essa conta não existe.", 5)
            triggerClientEvent(player, "cold:loginPanelSwitch", player, "login")
        end
    end
end
addEvent("cold:login", true)
addEventHandler("cold:login", root, requestToLogin)

function loginSpawn(player)
    cold:loadSpawn(player, 0, 0, 5, 0)
end
addEvent("cold:loginSpawn", true)
addEventHandler("cold:loginSpawn", root, loginSpawn)