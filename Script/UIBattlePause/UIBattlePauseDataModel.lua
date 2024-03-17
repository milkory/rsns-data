local DataModel = {}

function DataModel.QuitConfirm()
  local lm = CBus:GetManager(CS.ManagerName.LevelManager)
  if lm.currentLevel.isCanQuit ~= true then
    CommonTips.OpenTips("80600136", false)
    return
  end
  PlayerData.SetIsTest(false)
  lm:GameOver(false)
end

function DataModel.QuitCancel()
  UIManager:GoBack()
  local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
  BattleControlManager:Pause(false)
end

return DataModel
