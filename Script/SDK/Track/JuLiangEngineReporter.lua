local JuLiangEngineReporter = {}

function JuLiangEngineReporter.OnEventRegister(sChannel, bStatus)
  CS.JuLiangEngineLuaface.OnEventRegister(sChannel, bStatus)
end

function JuLiangEngineReporter.OnEventLogin(sChannel, bStatus)
  CS.JuLiangEngineLuaface.OnEventLogin(sChannel, bStatus)
end

function JuLiangEngineReporter.OnEventPurchase(sType, sName, sId, lNum, sChannel, sCurrency, bIsSuccess, lPayAmount)
  CS.JuLiangEngineLuaface.OnEventPurchase(sType, sName, sId, lNum, sChannel, sCurrency, bIsSuccess, lPayAmount)
end

function JuLiangEngineReporter.OnEventV3(sEventName, sJsonStr)
  CS.JuLiangEngineLuaface.OnEventV3(sEventName, sJsonStr)
end

return JuLiangEngineReporter
