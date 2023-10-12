loadstring(exports.dgs:dgsImportFunction())()
local screenW, screenH = guiGetScreenSize()

local interRegular = dxCreateFont(":cold_assets/fonts/inter/interRegular.ttf", 10)
local interRegular_15 = dxCreateFont(":cold_assets/fonts/inter/interRegular.ttf", 15)

local panelState = "wait"
local assets = exports.cold_assets

local editsWidth = 350
local editsHeight = 45
local editsX = screenW / 2 - editsWidth / 2
local editsY = screenH / 2 - editsHeight / 2

local buttonWidth = 155
local buttonHeight = 40
local buttonX = screenW / 2 - buttonWidth / 2
local buttonY = editsY + editsHeight * 2

local elementsOnPanel = {
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

local function request(button)
    if button == "left" then
        local inputs = {}
        for index, value in pairs(elementsOnPanel[panelState]) do
            if index ~= "button" then
                inputs[value] = dgsGetText(assets:getInputById(value))
            end
        end
        if panelState == "register" and source == assets:getButtonById("Register") then
            switchPanel("wait")
            if inputs['Username'] ~= "" and inputs['Password'] ~= "" and inputs['RepeatPassword'] ~= "" then
                if inputs["RepeatPassword"] == inputs["Password"] then
                    if string.len(inputs['Username']) < 4 and string.len(inputs['Password']) < 4 then
                        print('USUARIO E SENHA PRECISAM SER MAIORES 4 CARACTERES!!!')
                        return
                    end
                    setTimer(function()
                        triggerServerEvent("cold:register", resourceRoot, localPlayer, inputs["Username"], inputs["Password"], inputs["RepeatPassword"])
                    end, 1000, 1)
                else
                    setTimer(function()
                        switchPanel("register")
                    end, 1000, 1)
                    print('Senha não iguais')
                end
            else
                setTimer(function()
                    switchPanel("register")
                end, 1000, 1)
                print('Preencha todos os campos!')
            end
        elseif panelState == "login" and source == assets:getButtonById("Login") then
            switchPanel("wait")
            if inputs["Username"] ~= "" and inputs["Password"] ~= "" then
                setTimer(function()
                    triggerServerEvent("cold:login", resourceRoot, localPlayer, inputs["Username"], inputs["Password"])
                end, 1000, 1)
            else
                setTimer(function()
                    switchPanel("login")
                end, 1000, 1)
                print('Preencha todos os campos!')
            end
        end
    end
end

local bgLoading
local alphaLoading = 255
local logoImage

local function userInterface()
    if not background or not backgroundBlur then
        backgroundBlur = dgsCreateRoundRect(0, false, tocolor(0, 0, 0, 100))
        background = dgsCreateImage(0, 0, screenW, screenH, backgroundBlur, false)
        dgsBlur(background)
    end
    if type(logoImage) == "userdata" then destroyElement(logoImage) end
    if panelState == "register" then
        logoImage = dgsCreateImage(screenW / 2 - 300 / 2, screenH / 2 - 400 / 2, 300, 300, ":cold_assets/images/cold_logo1.png", false, _, tocolor(255, 255, 255))
    else
        logoImage = dgsCreateImage(screenW / 2 - 300 / 2, screenH / 2 - 300 / 2, 300, 300, ":cold_assets/images/cold_logo1.png", false, _, tocolor(255, 255, 255))
    end
    if panelState == "wait" then
        bgLoading = dgsCreateImage(screenW / 2 - 50 / 2, screenH / 2 - 50 / 2, 50, 50, ":cold_assets/images/utils/circle1.png", false, _, tocolor(155, 155, 155, 100))
        local animEnd = 0
        local finish = false
        function loopAnim()
            if finish then
                if animEnd >= 360 then
                    finish = false
                end
                animEnd = animEnd + 8
            else
                if animEnd <= 0 then
                    finish = true
                end
                animEnd = animEnd - 8
            end
            dxDrawCircle(screenW / 2, screenH / 2, 25, 0, animEnd, tocolor(255, 255, 255, alphaLoading), tocolor(0, 0, 0, 0))
        end
        addEventHandler("onClientRender", root, loopAnim)
    elseif panelState == "register" then
        assets:createInput("Username", {
            edit = {
                editsX,
                editsY - editsHeight,
                editsWidth,
                editsHeight,
                "",
                false, false,
                tocolor(100, 100, 100),
                1, 1,
                "background1.png",
                tocolor(255, 255, 255)
            },
            font = interRegular,
            placeHolder = "Usúario",
            placeHolderFont = interRegular,
            placeHolderColor = tocolor(100, 100, 100),
            padding = {20, 0},
            caretHeight = 0.3
        })
        assets:createInput("Password", {
            edit = {
                editsX,
                editsY,
                editsWidth,
                editsHeight,
                "",
                false, false,
                tocolor(100, 100, 100),
                1, 1,
                "background1.png",
                tocolor(255, 255, 255)
            },
            font = interRegular,
            placeHolder = "Senha",
            placeHolderFont = interRegular,
            placeHolderColor = tocolor(100, 100, 100),
            padding = {20, 0},
            caretHeight = 0.3,
            masked = true
        })
        assets:createInput("RepeatPassword", { 
            edit = {
                editsX,
                editsY + editsHeight,
                editsWidth,
                editsHeight,
                "",
                false, false,
                tocolor(100, 100, 100),
                1, 1,
                "background1.png",
                tocolor(255, 255, 255)
            },
            font = interRegular,
            placeHolder = "Repita a senha",
            placeHolderFont = interRegular,
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
                "background1.png",
                nil, nil,
                tocolor(50, 50, 50),
                tocolor(75, 75, 75), 
                tocolor(100, 100, 100)
            },
            font = interRegular
        })
        addEventHandler("onDgsMouseClick", assets:getButtonById("Register"), request)
    elseif panelState == "login" then
        assets:createInput("Username", {
            edit = {
                editsX,
                editsY,
                editsWidth,
                editsHeight,
                "",
                false, false,
                tocolor(100, 100, 100),
                1, 1,
                "background1.png",
                tocolor(255, 255, 255)
            },
            font = interRegular,
            placeHolder = "Usúario",
            placeHolderFont = interRegular,
            placeHolderColor = tocolor(100, 100, 100),
            padding = {20, 0},
            caretHeight = 0.3
        })
        assets:createInput("Password", {
            edit = {
                editsX,
                editsY + editsHeight,
                editsWidth,
                editsHeight,
                "",
                false, false,
                tocolor(100, 100, 100),
                1, 1,
                "background1.png",
                tocolor(255, 255, 255)
            },
            font = interRegular,
            placeHolder = "Senha",
            placeHolderFont = interRegular,
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
                "background1.png",
                nil, nil,
                tocolor(50, 140, 225),
                tocolor(10, 100, 185), 
                tocolor(120, 185, 240)
            },
            font = interRegular
        })
        addEventHandler("onDgsMouseClick", assets:getButtonById("Login"), request)
    end
