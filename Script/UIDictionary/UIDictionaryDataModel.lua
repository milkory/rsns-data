local DataModel = {}

function DataModel:init()
  self.skillList = PlayerData:GetFactoryData(83800001).Card
  table.sort(self.skillList, function(t1, t2)
    local config1 = PlayerData:GetFactoryData(t1.Skill)
    local config2 = PlayerData:GetFactoryData(t2.Skill)
    local cardConfig1 = PlayerData:GetFactoryData(config1.cardID)
    local cardConfig2 = PlayerData:GetFactoryData(config2.cardID)
    if cardConfig1.cost_SN > cardConfig2.cost_SN then
      return true
    elseif cardConfig1.cost_SN == cardConfig2.cost_SN then
      return t1.Skill < t2.Skill
    end
  end)
  self.skillTagList = nil
  self.lastTopTab = 1
  self.lastAffixTab = nil
  self.selectId = 1
  self.affixList = {
    nil,
    nil,
    nil
  }
  self.affixList[1] = PlayerData:GetFactoryData(83800002).Technical
  self.affixList[2] = PlayerData:GetFactoryData(83800002).Control
  self.affixList[3] = PlayerData:GetFactoryData(83800002).Defence
  self.tagSelectType = 1
  local battleConfig = PlayerData:GetFactoryData(99900008, "ConfigFactory")
  self.numCA = PlayerData:GetFactoryData(battleConfig.cardCostNormalID, "BattleInfoFactory")
end

function DataModel:GetSkillTagList(cardId)
  local tempData = PlayerData:GetFactoryData(cardId).tagList
  self.skillTagList = {}
  for k, v in pairs(tempData) do
    local tagConfig = PlayerData:GetFactoryData(v.tagId)
    if tagConfig.isShowDetail then
      table.insert(self.skillTagList, v.tagId)
    end
  end
  return self.skillTagList
end

function DataModel:GetcostImgConfig(num)
  local rt = PlayerData:GetFactoryData(self.numCA["num" .. tostring(num) .. "Id"], "BattleTextFactory")
  return rt
end

return DataModel
