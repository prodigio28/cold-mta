loadstring(exports.dgs:dgsImportFunction())()
local screenW, screenH = guiGetScreenSize()

local assets = exports.cold_assets
local showing = false

local mainWidth, mainHeight = 100, 400
local mainX, mainY = screenW - (mainWidth + 5), screenH - (mainHeight + 5)

local statsToShow = {
    [1] = {
        id = "health",
        outsideRadius = 0.4,
        insideRadius = 0.34,
        icon = ":cold_assets/images/hud/player/health.png",
        iconSize = {18, 18},
        color = tocolor(255, 255, 255),
        backgroundColor = tocolor(100, 100, 100, 155)
    },
    [2] = {
        id = "hunger",
        outsideRadius = 0.4,
        insideRadius = 0.34,
        icon = ":cold_assets/images/hud/player/hunger.png",
        iconSize = {18, 18},
        color = tocolor(255, 255, 255),
        backgroundColor = tocolor(100, 100, 100, 155)
    },
    [3] = {
        id = "thirst",
        outsideRadius = 0.4,
        insideRadius = 0.34,
        icon = ":cold_assets/images/hud/player/thirst.png",
        iconSize = {18, 18},
        color = tocolor(255, 255, 255),
        backgroundColor = tocolor(100, 100, 100, 155)
    },
    [4] = {
        id = "armour",
        outsideRadius = 0.4,
        insideRadius = 0.34,
        icon = ":cold_assets/images/hud/player/armour.png",
        iconSize = {18, 18},
        color = tocolor(255, 255, 255),
        backgroundColor = tocolor(100, 100, 100, 155)
    }
}

local function userinterface()
    for index, value in pairs(statsToShow) do
        if value.id == "armour" then
            assets:createCircleHud( value.id, {
                circle = {
                    mainX + (mainWidth - 110),
                    mainY + (mainHeight - 60) - 1 * 50,
                    50,
                    50
                },
                exDatas = value
            })
        else
            assets:createCircleHud( value.id, {
                circle = {
                    mainX + (mainWidth - 60),
                    mainY + (mainHeight - 60) - index * 50,
                    50,
                    50
                },
                exDatas = value
            })
        end
    end
end

function updateStats()
    local healthP = getElementHealth(localPlayer)
    local armourP = getPedArmor(localPlayer)
    local thirstP = getElementData(localPlayer, "cold:thirst") or 50
    local hungerP = getElementData(localPlayer, "cold:hunger") or 90

    assets:setValueCircleHud("health", healthP * (360 / 100))
    assets:setValueCircleHud("armour", armourP * (360 / 100))
    assets:setValueCircleHud("hunger", hungerP)
    assets:setValueCircleHud("thirst", thirstP)
end

function showHud()
    if not showing then
        showing = true
        userinterface()
        addEventHandler("onClientRender", root, updateStats)
    end
end
addEvent("cold:showHud", true)
addEventHandler("cold:showHud", root, showHud)
--addEventHandler("onClientResourceStart", resourceRoot, showHud)

function hideHud()
    if showing then
        showing = false
        for index, value in pairs(statsToShow) do
            assets:destroyCircleHudById(value.id)
        end
    end
end
addEventHandler("onClientResourceStop", resourceRoot, hideHud)