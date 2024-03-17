local View = require("UIGroupDiscardTip/UIGroupDiscardTipView")
local DataModel = require("UIGroupDiscardTip/UIGroupDiscardTipDataModel")
local ViewFunction = require("UIGroupDiscardTip/UIGroupDiscardTipViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local parms = Json.decode(initParams)
    DataModel.param = CommonTips.parms
    if parms.content ~= nil and parms.content ~= "" then
      View.Txt_Prompt:SetText(parms.content)
    end
    if parms.yesTxt then
      View.Btn_Confirm.Txt_Confirm:SetText(parms.yesTxt)
    end
    if parms.noTxt then
      View.Btn_Cancel.Txt_Cancel:SetText(parms.noTxt)
    end
    DataModel.isTrue = PlayerData:GetPlayerPrefs("int", "DiscardState") == 1
    View.Group_Tip.Btn_Tip.Group_On.self:SetActive(DataModel.isTrue)
    UIManager:Pause(true)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    UIManager:Pause(false)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
