
local CACHE_ITENS = {}
local databases = exports.cold_connection

local database = databases:getMySQL()

function loadData(qh)
    local result = dbPoll(qh, -1)
    for index, value in ipairs(getElementsByType("player")) do
        for i, v in pairs(result) do
            local accountID = getAccountID(getPlayerAccount(value))
            if accountID == tonumber(v["playerid"]) then
                if not CACHE_ITENS[value] then CACHE_ITENS[value] = {} end
                table.insert(CACHE_ITENS[value], v)
            end
        end
    end
end

addCommandHandler("datra", function(player, cmd, slot)
    CACHE_ITENS[player] = {}
end)

function saveData(player, cmd)
    if CACHE_ITENS[player] then
        local data
        local dataFromDatabase
        local value2
        local checkItens = dbPoll(dbQuery(database, "SELECT * FROM items"), -1)
        for index, value in pairs(CACHE_ITENS[player]) do
            value2 = value
            data = fromJSON(value.data)
            for i, v in pairs(checkItens) do
                table.sort(value, function(a, b) iprint(a, b) end)
                dataFromDatabase = fromJSON(v.data)
            end
        end
        if data.slot ~= dataFromDatabase.slot then 
            local query = dbQuery(database, "INSERT INTO items (playerid, data) VALUES (?, ?)", value2.playerid, value2.data)
            local result = dbPoll(query, -1)
        end
    end
end
addCommandHandler("savedata", saveData)

function addItem(player, tipo, name, quantity, slot)
    local playerId = getAccountID(getPlayerAccount(player))
    if items[tipo] then
        for index, value in pairs(items[tipo]) do
            if name == value.name then
                value.amount = quantity
                value.slot = slot
                local queryAdd = dbQuery(loadData, database, "INSERT INTO items (playerid, data) VALUES (?, ?)", playerId, toJSON(value))
            end
        end
    end
end

local function Initial()
    if database then
        dbQuery(loadData, database, "SELECT * FROM items")
    end
end
addEventHandler("onResourceStart", resourceRoot, Initial)
