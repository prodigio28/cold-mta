loadstring(exports.dgs:dgsImportFunction())()
dataInputs = {}
Inputs = {}

function createInput(id, data)
    if not dataInputs[id] and not Inputs[id] then
        dataInputs[id] = data
        Inputs[id] = {}
    end

    Inputs[id] = dgsCreateEdit(data.edit[1], data.edit[2], data.edit[3], data.edit[4], data.edit[5], data.edit[6], data.edit[7], data.edit[8], data.edit[9], data.edit[10], ":cold_assets/images/inputs/"..data.edit[11], data.edit[12])
    for index, value in pairs(data) do
        if index ~= "edit" then
            dgsSetProperty(Inputs[id], index, value)
        end
    end
end

function getInputById(id)
    return Inputs[id]
end

function destroyInputById(id)
    return destroyElement(Inputs[id])
end