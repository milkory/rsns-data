local View = require("UIBalloon_Success/UIBalloon_SuccessView")
local DataModel = require("UIBalloon_Success/UIBalloon_SuccessDataModel")
local ViewFunction = {
  Balloon_Success_Group_Tips_Btn_Skip_Click = function(btn, str)
    UIManager:CloseTip("UI/MainUI/Balloon_Success")
  end
}
return ViewFunction
