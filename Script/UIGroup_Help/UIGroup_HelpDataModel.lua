local DataModel = {}

function DataModel.initData(helpId)
  local cfg = PlayerData:GetFactoryData(helpId)
  DataModel.title = GetText(cfg.helpTitle)
  DataModel.helpList = cfg.help
  DataModel.selectIndex = 1
end

return DataModel
