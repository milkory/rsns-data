local module = {}

function module.CheckActiveFunc(funcViewShow)
  local recordGuide = PlayerData:GetPlayerPrefs("int", "FuncActive")
  local currentGuide = GuideManager:GetCurrentClientGuideNO()
  if currentGuide == -1 then
    currentGuide = 999
    local curServerGuide = PlayerData:GetUserInfo().newbie_step or 0
    if currentGuide < curServerGuide then
      currentGuide = curServerGuide
    end
  end
  local checkFirst = false
  if recordGuide < currentGuide then
    PlayerData:SetPlayerPrefs("int", "FuncActive", currentGuide)
    checkFirst = true
  end
  local activeFunc = {}
  local funcConfig = PlayerData:GetFactoryData(99900047, "ConfigFactory")
  local recordIdx = {}
  local maxGuideId = currentGuide
  local checkOk = false
  for k, v in pairs(funcConfig.funcList) do
    checkOk = false
    if currentGuide >= v.guideId then
      checkOk = true
    end
    if v.quest and 0 < v.quest and checkOk then
      checkOk = PlayerData.IsQuestComplete(v.quest)
    end
    if checkOk then
      activeFunc[v.funcId] = 0
      if maxGuideId == v.guideId then
        table.insert(recordIdx, k)
      end
    end
  end
  if funcViewShow then
    funcViewShow(activeFunc)
  end
  if checkFirst and 0 < #recordIdx then
    local showInfo = {}
    local isRunInterrupt = GuideManager:GetCurrentGuideIsRunInterrupt()
    if not isRunInterrupt then
      for k, v in pairs(recordIdx) do
        local data = funcConfig.funcList[v]
        if data.isShow then
          table.insert(showInfo, data)
        end
      end
    end
    if 0 < #showInfo then
      UIManager:Open("UI/NewFuncActivated/NewFuncActivated", Json.encode(showInfo))
    end
  end
  return activeFunc
end

function module.FuncActiveCheck(funcId, isShowTip)
  if isShowTip == nil then
    isShowTip = true
  end
  local currentGuide = GuideManager:GetCurrentClientGuideNO()
  if currentGuide == -1 then
    currentGuide = 999
    local curServerGuide = PlayerData:GetUserInfo().newbie_step or 0
    if currentGuide < curServerGuide then
      currentGuide = curServerGuide
    end
  end
  local funcConfig = PlayerData:GetFactoryData(99900047, "ConfigFactory")
  for k, v in pairs(funcConfig.funcList) do
    if v.funcId == funcId then
      local checkOk = false
      if currentGuide >= v.guideId then
        checkOk = true
      end
      if v.quest and 0 < v.quest and checkOk then
        checkOk = PlayerData.IsQuestComplete(v.quest)
      end
      if checkOk then
        do return true end
        break
      end
      if isShowTip then
        CommonTips.OpenTips(v.tips)
      end
      break
    end
  end
  return false
end

return module
