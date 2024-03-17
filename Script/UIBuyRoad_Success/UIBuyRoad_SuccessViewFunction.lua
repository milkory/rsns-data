local View = require("UIBuyRoad_Success/UIBuyRoad_SuccessView")
local DataModel = require("UIBuyRoad_Success/UIBuyRoad_SuccessDataModel")
local ViewFunction = {
  BuyRoad_Success_Group_Tips_Btn_Skip_Click = function(btn, str)
    UIManager:CloseTip("UI/MainUI/BuyRoad_Success")
  end
}
return ViewFunction
