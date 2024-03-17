local View = require("UINewFuncActivated/UINewFuncActivatedView")
local DataModel = require("UINewFuncActivated/UINewFuncActivatedDataModel")
local Controller = require("UINewFuncActivated/UINewFuncActivatedController")
local ViewFunction = {
  NewFuncActivated_Btn_Close_Click = function(btn, str)
    if #DataModel.ShowInfo == 0 then
      UIManager:GoBack(false)
      return
    end
    Controller:ShowUnlock()
  end
}
return ViewFunction
