local DataModel = {}
local IsUnLock = function(formulaId, furLevel)
  local pormulaCfg = PlayerData:GetFactoryData(formulaId)
  local conditionList = pormulaCfg.unlockenergyCondition
  local engines = PlayerData.ServerData.engines
  local furLv = pormulaCfg.unlock
  local LvUnLock = true
  local coreUnlock = true
  if furLevel < furLv then
    LvUnLock = false
  end
  for k, v in pairs(conditionList) do
    if v.num > engines[tostring(v.id)].lv then
      coreUnlock = false
    end
  end
  local UnLock = LvUnLock and coreUnlock
  return UnLock, LvUnLock, coreUnlock
end

function DataModel.GetFormulaRedStateById(formulaId, furLv)
  local cfg = PlayerData:GetFactoryData(formulaId)
  for k, v in pairs(cfg.condition) do
    local unLock = IsUnLock(v.id, furLv)
    local newGet = PlayerData:GetPlayerPrefs("int", v.id) == 0
    local isEnough = DataModel.MaterialIsEnough(v.id)
    if unLock and newGet and isEnough then
      return true
    end
  end
  return false
end

function DataModel.GetFurFormulaRedState(furId)
  local furCA = PlayerData:GetFactoryData(furId, "HomeFurnitureFactory")
  for i, formulaCfg in pairs(furCA.formulaGroup) do
    local cfg = PlayerData:GetFactoryData(formulaCfg.id)
    local formulaList = cfg.condition
    local newCount = 0
    for k, v in pairs(formulaList) do
      local unLock = IsUnLock(v.id, furCA.Level)
      local newGet = PlayerData:GetPlayerPrefs("int", v.id) == 0
      local isEnough = DataModel.MaterialIsEnough(v.id)
      if unLock and newGet and isEnough then
        return true
      end
    end
  end
  return false
end

function DataModel.HandleNewFormula(groupId)
  local cfg = PlayerData:GetFactoryData(groupId)
  local formulaList = cfg.condition
  local newCount = 0
  for k, v in pairs(formulaList) do
    local unLock = DataModel.FormulaIsUnLock(v.id)
    local newGet = PlayerData:GetPlayerPrefs("int", v.id) == 0
    local isEnough = DataModel.MaterialIsEnough(v.id)
    if unLock and newGet and isEnough then
      newCount = newCount + 1
    end
  end
  return newCount
end

function DataModel.Init(furniture)
  DataModel.furniture = furniture
  local fCfg = PlayerData:GetFactoryData(furniture.id)
  DataModel.furName = fCfg.name
  DataModel.furLevel = fCfg.Level
  local formulaGroup = fCfg.formulaGroup
  DataModel.formulaGroupList = {}
  for i, v in ipairs(formulaGroup) do
    local cfg = PlayerData:GetFactoryData(v.id)
    if cfg.unlock == -1 then
      local data = {
        id = v.id,
        newCount = 0,
        isOwn = true
      }
      data.newCount = DataModel.HandleNewFormula(v.id)
      table.insert(DataModel.formulaGroupList, data)
    else
      local ownList = PlayerData.ServerData.formula_items or {}
      local isOwn = false
      for k1, v1 in pairs(ownList) do
        if v1 == tostring(cfg.unlock) then
          local data = {
            id = v.id,
            newCount = 0,
            isOwn = true
          }
          data.newCount = DataModel.HandleNewFormula(v.id)
          table.insert(DataModel.formulaGroupList, data)
          isOwn = true
          break
        end
      end
      if isOwn == false then
        local data = {
          id = v.id,
          newCount = 0,
          isOwn = false
        }
        table.insert(DataModel.formulaGroupList, data)
      end
    end
  end
  table.sort(DataModel.formulaGroupList, function(t1, t2)
    if t1.isOwn ~= t2.isOwn then
      return t1.isOwn
    end
    return t1.id < t2.id
  end)
  DataModel.coreList = PlayerData:GetFactoryData(99900001).coreList
  DataModel.UpdateSelectGroupInfo(1)
  DataModel.nowPormulaId = -1
  DataModel.selectNum = 1
  DataModel.maxCompoundNum = 1
end

function DataModel.UpdateSelectGroupInfo(index)
  if DataModel.isGoback == true then
    return
  end
  DataModel.selectGroupIdx = index
  local cfg = PlayerData:GetFactoryData(DataModel.formulaGroupList[index].id)
  DataModel.formulaList = cfg.condition
end

