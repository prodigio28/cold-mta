dataCircles = {}
Circles = {}
Circles_img = {}

function circleHud(id, data)
    if not dataCircles[id] and not Circles[id] then
        dataCircles[id] = data
        Circles[id] = {}
        Circles_img[id] = {}
    end

    Circles[id].tick = nil
    Circles[id].state = false
    Circles[id].value = 100 * 360 / 100

    Circles[id].background = dgsCreateCircle(dataCircles[id].exDatas.outsideRadius, dataCircles[id].exDatas.insideRadius, 360, dataCircles[id].exDatas.backgroundColor)
    Circles[id].main = dgsCreateCircle(dataCircles[id].exDatas.outsideRadius, dataCircles[id].exDatas.insideRadius, 360, dataCircles[id].exDatas.color)

    Circles_img[id].background = dgsCreateImage(dataCircles[id].circle[1], dataCircles[id].circle[2], dataCircles[id].circle[3], dataCircles[id].circle[4], Circles[id].background, false)
    Circles_img[id].main = dgsCreateImage(dataCircles[id].circle[1], dataCircles[id].circle[2], dataCircles[id].circle[3], dataCircles[id].circle[4], Circles[id].main, false)
    Circles_img[id].icon = dgsCreateImage(dataCircles[id].circle[1] + dataCircles[id].circle[3] / 2 - dataCircles[id].exDatas.iconSize[1] / 2, dataCircles[id].circle[2] +dataCircles[id].circle[4] / 2 - dataCircles[id].exDatas.iconSize[2] / 2, dataCircles[id].exDatas.iconSize[1], dataCircles[id].exDatas.iconSize[2], dataCircles[id].exDatas.icon, false)
end

function setValueCircle(id, value)
    local circlesElement = Circles[id]
    if (circlesElement.value ~= value) then
        if (not circlesElement.state) then
            circlesElement.tick = getTickCount()
            circlesElement.state = true
        end
        local progress = (getTickCount() - circlesElement.tick) / 2500
        circlesElement.value = interpolateBetween(circlesElement.value, 0, 0, value, 0, 0, progress, "OutQuad")
        dgsCircleSetAngle(circlesElement.main, circlesElement.value)
        dgsCircleSetDirection(circlesElement.main, false)

        if (progress > 1) then
            circlesElement.tick = nil
            circlesElement.state = false
        end
    elseif (circlesElement.state) then
        circlesElement.state = false
    end
end

function getCircleHudById(id)
    return Circles[id]
end

function destroyCircleHudById(id)
    Circles[id] = nil
    Circles_img[id] = nil
end