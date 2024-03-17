local View = require("UIGroup_AwakeSuccess/UIGroup_AwakeSuccessView")
local DataModel = require("UIGroup_AwakeSuccess/UIGroup_AwakeSuccessDataModel")
local ViewFunction = {
  Group_AwakeSuccess_Btn_Close_Click = function(btn, str)
    View.self:PlayAnim("Awake_Out", function()
      UIManager:GoBack(false, 1)
    end)
  end
}
return ViewFunction
