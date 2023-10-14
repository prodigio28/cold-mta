

function ensureDev(player, cmd, ...)
    local accountName = getAccountName(getPlayerAccount(player))
    if accountName and isObjectInACLGroup("user."..accountName, aclGetGroup("Admin")) then
        local table = {...}
        for _, value in pairs(table) do
            local resources = getResourceFromName(value)
            if getResourceState(resources) == "running" then
                restartResource(resources)
            end
        end
    end
end
addCommandHandler("ensure", ensureDev)