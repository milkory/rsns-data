local View = require("UIHomeEmergency/UIHomeEmergencyView")
local DataModel = {}
DataModel.furData = nil
DataModel.characterLiveInfo = {}
DataModel.allCanLiveInCharacter = {}
DataModel.roleIndex = nil
DataModel.ufid = nil
DataModel.emergencyFurData = {}
local this = DataModel

function DataModel.InitEmergencyFurData()
  this.emergencyFurData = {}
  for k, v in pairs(PlayerData:GetHomeInfo().furniture) do
    local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furCA.functionType == 12600296 and v.roles then
      this.emergencyFurData[k] = v
    end
  end
end

function DataModel.Init()
  this.InitEmergencyFurData()
  this.RefreshAllFurnitureLiveInfo()
end

function DataModel.RefreshAllFurnitureLiveInfo()
  this.characterLiveInfo = {}
  for k, v in pairs(this.emergencyFurData) do
    for pos, roleId in ipairs(v.roles) do
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

function DataModel.RefreshAllCanLiveInCharacter()
  this.allCanLiveInCharacter = {}
  for k, v in pairs(PlayerData.ServerData.roles) do
    local unitCA = PlayerData:GetFactoryData(k, "unitFactory")
    if unitCA.homeCharacter > 0 and unitCA.isDoctor then
      local t = {}
      t.id = k
      t.name = unitCA.name
      t.jobInt = unitCA.jobInt
      t.qualityInt = unitCA.qualityInt
      local viewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
      t.resUrl = viewCA.resUrl
      t.roleListResUrl = viewCA.roleListResUrl
      t.lv = v.lv
      t.obtain_time = v.obtain_time
      t.resonance_lv = v.resonance_lv or 0
      t.awake_lv = v.awake_lv or 0
      t.liveInfo = this.characterLiveInfo[t.id]
      table.insert(this.allCanLiveInCharacter, t)
    end
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
    local isTemp1 = this.characterLiveInfo[a.id] and this.characterLiveInfo[a.id].ufid == this.ufid
    local isTemp2 = this.characterLiveInfo[b.id] and this.characterLiveInfo[b.id].ufid == this.ufid
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
    local isTemp1 = this.characterLiveInfo[a.id] and this.characterLiveInfo[a.id].ufid == this.ufid
    local isTemp2 = this.characterLiveInfo[b.id] and this.characterLiveInfo[b.id].ufid == this.ufid
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
    local isTemp1 = this.characterLiveInfo[a.id] and this.characterLiveInfo[a.id].ufid == this.ufid
    local isTemp2 = this.characterLiveInfo[b.id] and this.characterLiveInfo[b.id].ufid == this.ufid
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

function DataModel.RefreshRoleListPanel(sortType)
  View.characterList:SetActive(true)
  if sortType == DataModel.ESortType.level then
    DataModel.SortByLevel()
  elseif sortType == DataModel.ESortType.quality then
    DataModel.SortByQuality()
  elseif sortType == DataModel.ESortType.time then
    DataModel.SortByTime()
  end
  View.characterList.Group_TopRight.Btn_Level.Img_Select:SetActive(sortType == DataModel.ESortType.level)
  View.characterList.Group_TopRight.Btn_Rarity.Img_Select:SetActive(sortType == DataModel.ESortType.quality)
  View.characterList.Group_TopRight.Btn_Time.Img_Select:SetActive(sortType == DataModel.ESortType.time)
  View.characterList.ScrollGrid_.grid.self:SetDataCount(table.count(DataModel.allCanLiveInCharacter))
  View.characterList.ScrollGrid_.grid.self:RefreshAllElement()
end

function DataModel.RefreshFurRoleData(roleId)
  local furCA = PlayerData:GetFactoryData(this.furData.id, "HomeFurnitureFactory")
  local characterNum = furCA.characterNum
  local roles = {}
  for i = 1, characterNum do
    roles[i] = this.furData.roles and this.furData.roles[i] or ""
  end
  if roles[1] == roleId then
    roles[1] = ""
    local unitCA = PlayerData:GetFactoryData(roleId, "unitFactory")
    HomeCharacterManager:StopOp(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)))
  else
    if roles[1] ~= "" then
      local unitCA = PlayerData:GetFactoryData(roles[1], "unitFactory")
      HomeCharacterManager:StopOp(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)))
    end
    roles[1] = roleId
    local unitCA = PlayerData:GetFactoryData(roleId, "unitFactory")
    HomeCharacterManager:StartOp(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)), DataModel.ufid, 0, -1)
  end
  this.furData.roles = roles
  local str = table.concat(roles, ",")
  Net:SendProto("hero.check_in", function(json)
  end, this.ufid, str, function(json)
    CommonTips.OnPromptConfirmOnly(GetText(json.msg), nil, function()
      UIManager:GoBack()
    end)
  end)
  PlayerData:SetRoleSleepTime(roleId, 0)
end

function DataModel.InitEmergency()
  local emergencyFurData = {}
  for k, v in pairs(PlayerData:GetHomeInfo().furniture) do
    local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furCA.functionType == 12600296 and v.roles then
      emergencyFurData[k] = v
    end
  end
  for ufid, furnitureInfo in pairs(emergencyFurData) do
    for index, roleId in ipairs(furnitureInfo.roles) do
      if roleId ~= "" then
        local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
        HomeCharacterManager:InitContinuousOp(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)), ufid, index - 1, -1)
      end
    end
  end
end

return DataModel
