local View = require("UISpeedSettlement/UISpeedSettlementView")
local DataModel = require("UISpeedSettlement/UISpeedSettlementDataModel")
local ViewFunction = require("UISpeedSettlement/UISpeedSettlementViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local params = Json.decode(initParams)
    DataModel.bgmId = params.bgmId
    DataModel.hasSpeed = params.hasSpeed
    DataModel.hasBattle = params.hasBattle
    DataModel.mealId = params.mealId
    local buff = PlayerData:GetCurStationStoreBuff(PlayerData.GetCurTrainBuffType())
    local buffCA = PlayerData:GetFactoryData(buff.id, "HomeBuffFactory")
    local desc = buffCA.desc
    if buffCA.buffType ~= EnumDefine.HomeSkillEnum.HomeBattleBuff and buff.param ~= nil then
      desc = string.format(desc, math.floor(buff.param * 100))
    end
    if buffCA.name ~= nil and buffCA.name ~= "" then
      View.Img_BGText.Txt_1:SetText(buffCA.name)
    end
    View.Img_BGText.Group_1.Txt_Dec:SetText(desc)
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
