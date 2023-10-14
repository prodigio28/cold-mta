
function createMessage(typeM, message, time)
    if not typeM then typeM = "info" end
    if not time then time = 5 end
    if message then
        print("Type of Message:"..typeM..", Message:"..message..", Time to show:"..time.."s.")
    end
end