
function ensureCommand(player, cmd, ...)
    local table = {...}
    for index, value in pairs(table) do
        local resource = getResourceFromName(value)
        if getResourceState(resource) == "running" then
            restartResource(resource)
        end
    end
end
addCommandHandler("ensure", ensureCommand)