end

function switchPanel(toPanel)
    iprint(toPanel)
    if toPanel == "wait" then
        if panelState == "register" then
            for index, value in pairs(elementsOnPanel[panelState]) do
                local inputRegister = {}
                local buttonRegister = {}
                if index == "button" then
                    buttonRegister[value] = assets:getButtonById(value)
                    removeEventHandler("onDgsMouseClick", buttonRegister[value], request)
                    dgsAlphaTo(buttonRegister[value], 0, "Linear", 500)
                else
                    inputRegister[value] = assets:getInputById(value)
                    dgsAlphaTo(inputRegister[value], 0, "Linear", 500)
                end
            end
            setTimer(function()
                alphaLoading = 255
                for index, value in pairs(elementsOnPanel[panelState]) do
                    if index == "button" then
                        assets:destroyButtonById(value)
                    else
                        assets:destroyInputById(value)
                    end
                end
                panelState = "wait"
                userInterface()
            end, 600, 1)
        elseif panelState == "login" then
            for index, value in pairs(elementsOnPanel[panelState]) do
                local inputLogin = {}
                local buttonLogin = {}
                if index == "button" then
                    buttonLogin[value] = assets:getButtonById(value)
                    removeEventHandler("onDgsMouseClick", buttonLogin[value], request)
                    dgsAlphaTo(buttonLogin[value], 0, "Linear", 500)
                else
                    inputLogin[value] = assets:getInputById(value)
                    dgsAlphaTo(inputLogin[value], 0, "Linear", 500)
                end
            end
            setTimer(function()
                alphaLoading = 255
                for index, value in pairs(elementsOnPanel[panelState]) do
                    if index == "button" then
                        assets:destroyButtonById(value)
                    else
                        assets:destroyInputById(value)
                    end
                end
                panelState = "wait"
                userInterface()
            end, 600, 1)
        end
    elseif toPanel == "register" then
        if panelState == "wait" then
            dgsAlphaTo(bgLoading, 0, "Linear", 500)  
            local function alphaAnim()
                if alphaLoading >= 255 or alphaLoading > 0 then
                    alphaLoading = alphaLoading - 5
                elseif alphaLoading <= 0 then
                    panelState = toPanel
                    destroyElement(bgLoading)
                    userInterface()
                    removeEventHandler("onClientRender", root, loopAnim)
                    removeEventHandler("onClientRender", root, alphaAnim)
                end
            end
            addEventHandler("onClientRender", root, alphaAnim)
        end
    elseif toPanel == "login" then
        if panelState == "wait" then
            dgsAlphaTo(bgLoading, 0, "Linear", 500)  
            local function alphaAnim()
                if alphaLoading >= 255 or alphaLoading > 0 then
                    alphaLoading = alphaLoading - 5
                elseif alphaLoading <= 0 then
                    panelState = toPanel
                    destroyElement(bgLoading)
                    userInterface()
                    removeEventHandler("onClientRender", root, loopAnim)
                    removeEventHandler("onClientRender", root, alphaAnim)
                end
            end
            addEventHandler("onClientRender", root, alphaAnim)
        end
    elseif toPanel == "hide" then
        for index, value in pairs(elementsOnPanel["login"]) do
            local inputLogin = {}
            local buttonLogin = {}
            if index == "button" then
                buttonLogin[value] = assets:getButtonById(value)
                removeEventHandler("onDgsMouseClick", buttonLogin[value], request)
                dgsAlphaTo(buttonLogin[value], 0, "Linear", 500)
            else
                inputLogin[value] = assets:getInputById(value)
                dgsAlphaTo(inputLogin[value], 0, "Linear", 500)
            end
        end
        setTimer(function()
            alphaLoading = 255
            for index, value in pairs(elementsOnPanel["login"]) do
                if index == "button" then
                    assets:destroyButtonById(value)
                else
                    assets:destroyInputById(value)
                end
            end
            setTimer(function()
                local function alphaAnim()
                    if alphaLoading >= 255 or alphaLoading > 0 then
                        alphaLoading = alphaLoading - 5
                    elseif alphaLoading <= 0 then
                        panelState = toPanel
                        destroyElement(bgLoading)
                        destroyElement(background)
                        destroyElement(backgroundBlur)
                        destroyElement(logoImage)
                        removeEventHandler("onClientRender", root, loopAnim)
                        removeEventHandler("onClientRender", root, alphaAnim)
                        showCursor(false)
                    end
                end
                addEventHandler("onClientRender", root, alphaAnim)
            end, 600, 1)
            triggerServerEvent("cold:spawn", resourceRoot, localPlayer)
        end, 600, 1)
    end
end
addEvent("cold:switchLogin", true)
addEventHandler("cold:switchLogin", root, switchPanel)

function Initial(panel)
    showCursor(true)
    panelState = "wait"
    userInterface()
    setTimer(function()
        switchPanel(panel)
    end, 500, 1)
end
addEvent("cold:initialLogin", true)
addEventHandler("cold:initialLogin", root, Initial)