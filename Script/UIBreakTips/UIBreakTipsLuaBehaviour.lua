local View = require("UIBreakTips/UIBreakTipsView")
local DataModel = require("UIBreakTips/UIBreakTipsDataModel")
local ViewFunction = require("UIBreakTips/UIBreakTipsViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.data)
  end,
  deserialize = function(initParams)
    DataModel.data = Json.decode(initParams)
    local ca = PlayerData:GetFactoryData(DataModel.data.caId)
    View.Img_Di1:SetSprite(ca.breakDi1Path)
    View.Img_Di2:SetSprite(ca.breakDi2Path)
    View.Img_Core:SetSprite(ca.breakIconPath)
    View.Img_Icon:SetSprite(ca.coreIconPath)
    View.Txt_Name:SetText(GetText(ca.name))
    View.Txt_EngName:SetText(GetText(ca.nameEN))
    View.Group_Before.Txt_Num:SetText(DataModel.data.curLv)
    View.Group_Next.Txt_Num:SetText(DataModel.data.nextLv)
    View.Group_Next.Img_Di:SetSprite(ca.gradePath)
    View.Group_Next.Txt_Num:SetColor(ca.color)
    View.Group_Next.Txt_Max:SetColor(ca.color)
    View.Group_Next.Txt_UpGrate:SetColor(ca.color)
    View.Img_Core:SetDynamicGameObject(ca.breakEffects1, 0, 0)
    View.Group_Before.Img_Di:SetDynamicGameObject(ca.breakEffects2, 0, 0)
    View.Group_Next.Img_Effect:SetDynamicGameObject(ca.breakEffects3, 0, 0)
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
