local DataModel = require("UITestLevel/UITestLevelDataModel")
local DataController = require("UITestLevel/UITestLevelDataController")
local View = require("UITestLevel/UITestLevelView")
local ViewFunction = {
  TestLevel_Group_TestLevel_Btn_Energy_Click = function(btn, str)
    DataModel.maxCost = not DataModel.maxCost
  end,
  TestLevel_Group_TestLevel_Btn_CaptainSkill_Click = function(btn, str)
    DataModel.unlimitedLeaderCondition = not DataModel.unlimitedLeaderCondition
    if DataModel.unlimitedLeaderCondition == true then
      DataController.ClearLeaderCardCondition()
    else
      DataController.SetLeaderCardCondition()
    end
  end,
  TestLevel_Group_TestLevel_Btn_Refresh_Click = function(btn, str)
    DataModel.refreshCardNoDelay = not DataModel.refreshCardNoDelay
  end,
  TestLevel_Group_TestLevel_Btn_Reset_Click = function(btn, str)
    DataController.ResetStatistics()
  end,
  TestLevel_Group_TestLevel_Btn_Detail_Click = function(btn, str)
    UIManager:Open("UI/Battle/TestLevelDetail", Json.encode(DataModel.RecordDetail))
  end,
  TestLevel_Group_TestLevel_Btn_Hide_Click = function(btn, str)
    DataModel.isExpand = not DataModel.isExpand
    if DataModel.isExpand then
      View.self:PlayAnim("IN")
    else
      View.self:PlayAnim("HIDE")
    end
  end
}
return ViewFunction
