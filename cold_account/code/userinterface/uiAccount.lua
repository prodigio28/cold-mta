loadstring(exports.dgs:dgsImportFunction())()
local screenW, screenH = guiGetScreenSize()

local assets = exports.cold_assets

local panelState = "loading"
local panelElements = {
    ["register"] = {
        ["input1"] = "Username",
        ["input2"] = "Password",
        ["input3"] = "RepeatPassword",
        ["button"] = "Register",
    },
    ["login"] = {
        ["input1"] = "Username",
        ["input2"] = "Password",
        ["button"] = "Login",
    }
}

local font_iregular10 = assets:createFont("inter", "regular", 10)

local inputsWidth, inputsHeight = 350, 45
local inputsX, inputsY = screenW / 2 - inputsWidth / 2, screenH / 2 - inputsHeight / 2
local buttonWidth, buttonHeight = 155, 40
local buttonX, buttonY = screenW / 2 - buttonWidth / 2, inputsY + inputsHeight * 2

local alphaLoading, alphaLoading_100, loadingSize = 255, 100, 50
local bgLoadingX, bgLoadingY, loadingX, loadingY = screenW / 2 - loadingSize / 2, screenH / 2 - loadingSize / 2, screenW / 2, screenH / 2

local logoSize = 300
local logoX, logoY = screenW / 2 - logoSize / 2, screenH / 2 - logoSize / 2

local background, backgroundBlur
local backgroundX, backgroundY, backgroundWidth, backgroundHeight = 0, 0, screenW, screenH

local function panelSwitchDelay(panel, time)
    setTimer(function()
        panelSwitch(panel)
    end, time*1000, 1)
end

local function requestByButtons(button)
    if button == "left" then
        local inputs = {}
        if panelState ~= "loading" then
            for index, value in pairs(panelElements[panelState]) do
                if index ~= "button" then
                    inputs[value] = dgsGetText(assets:getInputById(value))
                end
            end
        end
        if panelState == "register" and source == assets:getButtonById("Register") then
            panelSwitch("wait")
            local username, pass, auth = inputs["Username"], inputs["Password"], inputs["RepeatPassword"]
            local characters = {string.len(username), string.len(pass)}
            if username ~= "" and pass ~= "" and auth ~= "" and username ~= " " and pass ~= " " and auth ~= " " then
                if auth == pass then
                    if characters[1] >= 4 and characters[2] >= 4 then
                        setTimer(function()
                            triggerServerEvent("cold:register", resourceRoot, localPlayer, username, pass, auth)
                        end, 1000, 1)
                    else
                        panelSwitchDelay("register", 1)
                        assets:createMessage("error", "Todos os campos tem que ter no mínimo 4 caractêres.", 5)
                    end
                else
                    panelSwitchDelay("register", 1)
                    assets:createMessage("error", "As senhas não se correspondem.", 5)
                end
            else
                panelSwitchDelay("register", 1)
                assets:createMessage("error", "Preencha todos os campos.", 5)
            end
        elseif panelState == "login" and source == assets:getButtonById("Login") then
            panelSwitch("wait")
            local username, pass = inputs["Username"], inputs["Password"]
            if username ~= "" and pass ~= "" and username ~= " " and pass ~= " " then
                setTimer(function()
                    triggerServerEvent("cold:login", resourceRoot, localPlayer, username, pass)
                end, 1000, 1)
            else
                panelSwitchDelay("login", 1)
                assets:createMessage("error", "Preencha todos os campos.", 5)
            end
        end
    end
end

