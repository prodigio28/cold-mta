
function createMessage(player, typeM, message, time)
    if player then
        if not typeM then typeM = "info" end
        if not time then time = 5 end
        if message then
            iprint("Player:"..getPlayerName(player)..", Type of Message:"..typeM..", Message:"..message..", Time to show:"..time.."s.")
        end
    end
end