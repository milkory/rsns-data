local View = require("UIBattleSettlement/UIBattleSettlementView")
local DataModel = require("UIBattleSettlement/UIBattleSettlementDataModel")
local ViewFunction = require("UIBattleSettlement/UIBattleSettlementViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local params = Json.decode(initParams)
    DataModel.bgmId = params.bgmId
    DataModel.mealId = params.mealId
    local buff = PlayerData:GetCurStationStoreBuff(EnumDefine.HomeSkillEnum.HomeBattleBuff)
    local buffCA = PlayerData:GetFactoryData(buff.id, "HomeBuffFactory")
    local skillCA = PlayerData:GetFactoryData(buffCA.battleBuff, "SkillFactory")
    local desc
    desc = skillCA.description
    local skillParam = skillCA.desParamList[1]
    if skillParam ~= nil then
      if skillParam.isPercent then
        desc = string.format(desc, PlayerData:GetPreciseDecimalFloor(skillParam.param * 100, 1))
      else
        desc = string.format(desc, PlayerData:GetPreciseDecimalFloor(skillParam.param, 1))
      end
    end
    if buffCA.name ~= nil and buffCA.name ~= "" then
      View.Img_BGText.Txt_1:SetText(buffCA.name)
    end
    View.Img_BGText.Group_1.Txt_Dec:SetText(string.format(GetText(80606871), desc))
    local remainTime = buffCA.continueTime
    View.Img_BGText.Group_1.Txt_Time:SetText(string.format(GetText(80601648), math.ceil(remainTime / 60)))
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
