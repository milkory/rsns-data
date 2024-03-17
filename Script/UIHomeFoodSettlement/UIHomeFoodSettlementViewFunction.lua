local View = require("UIHomeFoodSettlement/UIHomeFoodSettlementView")
local DataModel = require("UIHomeFoodSettlement/UIHomeFoodSettlementDataModel")
local MainUIController = require("UIMainUI/UIMainUIController")
local ViewFunction = {
  HomeFoodSettlement_Btn_Close_Click = function(btn, str)
    if DataModel.isOutSide then
      UIManager:GoBack()
      if DataModel.hid ~= nil then
        UIManager:Open("UI/HomeFurniture/HomeFoodRate", Json.encode({
          hid = DataModel.hid,
          mealId = DataModel.mealId
        }))
      else
        UIManager:Open("UI/HomeFurniture/HomeFood")
      end
      return
    end
    HomeManager:ClearRole()
    HomeManager:ReSetFoodCam()
    MainUIController:ReShowUI()
    UIManager:GoBack()
    if DataModel.hid ~= nil then
      UIManager:Open("UI/HomeFurniture/HomeFoodRate", Json.encode({
        hid = DataModel.hid,
        mealId = DataModel.mealId
      }))
    else
      UIManager:Open("UI/HomeFurniture/HomeFood")
    end
  end
}
return ViewFunction
