loadstring(exports.dgs:dgsImportFunction())()
local screenW, screenH = guiGetScreenSize()

local inventoryBrowser = guiCreateBrowser(0, 0, screenW, screenH, true, true)
local inventory_ = guiGetBrowser(inventoryBrowser)
local inventoryLink = "http://mta/local/userinterface/html/index.html"
local showing = false

addEventHandler("onClientBrowserCreated", inventoryBrowser,
    function()
        guiSetVisible(inventoryBrowser, false)
        loadBrowserURL(source, inventoryLink)
    end
)

bindKey("'", "down",
    function(key, keyState)
        showing = not showing
        showCursor(showing)
        if showing then
            guiSetVisible(inventoryBrowser, true)
            executeBrowserJavascript(inventory_, "window.postMessage({action: 'showMenu', invPeso: 0, invMaxpeso: 30, inventario :{}, drop:{}}, '*')")
        else
            executeBrowserJavascript(inventory_, "window.postMessage({action: 'hideMenu'}, '*')")
            setTimer(function()
                guiSetVisible(inventoryBrowser, false)
            end, 500, 1)
        end
    end
)

addCommandHandler("item", function()
    updateInventory({
        player = {
            element = localPlayer,
            maxPeso = 40,
        },
        item = {
            [1] = {
                name = "Maça",
                index = "apple",
                peso = 0.5,
                amount = 1
            }
        }
    })
end)

function updateInventory(data)
    local iPlayer = data.player
    local MaxPeso = data.player.maxPeso or 10
    local invPeso = data.player.invPeso or 0
    
    local itemPl = data.item
    for index, value in pairs(itemPl) do
        executeBrowserJavascript(inventory_, 
        "window.postMessage({action: 'updateMochila', invPeso: "..invPeso..", invMaxpeso: "..MaxPeso..", inventario :{["..index.."]: {name:'"..value.name.."', index:'"..value.index.."', peso:"..value.peso..", amount:"..value.amount.."} }, drop:{}}, '*')")
    end
end

--window.postMessage({action: 'updateMochila', drop: {}, invPeso: 20, invMaxpeso: 30, inventario: { [1] : { name: 'absolut', index: 'absolut', peso: 1, amount: 10 }, [2] : { name: 'absolut', index: 'absolut', peso: 1, amount: 10 } } },'*')