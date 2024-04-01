function Split(szFullString, szSeparator)
  local nFindStartIndex = 1
  
  local nSplitIndex = 1
  local nSplitArray = {}
  while true do
    local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
    if not nFindLastIndex then
      nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
      break
    end
    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
    nFindStartIndex = nFindLastIndex + string.len(szSeparator)
    nSplitIndex = nSplitIndex + 1
  end
  return nSplitArray
end

function Trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function ToNumber(value)
  return math.modf(value + 0.1)
end

function GetText(id)
  local idText = PlayerData:GetFactoryData(id, "TextFactory")
  if idText ~= nil then
    return idText.text
  else
    return PlayerData:GetFactoryData(80600033, "TextFactory").text
  end
end

function SafeReleaseVaildScene()
  local curSceneList = {}
  local cnt = CS.UnityEngine.SceneManagement.SceneManager.sceneCount - 1
  for i = 0, cnt do
    local s = CS.UnityEngine.SceneManagement.SceneManager.GetSceneAt(i)
    table.insert(curSceneList, s.name)
  end
  local SliceSceneManager = CBus:GetManager(CS.ManagerName.SliceSceneManager, true)
  if SliceSceneManager ~= nil then
    local i = SliceSceneManager.loadedScene.Count - 1
    if i < 0 then
      return
    end
    while 0 <= i do
      local item = SliceSceneManager.loadedScene[i]
      local v = SliceSceneManager:Sceneid2Pos(item)
      local name = "crunk" .. 100 + v.x .. "_" .. 100 + v.y
      if SliceSceneManager.loadingScene:Contains(item) == false and CheckSceneExist(name, curSceneList) == false then
        SliceSceneManager.loadedScene:RemoveAt(i)
      end
      i = i - 1
    end
  end
end

function SafeReleaseScene(isUnload)
  local curSceneList = {}
  if isUnload == nil then
    isUnload = false
  end
  if isUnload == true then
    local cnt = CS.UnityEngine.SceneManagement.SceneManager.sceneCount - 1
    for i = 0, cnt do
      local s = CS.UnityEngine.SceneManagement.SceneManager.GetSceneAt(i)
      table.insert(curSceneList, s.name)
    end
  end
  local SliceSceneManager = CBus:GetManager(CS.ManagerName.SliceSceneManager, true)
  if SliceSceneManager ~= nil then
    local i = SliceSceneManager.loadedScene.Count - 1
    while 0 <= i do
      local item = SliceSceneManager.loadedScene[i]
      local v = SliceSceneManager:Sceneid2Pos(item)
      local name = "crunk" .. 100 + v.x .. "_" .. 100 + v.y
      if isUnload == true and CheckSceneExist(name, curSceneList) then
        SliceSceneManager:UnloadScene(v.x, v.y, true)
      else
        local DisplayManager = CBus:GetManager(CS.ManagerName.DisplayManager, true)
        if DisplayManager ~= nil then
          DisplayManager:RemoveWatcher(name)
        end
        local ResManager = CBus:GetManager(CS.ManagerName.ResManager, true)
        if ResManager ~= nil then
          ResManager.resloader:ReleaseGCKeyBroadCast("#" .. name, true, true)
        end
      end
      i = i - 1
    end
    SliceSceneManager.loadedScene:Clear()
  end
end

function CheckSceneExist(name, list)
  if list == nil then
    return false
  end
  local rel = false
  for i, v in ipairs(list) do
    if v == name then
      rel = true
    end
  end
  return rel
end

function GetTextNPCMod(id)
  local idText = PlayerData:GetFactoryData(id, "TextFactory")
  if idText ~= nil then
    if idText.isReplace then
      local text = idText.noDataString
      local replaceFunc1 = function()
        local t = PlayerData.TempCache.NPCTalkData[idText.replaceType]
        if t ~= nil and 0 < #t then
          local idx = 1
          local count = #t
          local curTime = TimeUtil:GetServerTimeStamp()
          while idx <= count do
            local info = t[idx]
            if curTime >= info.end_time then
              table.remove(t, idx)
              count = count - 1
            else
              idx = idx + 1
            end
          end
          if 0 < count then
            local randomIdx = math.random(1, count)
            local detailInfo = t[randomIdx]
            text = string.gsub(idText.text, "{%a+}", function(s)
              if s == idText.stationString then
                return detailInfo.stationName
              elseif s == idText.goodsString then
                return detailInfo.goodsName
              end
              return s
            end)
          end
        end
      end
      local replaceFunc2 = function()
        local t = PlayerData.TempCache.NPCTalkData[idText.replaceType]
        if t ~= nil and 0 < #t then
          local num = math.random(1, #t)
          local data = t[num]
          text = string.gsub(idText.text, idText.goodsString, data.name)
        end
      end
      local TypeToFunc = {
        [EnumDefine.NPCTalkDataEnum.BuySuddenRise] = replaceFunc1,
        [EnumDefine.NPCTalkDataEnum.BuySuddenDrop] = replaceFunc1,
        [EnumDefine.NPCTalkDataEnum.SellSuddenRise] = replaceFunc1,
        [EnumDefine.NPCTalkDataEnum.SellSuddenDrop] = replaceFunc1,
        [EnumDefine.NPCTalkDataEnum.Drop] = replaceFunc2,
        [EnumDefine.NPCTalkDataEnum.Rise] = replaceFunc2,
        [EnumDefine.NPCTalkDataEnum.RareGoods] = replaceFunc2
      }
      if idText.replaceType == EnumDefine.NPCTalkDataEnum.PlayerName then
        local userInfo = PlayerData:GetUserInfo()
        local playerName = ""
        if userInfo ~= nil then
          playerName = userInfo.role_name
        end
        text = string.gsub(idText.text, idText.playerNameString, playerName)
      elseif TypeToFunc[idText.replaceType] ~= nil then
        TypeToFunc[idText.replaceType]()
      end
      return text
    else
      return idText.text
    end
  else
    return PlayerData:GetFactoryData(80600033, "TextFactory").text
  end
end

function FixAdBoard()
  local modeNode = CS.UnityEngine.GameObject.Find("Environment/Model/M_S1_ggp_chezhan_matou/AD_Board")
  if modeNode == nil then
    return
  end
  local ads = modeNode:GetComponent(typeof(CS.AdBoardView))
  if ads == nil then
    return
  end
  ads.isRGMLoaded = true
end

function NumThousandsSplit(num, saveDecimalNum)
  local intPart = math.floor(num)
  local decimalPart = num - intPart
  local s = tostring(intPart)
  local pos = string.len(s) % 3
  if pos == 0 then
    pos = 3
  end
  local result = string.sub(s, 1, pos) .. string.gsub(string.sub(s, pos + 1), "(...)", ",%1")
  if saveDecimalNum then
    return result .. string.format(".%." .. saveDecimalNum .. "f", decimalPart)
  end
  return result
end

function ClearFollowZero(num, saveDecimalNum)
  if not saveDecimalNum then
    saveDecimalNum = 1
  elseif 3 < saveDecimalNum then
    saveDecimalNum = 3
  end
  local format = "%." .. saveDecimalNum .. "f"
  local str = string.format(format, num)
  return str:gsub("(%.%d*[1-9])0+$", "%1"):gsub("%.0*$", "")
end

seven_mt = {
  __index = function(t, key)
    if t.self then
      return t.self[key]
    end
    return t[key]
  end
}
