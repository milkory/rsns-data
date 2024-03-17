local View = require("UIFlierConditionTip/UIFlierConditionTipView")
local DataModel = require("UIFlierConditionTip/UIFlierConditionTipDataModel")
local ViewFunction = {
  FlierConditionTip_GroupRemind_clean_Btn_skip_Click = function(btn, str)
    CommonTips.OpenToHomeCarriageeditor()
  end,
  FlierConditionTip_Btn_Close_Click = function(btn, str)
    UIManager:CloseTip("UI/Flier/FlierConditionTip")
  end
}
return ViewFunction
