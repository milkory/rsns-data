local View = require("UIUpgradeSuccess/UIUpgradeSuccessView")
local DataModel = require("UIUpgradeSuccess/UIUpgradeSuccessDataModel")
local ViewFunction = require("UIUpgradeSuccess/UIUpgradeSuccessViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local params = Json.decode(initParams)
    View.Group_LvBefore.Txt_Num:SetText(params.beforeNum)
    View.Group_LvAfter.Txt_Num:SetText(params.afterNum)
    View.Txt_Tip:SetText(GetText(80601188))
    View.self:PlayAnim("HomeUpgradeSuccess", function()
      View.self:SetEnableAnimator(false)
    end)
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
