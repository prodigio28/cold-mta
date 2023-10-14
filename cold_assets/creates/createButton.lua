dataButtons = {}
Buttons = {}

function createButton(id, data)
    if not dataButtons[id] and not Buttons[id] then
        dataButtons[id] = data
        Buttons[id] = {}
    end

    Buttons[id] = dgsCreateButton(data.edit[1], data.edit[2], data.edit[3], data.edit[4], data.edit[5], data.edit[6], data.edit[7], data.edit[8], data.edit[9], data.edit[10], ":cold_assets/images/buttons/"..data.edit[11], data.edit[12], data.edit[13], data.edit[14], data.edit[15], data.edit[16])
    for index, value in pairs(data) do
        if index ~= "edit" then
            dgsSetProperty(Buttons[id], index, value)
        end
    end
end

function getButtonById(id)
    return Buttons[id]
end

function destroyButtonById(id)
    destroyElement(Buttons[id])
    return
end
