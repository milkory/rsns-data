local DataModel = {}
local this = DataModel
DataModel.curFurUfid = nil
DataModel.curFurId = nil
DataModel.characterLiveInfo = {}
DataModel.curCharacter = nil
DataModel.curLiveInPos = nil
DataModel.allCanLiveInCharacter = {}
DataModel.roleIndex = nil
DataModel.isSelect = false
DataModel.mousePos = Vector3(0, 0, 0)
DataModel.liveFurData = {}
DataModel.defaultLightColorType = EnumDefine.EFurLightColorType.Red

function DataModel.InitLiveFurData()
  this.liveFurData = {}
  for k, v in pairs(PlayerData:GetHomeInfo().furniture) do
    local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furCA.functionType == 12600199 and furCA.characterNum > 0 and v.roles then
      for _, roleId in pairs(v.roles) do
        if roleId ~= "" then
          this.liveFurData[k] = v
          break
        end
      end
    end
  end
end

function DataModel.RefreshAllFurnitureLiveInfo()
  this.characterLiveInfo = {}
  for k, v in pairs(this.liveFurData) do
    for pos, roleId in pairs(v.roles) do
      this.SetFurnitureLiveInfo(roleId, k, pos)
    end
  end
end

function DataModel.SetFurnitureLiveInfo(roleId, ufid, pos)
  if roleId and roleId ~= "" then
    this.characterLiveInfo[roleId] = {}
    this.characterLiveInfo[roleId].roleId = roleId
    this.characterLiveInfo[roleId].ufid = ufid
    this.characterLiveInfo[roleId].pos = pos
    local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
    this.characterLiveInfo[roleId].characterId = tonumber(unitCA.homeCharacter)
  end
end

DataModel.ESortType = {
  level = 1,
  quality = 2,
  time = 3
}

function DataModel.SortByLevel()
  this.RefreshAllCanLiveInCharacter()
  table.sort(this.allCanLiveInCharacter, function(a, b)
    local isTemp1 = this.characterLiveInfo[a.id] and this.characterLiveInfo[a.id].ufid == this.curFurUfid
    local isTemp2 = this.characterLiveInfo[b.id] and this.characterLiveInfo[b.id].ufid == this.curFurUfid
    if isTemp1 and isTemp2 then
      return false
    elseif isTemp1 then
      return true
    elseif isTemp2 then
      return false
    else
      local isLive1 = this.characterLiveInfo[a.id]
      local isLive2 = this.characterLiveInfo[b.id]
      if isLive1 and not isLive2 then
        return false
      elseif not isLive1 and isLive2 then
        return true
      elseif a.lv == b.lv then
        if a.qualityInt == b.qualityInt then
          return tonumber(a.id) > tonumber(b.id)
        else
          return tonumber(a.qualityInt) > tonumber(b.qualityInt)
        end
      else
        return a.lv > b.lv
      end
    end
  end)
end

function DataModel.SortByQuality()
  this.RefreshAllCanLiveInCharacter()
  table.sort(this.allCanLiveInCharacter, function(a, b)
    local isTemp1 = this.characterLiveInfo[a.id] and this.characterLiveInfo[a.id].ufid == this.curFurUfid
    local isTemp2 = this.characterLiveInfo[b.id] and this.characterLiveInfo[b.id].ufid == this.curFurUfid
    if isTemp1 and isTemp2 then
      return false
    elseif isTemp1 then
      return true
    elseif isTemp2 then
      return false
    else
      local isLive1 = this.characterLiveInfo[a.id]
      local isLive2 = this.characterLiveInfo[b.id]
      if isLive1 and not isLive2 then
        return false
      elseif not isLive1 and isLive2 then
        return true
      elseif a.qualityInt == b.qualityInt then
        if a.lv == b.lv then
          return tonumber(a.id) > tonumber(b.id)
        else
          return tonumber(a.lv) > tonumber(b.lv)
        end
      else
        return a.qualityInt > b.qualityInt
      end
    end
  end)
end

function DataModel.SortByTime()
  this.RefreshAllCanLiveInCharacter()
  table.sort(this.allCanLiveInCharacter, function(a, b)
    local isTemp1 = this.characterLiveInfo[a.id] and this.characterLiveInfo[a.id].ufid == this.curFurUfid
    local isTemp2 = this.characterLiveInfo[b.id] and this.characterLiveInfo[b.id].ufid == this.curFurUfid
    if isTemp1 and isTemp2 then
      return false
    elseif isTemp1 then
      return true
    elseif isTemp2 then
      return false
    else
      local isLive1 = this.characterLiveInfo[a.id]
      local isLive2 = this.characterLiveInfo[b.id]
      if isLive1 and not isLive2 then
        return false
      elseif not isLive1 and isLive2 then
        return true
      elseif a.obtain_time == b.obtain_time then
        return tonumber(a.id) > tonumber(b.id)
      else
        return a.obtain_time > b.obtain_time
      end
    end
  end)