local function userinterface()
    if not background or not backgroundBlur then
        backgroundBlur = dgsCreateRoundRect(0, false, tocolor(0, 0, 0, 200))
        background = dgsCreateImage(backgroundX, backgroundY, backgroundWidth, backgroundHeight, backgroundBlur, false)
        dgsBlur(background)
    end
    if logoImage then destroyElement(logoImage) end
    if panelState == "wait" then
        logoImage = dgsCreateImage(logoX, logoY, logoSize, logoSize, ":cold_assets/images/utils/main_logo.png", false, _, tocolor(255, 255, 255))
        local loadAnim = 0
        local finishAnim = false
        function loadingAnim()
            dxDrawImage(bgLoadingX, bgLoadingY, loadingSize, loadingSize, ":cold_assets/images/circles/circle1.png", 0, 0, 0, tocolor(155, 155, 155, alphaLoading_100))
            if finishAnim then
                if loadAnim >= 360 then
                    finishAnim = false
                end
                loadAnim = loadAnim + 8
            else
                if loadAnim <= 0 then
                    finishAnim = true
                end
                loadAnim = loadAnim - 8
            end
            dxDrawCircle(loadingX, loadingY, 25, 0, loadAnim, tocolor(255, 255, 255, alphaLoading), tocolor(0, 0, 0, 0))
        end
        addEventHandler("onClientRender", root, loadingAnim)
    elseif panelState == "register" then
        logoImage = dgsCreateImage(logoX, logoY - 50, logoSize, logoSize, ":cold_assets/images/utils/main_logo.png", false, _, tocolor(255, 255, 255))
        assets:createInput("Username", {
            edit = {
                inputsX,
                inputsY - inputsHeight,
                inputsWidth,
                inputsHeight,
                "",
                false, false,
                tocolor(100, 100, 100),
                1, 1,
                "input1.png",
                tocolor(255, 255, 255)
            },
            font = font_iregular10,
            placeHolder = "Usúario",
            placeHolderFont = font_iregular10,
            placeHolderColor = tocolor(100, 100, 100),
            padding = {20, 0},
            caretHeight = 0.3
        })
        assets:createInput("Password", {
            edit = {
                inputsX,
                inputsY,
                inputsWidth,
                inputsHeight,
                "",
                false, false,
                tocolor(100, 100, 100),
                1, 1,
                "input1.png",
                tocolor(255, 255, 255)
            },
            font = font_iregular10,
            placeHolder = "Senha",
            placeHolderFont = font_iregular10,
            placeHolderColor = tocolor(100, 100, 100),
            padding = {20, 0},
            caretHeight = 0.3,
            masked = true
        })
        assets:createInput("RepeatPassword", {
            edit = {
                inputsX,
                inputsY + inputsHeight,
                inputsWidth,
                inputsHeight,
                "",
                false, false,
                tocolor(100, 100, 100),
                1, 1,
                "input1.png",
                tocolor(255, 255, 255)
            },
            font = font_iregular10,
            placeHolder = "Repita sua senha",
            placeHolderFont = font_iregular10,
            placeHolderColor = tocolor(100, 100, 100),
            padding = {20, 0},
            caretHeight = 0.3,
            masked = true
        })
        assets:createButton("Register", {
            edit = {
                buttonX,
                buttonY,
                buttonWidth,
                buttonHeight,
                "CADASTRAR",
                false, false,
                tocolor(255, 255, 255),
                1, 1,
                "button1.png",
                nil, nil,
                tocolor(50, 50, 50),
                tocolor(75, 75, 75), 
                tocolor(100, 100, 100)
            },
            font = font_iregular10
        })
        addEventHandler("onDgsMouseClick", assets:getButtonById("Register"), requestByButtons)
    elseif panelState == "login" then
        logoImage = dgsCreateImage(logoX, logoY, logoSize, logoSize, ":cold_assets/images/utils/main_logo.png", false, _, tocolor(255, 255, 255))
        assets:createInput("Username", {
            edit = {
                inputsX,
                inputsY,
                inputsWidth,
                inputsHeight,
                "",
                false, false,
                tocolor(100, 100, 100),
                1, 1,
                "input1.png",
                tocolor(255, 255, 255)
            },
            font = font_iregular10,
            placeHolder = "Usúario",
            placeHolderFont = font_iregular10,
            placeHolderColor = tocolor(100, 100, 100),
            padding = {20, 0},
            caretHeight = 0.3
        })
        assets:createInput("Password", {
            edit = {
                inputsX,
                inputsY + inputsHeight,
                inputsWidth,
                inputsHeight,
                "",
                false, false,
                tocolor(100, 100, 100),
                1, 1,
                "input1.png",
                tocolor(255, 255, 255)
            },
            font = font_iregular10,
            placeHolder = "Senha",
            placeHolderFont = font_iregular10,
            placeHolderColor = tocolor(100, 100, 100),
            padding = {20, 0},
            caretHeight = 0.3,
            masked = true
        })
        assets:createButton("Login", {
            edit = {
                buttonX,
                buttonY,
                buttonWidth,
                buttonHeight,
                "ENTRAR",
                false, false,
                tocolor(255, 255, 255),
                1, 1,
                "button1.png",
                nil, nil,
                tocolor(50, 140, 225),
                tocolor(10, 100, 185), 
                tocolor(120, 185, 240)
            },
            font = font_iregular10
        })
        addEventHandler("onDgsMouseClick", assets:getButtonById("Login"), requestByButtons)
    end
