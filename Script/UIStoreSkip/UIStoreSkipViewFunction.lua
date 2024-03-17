local View = require("UIStoreSkip/UIStoreSkipView")
local DataModel = require("UIStoreSkip/UIStoreSkipDataModel")
local ViewFunction = {
  StoreSkip_Btn__Click = function(btn, str)
    UIManager:ClosePanel(true, "UI/CityStore/StoreSkip")
    if DataModel.cb ~= nil then
      DataModel.cb()
    end
  end
}
return ViewFunction