end

function DataModel.RefreshAllCanLiveInCharacter()
  this.allCanLiveInCharacter = {}
  for k, v in pairs(PlayerData.ServerData.roles) do
    local unitCA = PlayerData:GetFactoryData(k, "unitFactory")
    if unitCA.homeCharacter > 0 and unitCA.gotoBed then
      local t = {}
      t.id = k
      t.name = unitCA.name
      t.jobInt = unitCA.jobInt
      t.qualityInt = unitCA.qualityInt
      local viewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
      t.resUrl = viewCA.resUrl
      t.lv = v.lv
      t.obtain_time = v.obtain_time
      t.resonance_lv = v.resonance_lv or 0
      t.awake_lv = v.awake_lv or 0
      t.liveInfo = this.characterLiveInfo[t.id]
      table.insert(this.allCanLiveInCharacter, t)
    end
  end
end

local maxInfo

function DataModel.GetMaxLvFurnitureInfo(furId)
  local cfg = PlayerData:GetFactoryData(furId, "HomeFurnitureFactory")
  if cfg.upgrade then
    if not PlayerData:GetFactoryData(cfg.upgrade, "HomeFurnitureFactory") then
      maxInfo = cfg
      return
    end
    this.GetMaxLvFurnitureInfo(cfg.upgrade)
  else
    maxInfo = cfg
  end
  return maxInfo
end

function DataModel.IsInEmergency(roleId)
  local inEmergency = false
  for k, v in pairs(PlayerData.ServerData.user_home_info.furniture) do
    local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furCA.functionType == 12600296 and v.roles then
      for _, id in ipairs(v.roles) do
        if id == roleId then
          inEmergency = true
          break
        end
      end
      if inEmergency then
        break
      end
    end
  end
  return inEmergency
end

function DataModel.GetLiveSleepTime(roleId)
  if not roleId or roleId == "" or this.IsInEmergency(roleId) then
    return 0
  end
  local resultTime = 0
  local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
  local homeCharacterCA = PlayerData:GetFactoryData(tonumber(unitCA.homeCharacter), "HomeCharacterFactory")
  local timeBegin = homeCharacterCA.noonTimeBegin
  local timeEnd = homeCharacterCA.noonTimeEnd
  if timeBegin and timeBegin ~= "" and timeEnd and timeEnd ~= "" then
    local time = os.date("*t", os.time())
    local BeginHour = tonumber(string.sub(timeBegin, 1, 2))
    local BeginMin = tonumber(string.sub(timeBegin, 4, 5))
    local BeginSec = tonumber(string.sub(timeBegin, 7, 8))
    local EndHour = tonumber(string.sub(timeEnd, 1, 2))
    local EndMin = tonumber(string.sub(timeEnd, 4, 5))
    local EndSec = tonumber(string.sub(timeEnd, 7, 8))
    if time.hour * 3600 + time.min * 60 + time.sec >= BeginHour * 3600 + BeginMin * 60 + BeginSec then
      local hour = BeginHour <= EndHour and EndHour - time.hour or EndHour - time.hour + 24
      time = (hour * 60 + EndMin - time.min) * 60 + EndSec - time.sec
      resultTime = time
    end
  end
  if 0 < resultTime then
    return resultTime
  end
  timeBegin = homeCharacterCA.nightTimeBegin
  timeEnd = homeCharacterCA.nightTimeEnd
  if timeBegin and timeBegin ~= "" and timeEnd and timeEnd ~= "" then
    local time = os.date("*t", os.time())
    local BeginHour = tonumber(string.sub(timeBegin, 1, 2))
    local BeginMin = tonumber(string.sub(timeBegin, 4, 5))
    local BeginSec = tonumber(string.sub(timeBegin, 7, 8))
    local EndHour = tonumber(string.sub(timeEnd, 1, 2))
    local EndMin = tonumber(string.sub(timeEnd, 4, 5))
    local EndSec = tonumber(string.sub(timeEnd, 7, 8))
    if time.hour * 3600 + time.min * 60 + time.sec >= BeginHour * 3600 + BeginMin * 60 + BeginSec then
      local hour = BeginHour <= EndHour and EndHour - time.hour or EndHour - time.hour + 24
      time = (hour * 60 + EndMin - time.min) * 60 + EndSec - time.sec
      resultTime = time
    end
  end
  return 0 < resultTime and resultTime or 0
end

return DataModel
