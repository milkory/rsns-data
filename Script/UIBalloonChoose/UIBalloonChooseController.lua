local DataModel = require("UIBalloonChoose/UIBalloonChooseDataModel")
local Controller = {}

function Controller.Click(index)
  local cfg = DataModel.BalloonCfg[index]
  local id = cfg.id
  DataModel.InitData.itemId = id
  local serverNum = PlayerData:GetItemById(id).num
  if serverNum <= 0 then
    CommonTips.OpenTips(80601884)
  else
    UIManager:Open("UI/MainUI/BalloonTips", Json.encode(DataModel.InitData))
  end
end

return Controller
