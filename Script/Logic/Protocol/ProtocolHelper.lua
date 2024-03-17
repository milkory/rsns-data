local ProtocolHelper = {}

function ProtocolHelper.CreateProtocolApi(pType, callback)
  local api = ProtocolFactory:CreateProtocol(pType)
  api.pid = PlayerData.pid
  if callback ~= nil then
    api:SetCallback(function(res)
      if res == nil then
        pcall(callback)
      else
        pcall(callback, res)
      end
    end)
  end
  return api
end

function ProtocolHelper.CreateProtocolMainIndex()
  local main = ProtocolFactory:CreateProtocol(ProtocolType.MainIndex)
  main.timestamp = TimeTool.UnixTimeStamp() - PlayerData.serverTimeOffset
  main.pid = PlayerData.pid or " "
  main.platform = PlayerData.platform
  main.rty = TimeTool.UnixMillisecondsTimeStamp() - PlayerData.serverTimeOffset
  return main
end

function ProtocolHelper.SendProtocolApi(protocolApi)
  ServerConnectManager:Add(protocolApi)
end

return ProtocolHelper