end

local function hideLoading()
    if alphaLoading >= 255 or alphaLoading > 0 then
        alphaLoading = alphaLoading - 5
    elseif alphaLoading <= 0 then
        alphaLoading = 0
    end
    if alphaLoading_100 >= 100 or alphaLoading_100 > 0 then
        alphaLoading_100 = alphaLoading_100 - 1
    elseif alphaLoading_100 <= 0 then
        alphaLoading_100 = 0
    end
    if alphaLoading_100 <= 0 and alphaLoading <= 0 then
        removeEventHandler("onClientRender", root, loadingAnim)
        removeEventHandler("onClientRender", root, hideLoading)
        alphaLoading = 255
        alphaLoading_100 = 100
    end
end

function panelSwitch(toPanel)
    if toPanel == "wait" then
        local inputs = {}
        local buttons = {}
        for index, value in pairs(panelElements[panelState]) do
            if index ~= "button" then
                inputs[value] = assets:getInputById(value)
                dgsAlphaTo(inputs[value], 0, "Linear", 500)
            else
                buttons[value] = assets:getButtonById(value)
                removeEventHandler("onDgsMouseClick", buttons[value], requestByButtons)
                dgsAlphaTo(buttons[value], 0, "Linear", 500)
            end
        end
        setTimer(function()
            for index, value in pairs(panelElements[panelState]) do
                if index ~= "button" then
                    assets:destroyInputById(value)
                else
                    assets:destroyButtonById(value)
                end
            end
            panelState = "wait"
            userinterface()
        end, 600, 1)
    elseif toPanel == "register" or toPanel == "login" then
        addEventHandler("onClientRender", root, hideLoading)
        setTimer(function()
            panelState = toPanel
            userinterface()
        end, 1000, 1)
    elseif toPanel == "hide" then
        addEventHandler("onClientRender", root, hideLoading)
        setTimer(function()
            if alphaLoading <= 0 then
                if type(background) == "userdata" then destroyElement(background) end
                if type(backgroundBlur) == "userdata" then destroyElement(backgroundBlur) end
                if type(logoImage) == "userdata" then destroyElement(logoImage) end
                showCursor(false)
                triggerServerEvent("cold:loginSpawn", resourceRoot, localPlayer)
            end
        end, 1000, 1)
    end
end
addEvent("cold:loginPanelSwitch", true)
addEventHandler("cold:loginPanelSwitch", root, panelSwitch)

function Initial(panel)
    showCursor(true)
    panelState = "wait"
    userinterface()
    panelSwitchDelay(panel, 1)
end
addEvent("cold:initialLogin", true)
addEventHandler("cold:initialLogin", root, Initial)