local View = require("UIOilUpWindow/UIOilUpWindowView")
local DataModel = require("UIOilUpWindow/UIOilUpWindowDataModel")
local Controller = require("UIOilUpWindow/UIOilUpWindowController")
local ViewFunction = {
  OilUpWindow_Btn_Black_Click = function(btn, str)
    Controller:CloseSelf()
  end,
  OilUpWindow_Group_Three_Btn_Cancer_Click = function(btn, str)
    Controller:CloseSelf()
  end,
  OilUpWindow_Group_Three_Btn_Up_Click = function(btn, str)
    Controller:ConfirmUpClick()
  end,
  OilUpWindow_Group_UseMaterial_Group_Consume1_Group_Item_Btn_Item_Click = function(btn, str)
    local id = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(id)
  end,
  OilUpWindow_Group_UseMaterial_Group_Consume2_Group_Item_Btn_Item_Click = function(btn, str)
    local id = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(id)
  end,
  OilUpWindow_Group_UseMaterial_Group_Consume3_Group_Item_Btn_Item_Click = function(btn, str)
    local id = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(id)
  end
}
return ViewFunction
