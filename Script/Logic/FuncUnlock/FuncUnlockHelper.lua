local FuncUnlockHelper = {}
FuncUnlockConst = require("Logic/FuncUnlock/FuncUnlockConst")

function FuncUnlockHelper.IsFuncUnlock(iFuncId)
  local funcConfig = PlayerData:GetFactoryData(99900047, "ConfigFactory")
  for k, v in pairs(funcConfig.funcList) do
    if v.funcId == iFuncId then
      return FuncUnlockHelper.IsFuncUnlockItem(v)
    end
  end
  return false
end

function FuncUnlockHelper.IsFuncUnlockItem(funcItemData)
  local v = funcItemData
  if v == nil then
    return false
  end
  local currentGuide = GuideManager:GetCurrentClientGuideNO()
  if currentGuide == -1 then
    currentGuide = 999
    local curServerGuide = PlayerData:GetUserInfo().newbie_step or 0
    if currentGuide < curServerGuide then
      currentGuide = curServerGuide
    end
  end
  local checkOk = false
  if currentGuide >= v.guideId then
    checkOk = true
  end
  if v.quest and 0 < v.quest and checkOk then
    checkOk = PlayerData.IsQuestComplete(v.quest)
  end
  local playerLevel = PlayerData:GetPlayerLevel()
  if v.playerLevel and 0 < v.playerLevel then
    checkOk = checkOk and playerLevel >= v.playerLevel
  end
  if checkOk then
    return true
  else
    return false
  end
  return false
end

return FuncUnlockHelper
