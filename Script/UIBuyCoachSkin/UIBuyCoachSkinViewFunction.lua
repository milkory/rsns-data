local View = require("UIBuyCoachSkin/UIBuyCoachSkinView")
local DataModel = require("UIBuyCoachSkin/UIBuyCoachSkinDataModel")
local Controller = require("UIBuyCoachSkin/UIBuyCoachSkinController")
local ViewFunction = {
  BuyCoachSkin_Group_Detail_Group_Material_ScrollGrid_Dikuang_SetGrid = function(element, elementIndex)
    Controller:RefreshElement(element, elementIndex)
  end,
  BuyCoachSkin_Group_Detail_Group_Material_ScrollGrid_Dikuang_Group_Item_Img_Dikuang_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickElement(str)
  end,
  BuyCoachSkin_Group_Detail_Btn_Cancel_Click = function(btn, str)
    Controller:ClickCancel()
  end,
  BuyCoachSkin_Group_Detail_Btn_Confirm_Click = function(btn, str)
    Controller:ClickConfirm()
  end
}
return ViewFunction
