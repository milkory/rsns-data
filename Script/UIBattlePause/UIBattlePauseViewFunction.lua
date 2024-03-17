local View = require("UIBattlePause/UIBattlePauseView")
local DataModel = require("UIBattlePause/UIBattlePauseDataModel")
local ViewFunction = {
  BattlePause_Btn_Exit_Click = function(btn, str)
    CommonTips.OnPrompt("80600065", "80600068", "80600067", DataModel.QuitConfirm, DataModel.QuitCancel, false, false, false)
  end,
  BattlePause_Btn_Config_Click = function(btn, str)
    UIManager:GoBack()
    if UIAutoBattle.IsAutoBattleAvailable() then
      UIManager:Open("UI/Battle/AutoBattle/AutoBattle")
    else
      CommonTips.OnPrompt("80602391", "80600068", "80600067", DataModel.QuitCancel, DataModel.QuitCancel, false, false, false)
    end
  end,
  BattlePause_Btn_Resume_Click = function(btn, str)
    DataModel.QuitCancel()
  end,
  BattlePause_Btn_BG_Click = function(btn, str)
    print_r("test")
    DataModel.QuitCancel()
  end
}
return ViewFunction
