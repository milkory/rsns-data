local View = require("UIBalloonChoose/UIBalloonChooseView")
local DataModel = require("UIBalloonChoose/UIBalloonChooseDataModel")
local Controller = require("UIBalloonChoose/UIBalloonChooseController")
local ViewFunction = {
  BalloonChoose_Btn_BG_Click = function(btn, str)
    View.self:CloseUI()
  end,
  BalloonChoose_Group_Balloon_Group_Choose1_Btn_Bg_Click = function(btn, str)
    Controller.Click(1)
  end,
  BalloonChoose_Group_Balloon_Group_Choose2_Btn_Bg_Click = function(btn, str)
    Controller.Click(2)
  end
}
return ViewFunction
