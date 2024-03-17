local DataModel = {
  allCoachCharacterMaxNum = 0,
  allCoachCharacterCurNum = 0,
  tCharacterToFuniture = {},
  curCharacter = {},
  oriCurCharacter = {},
  curUfid = 0,
  curSelectBedIdx = 0,
  allCanCheckInCharacter = {},
  curSelectCharacterIdx = 0,
  curRefreshBreakLv = 0
}

function DataModel.Init()
  DataModel.allCoachCharacterMaxNum = DataModel.GetAllCoachCharacterMaxNum()
  DataModel.allCoachCharacterCurNum = 0
  DataModel.curCharacter = {}
  DataModel.tCharacterToFuniture = {}
  for k, v in pairs(PlayerData.ServerData.user_home_info.furniture) do
    local furnitureCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furnitureCA.characterNum ~= nil and 0 < furnitureCA.characterNum then
      for i = 1, furnitureCA.characterNum do
        if k == DataModel.curUfid then
          DataModel.curCharacter[i] = v.roles and v.roles[i] or ""
        end
        if v.roles ~= nil and v.roles[i] ~= "" then
          DataModel.allCoachCharacterCurNum = DataModel.allCoachCharacterCurNum + 1
          DataModel.tCharacterToFuniture[v.roles[i]] = {}
          DataModel.tCharacterToFuniture[v.roles[i]].ufid = k
          DataModel.tCharacterToFuniture[v.roles[i]].pos = i
        end
      end
    end
  end
  DataModel.oriCurCharacter = Clone(DataModel.curCharacter)
end

function DataModel.GetAllCoachCharacterMaxNum()
  local num = 0
  for k, v in pairs(PlayerData.ServerData.user_home_info.coach) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    num = num + coachCA.characterNum
  end
  return num
end

function DataModel.GetAllCanCheckInCharacter(idx)
  local curCharacterId = DataModel.curCharacter[idx]
  DataModel.curSelectCharacterIdx = 0
  DataModel.allCanCheckInCharacter = {}
  for k, v in pairs(PlayerData.ServerData.roles) do
    if k ~= curCharacterId then
      local unitCA = PlayerData:GetFactoryData(k, "unitFactory")
      if 0 < unitCA.homeCharacter then
        local t = {}
        t.id = k
        t.name = unitCA.name
        t.jobInt = unitCA.jobInt
        t.qualityInt = unitCA.qualityInt
        local viewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
        t.resUrl = viewCA.resUrl
        t.roleListResUrl = viewCA.roleListResUrl
        t.lv = v.lv
        t.resonance_lv = v.resonance_lv or 0
        t.awake_lv = v.awake_lv or 0
        t.checkInInfo = DataModel.tCharacterToFuniture[t.id]
        table.insert(DataModel.allCanCheckInCharacter, t)
      end
    end
  end
  table.sort(DataModel.allCanCheckInCharacter, function(a, b)
    if a.checkInInfo ~= nil and b.checkInInfo == nil then
      return false
    elseif a.checkInInfo == nil and b.checkInInfo ~= nil then
      return true
    elseif a.qualityInt > b.qualityInt then
      return true
    elseif a.qualityInt < b.qualityInt then
      return false
    elseif a.lv > b.lv then
      return true
    elseif a.lv < b.lv then
      return false
    elseif tonumber(a.id) > tonumber(b.id) then
      return true
    end
    return false
  end)
  if curCharacterId ~= "" then
    local t = {}
    t.id = curCharacterId
    local unitCA = PlayerData:GetFactoryData(t.id, "UnitFactory")
    t.name = unitCA.name
    t.jobInt = unitCA.jobInt
    t.qualityInt = unitCA.qualityInt
    local viewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
    t.resUrl = viewCA.resUrl
    t.roleListResUrl = viewCA.roleListResUrl
    t.lv = PlayerData.ServerData.roles[curCharacterId].lv
    t.resonance_lv = PlayerData.ServerData.roles[curCharacterId].resonance_lv or 0
    t.awake_lv = PlayerData.ServerData.roles[curCharacterId].awake_lv
    t.checkInInfo = {
      ufid = DataModel.curUfid,
      pos = idx
    }
    table.insert(DataModel.allCanCheckInCharacter, 1, t)
    DataModel.curSelectCharacterIdx = 1
  end
end

return DataModel
