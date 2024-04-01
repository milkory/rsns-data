local serverDataModel = require("UIServerProgress/UIServerProgressDataModel")
local DataModel = {}
DataModel.curStageIndex = 0
DataModel.curStageCfg = {}
DataModel.finalTargetNum = 100
DataModel.allBuffStage = {}

function DataModel.InitData()
  DataModel.curStageIndex = 0
  DataModel.curStageCfg = {}
  DataModel.finalTargetNum = 100
  DataModel.allBuffStage = {}
  local activityCfg = PlayerData:GetFactoryData(86000001, "ActivityFactory")
  local allStage = activityCfg.ServerProgressList or {}
  local id = allStage[#allStage].id
  if id then
    DataModel.finalTargetNum = PlayerData:GetFactoryData(id, "QuestFactory").num
  end
  for i, v in ipairs(allStage) do
    if 0 < v.buff then
      local t = {}
      t.stageCfg = v
      t.stageIndex = i
      table.insert(DataModel.allBuffStage, t)
    end
  end
  local curStageInfo = serverDataModel.GetCurStageInfo()
  DataModel.curStageIndex = curStageInfo.index
  DataModel.curStageCfg = curStageInfo.cfg
end

return DataModel
