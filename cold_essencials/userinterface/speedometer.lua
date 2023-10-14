loadstring(exports.dgs:dgsImportFunction())()
local screenW, screenH = guiGetScreenSize()

local mainWidth, mainHeight = 100, 400
local mainX, mainY = screenW - (mainWidth + 5), screenH - (mainHeight + 5)

local showing = false
local assets = exports.cold_assets
local vehicles = exports.cold_vehicles

local font_iblack20 = assets:createFont("inter", "black", 20)

local alphaVehicle, alphaVehicle_155 = 0, 0

local function userinterface()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if vehicle then
        local RPM = vehicles:getVehicleRPM(vehicle)
        local KMH = math.floor(vehicles:getElementSpeed(vehicle, "km/h"))
        local fuel = getElementData(vehicle, "cold:fuel") or 15
        dxDrawImageSection(mainX - (90), mainY + (mainHeight - 190), 78, 119, 0, 0, 78, 119, ":cold_assets/images/hud/speedometer/bgspeed.png", 0, 0, 0, tocolor(100, 100, 100, alphaVehicle_155))
        dxDrawImageSection(mainX - (90), mainY + (mainHeight - 70), 78, -(119 * (RPM / 9900)), 0, 0, 78, -(119 * (RPM / 9900)), ":cold_assets/images/hud/speedometer/speed.png", 0, 0, 0, tocolor(255, 255, 255, alphaVehicle))
        if KMH > 10 then
            if KMH <= 99 then
                dxDrawText("#4242420#ffffff"..KMH, mainX - (60), mainY + (mainHeight - 140), 0, 0, tocolor(255, 255, 255, alphaVehicle), 1, font_iblack20, "left", "top", false, false, false, true)
            elseif KMH >= 100 then
                dxDrawText(KMH, mainX - (60), mainY + (mainHeight - 140), 0, 0, tocolor(255, 255, 255, alphaVehicle), 1, font_iblack20, "left", "top", false, false, false, true)
            end
        else
            dxDrawText("#42424200#ffffff"..KMH, mainX - (60), mainY + (mainHeight - 140), 0, 0, tocolor(255, 255, 255, alphaVehicle), 1, font_iblack20, "left", "top", false, false, false, true)
        end

        dxDrawImage(mainX - (130), mainY + (mainHeight - 115), 15, 15, ":cold_assets/images/hud/speedometer/iconfuel.png", 0, 0, 0, tocolor(255, 255, 255, alphaVehicle))
        dxDrawImageSection(mainX - (150), mainY + (mainHeight - 140), 72, 73, 0, 0, 72, 73, ":cold_assets/images/hud/speedometer/bgfuel.png", 0, 0, 0, tocolor(100, 100, 100, alphaVehicle_155))
        if fuel <= 15 then
            dxDrawImageSection(mainX - (150), mainY + (mainHeight - 70), 53, -(69 * fuel / 100), 0, 0, 53, -(69 * fuel / 100), ":cold_assets/images/hud/speedometer/showingfuel.png", 0, 0, 0, tocolor(255, 0, 0, alphaVehicle))
        else
            dxDrawImageSection(mainX - (150), mainY + (mainHeight - 70), 53, -(69 * fuel / 100), 0, 0, 53, -(69 * fuel / 100), ":cold_assets/images/hud/speedometer/showingfuel.png", 0, 0, 0, tocolor(255, 255, 255, alphaVehicle))
        end
    end
end

function showSpeedometer(player)
    if not showing and player == localPlayer then
        local function animation()
            if alphaVehicle < 255 then alphaVehicle = alphaVehicle + 10 end
            if alphaVehicle > 255 then alphaVehicle = 255 end
            if alphaVehicle_155 < 155 then if alphaVehicle_155 > 155 then alphaVehicle_155 = 155 end alphaVehicle_155 = alphaVehicle_155 + 10 end
            if alphaVehicle_155 > 155 then alphaVehicle_155 = 155 end

            if alphaVehicle == 255 and alphaVehicle_155 == 155 then
                removeEventHandler("onClientRender", root, animation)
            end
        end
        addEventHandler("onClientRender", root, animation)
        showing = true
    end
end
addEventHandler("onClientVehicleEnter", root, showSpeedometer)

function hideSpeedometer(player)
    if showing and player == localPlayer then
        local function animation()
            if alphaVehicle ~= 0 then alphaVehicle = alphaVehicle - 10 end
            if alphaVehicle < 0 then alphaVehicle = 0 end
            if alphaVehicle_155 ~= 0 then alphaVehicle_155 = alphaVehicle_155 - 10 end
            if alphaVehicle_155 < 0 then alphaVehicle_155 = 0 end

            if alphaVehicle == 0 and alphaVehicle_155 == 0 then
                removeEventHandler("onClientRender", root, animation)
            end
        end
        addEventHandler("onClientRender", root, animation)
        showing = false
    end
end
addEventHandler("onClientVehicleStartExit", root, hideSpeedometer)

function Initial()
    addEventHandler("onClientRender", root, userinterface)
end
addEventHandler("onClientResourceStart", resourceRoot, Initial)