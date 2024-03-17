local View = require("UIFlierConditionTip/UIFlierConditionTipView")
local DataModel = require("UIFlierConditionTip/UIFlierConditionTipDataModel")
local ViewFunction = require("UIFlierConditionTip/UIFlierConditionTipViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local info = Json.decode(initParams)
      View.GroupRemind_clean:SetActive(info.showType == EnumDefine.FlierConditionShowType.showNeedClean)
      View.GroupRemind_clean.Img_cityBottom.Txt_notice1:SetText(PlayerData:GetFactoryData(80602282, "TextFactory").text)
      View.GroupRemind_clean.Img_cityBottom.Txt_notice2:SetText(PlayerData:GetFactoryData(80602284, "TextFactory").text)
      View.GroupRemind_open:SetActive(info.showType == EnumDefine.FlierConditionShowType.functionLock)
      View.GroupRemind_open.Img_cityBottom.Txt_notice1:SetText(PlayerData:GetFactoryData(80601642, "TextFactory").text)
      View.GroupRemind_open.Img_cityBottom.Txt_notice2:SetText(PlayerData:GetFactoryData(80601930, "TextFactory").text)
      View.GroupRemind_leafletUnlock:SetActive(info.showType == EnumDefine.FlierConditionShowType.lefLetLock)
      View.GroupRemind_magazineUnlock:SetActive(info.showType == EnumDefine.FlierConditionShowType.magazineLock)
      View.GroupRemind_tvUnlock:SetActive(info.showType == EnumDefine.FlierConditionShowType.channelLock)
      if info.showType == EnumDefine.FlierConditionShowType.showNeedClean then
        View.self:PlayAnim("clean")
      elseif info.showType == EnumDefine.FlierConditionShowType.functionLock then
        View.self:PlayAnim("open")
      end
    end
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