function DataModel.FormulaIsUnLock(formulaId)
  local pormulaCfg = PlayerData:GetFactoryData(formulaId)
  local conditionList = pormulaCfg.unlockenergyCondition
  local engines = PlayerData.ServerData.engines
  local furLv = pormulaCfg.unlock
  local LvUnLock = true
  local coreUnlock = true
  if furLv > DataModel.furLevel then
    LvUnLock = false
  end
  for k, v in pairs(conditionList) do
    if v.num > engines[tostring(v.id)].lv then
      coreUnlock = false
    end
  end
  local UnLock = LvUnLock and coreUnlock
  return UnLock, LvUnLock, coreUnlock
end

function DataModel.MaterialIsEnough(id)
  local costList = PlayerData:GetFactoryData(id).drawForm
  for k, v in pairs(costList) do
    local ownNum = PlayerData:GetGoodsById(v.id).num
    local needNum = v.num
    if ownNum < needNum then
      return false
    end
  end
  local result = DataModel.CalExtraCost(id)
  if result.maxEnergyNum == 0 or result.maxGoldNum == 0 or result.maxMoveEnergyNum == 0 then
    return false
  end
  return true
end

function DataModel.CalExtraCost(nowPormulaId)
  local pormulaId = nowPormulaId or DataModel.nowPormulaId
  local pormulaCfg = PlayerData:GetFactoryData(pormulaId)
  local curMoveEnergy = PlayerData:GetUserInfo().move_energy
  local homeCommon = require("Common/HomeCommon")
  local result = {
    maxEnergyNum = -1,
    energyCost = -1,
    maxGoldNum = -1,
    goldCost = -1,
    maxMoveEnergyNum = -1,
    moveEnergyCost = -1
  }
  for i, v in ipairs(pormulaCfg.composeCondition) do
    if v.id == 11400039 then
      result.maxMoveEnergyNum = math.floor((homeCommon.GetMaxHomeEnergy() - curMoveEnergy) / v.num)
      result.maxMoveEnergyNum = result.maxMoveEnergyNum >= 0 and result.maxMoveEnergyNum or 0
      result.moveEnergyCost = v.num
    end
    if v.id == 11400001 then
      result.maxGoldNum = math.floor(PlayerData:GetUserInfo().gold / v.num)
      result.maxGoldNum = result.maxGoldNum >= 0 and result.maxGoldNum or 0
      result.goldCost = v.num
    end
    if v.id == 11400006 then
      result.maxEnergyNum = math.floor(PlayerData:GetUserInfo().energy / v.num)
      result.maxEnergyNum = result.maxEnergyNum >= 0 and result.maxEnergyNum or 0
      result.energyCost = v.num
    end
  end
  return result
end

function DataModel.CalMaxCompoundNum()
  local costList = DataModel.costList
  local maxCompoundNum = 1
  for i, v in ipairs(costList) do
    local ownNum = PlayerData:GetGoodsById(v.id).num
    local needNum = v.num
    local CompoundNum = math.floor(ownNum / needNum)
    if i == 1 then
      maxCompoundNum = CompoundNum
    else
      maxCompoundNum = CompoundNum <= maxCompoundNum and CompoundNum or maxCompoundNum
    end
  end
  local result = DataModel.CalExtraCost()
  maxCompoundNum = result.maxMoveEnergyNum ~= -1 and maxCompoundNum > result.maxMoveEnergyNum and result.maxMoveEnergyNum or maxCompoundNum
  maxCompoundNum = result.maxGoldNum ~= -1 and maxCompoundNum > result.maxGoldNum and result.maxGoldNum or maxCompoundNum
  maxCompoundNum = result.maxEnergyNum ~= -1 and maxCompoundNum > result.maxEnergyNum and result.maxEnergyNum or maxCompoundNum
  DataModel.maxCompoundNum = maxCompoundNum
end

function DataModel.UpdateNowSelectNum(num)
  DataModel.selectNum = MathEx.Clamp(num, 1, DataModel.maxCompoundNum)
end

function DataModel.UpdateNewFormula(formulaId)
  if PlayerData:GetPlayerPrefs("int", formulaId) == 0 then
    PlayerData:SetPlayerPrefs("int", formulaId, 1)
    local newCount = DataModel.formulaGroupList[DataModel.selectGroupIdx].newCount
    DataModel.formulaGroupList[DataModel.selectGroupIdx].newCount = newCount - 1
  end
end

function DataModel.FormatNum(num)
  local num = math.floor(num * 10) / 10
  if num <= 0 then
    return 0
  else
    local t1, t2 = math.modf(num)
    if 0 < t2 then
      return num
    else
      return t1
    end
  end
end

return DataModel
