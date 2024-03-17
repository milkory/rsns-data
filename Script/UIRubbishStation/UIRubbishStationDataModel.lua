local DataModel = {}
local View = require("UIRubbishStation/UIRubbishStationView")
local sortData = function()
  table.sort(DataModel.integralList, function(t1, t2)
    local status1 = DataModel.integralInfoData[t1.index]
    local status2 = DataModel.integralInfoData[t2.index]
    if status1 ~= status2 then
      return status1 > status2
    end
    return t1.integral < t2.integral
  end)
end

function DataModel.initData(info)
  DataModel.isRecyclePanel = info.isRecyclePanel
  DataModel.isCityMapIn = info.isCityMapIn
  DataModel.buildingId = info.buildingId
  if info.isRecyclePanel then
    return
  end
  local buildCfg = PlayerData:GetFactoryData(info.buildingId)
  DataModel.StationId = buildCfg.stationId
  DataModel.NpcId = buildCfg.npcId
  DataModel.BgPath = buildCfg.bgPath
  DataModel.BgColor = buildCfg.bgColor or "FFFFFF"
  DataModel.integralList = buildCfg.integralRewardList
  DataModel.integralInfoData = {}
  DataModel.canReceiveCnt = 0
  local env_pro = PlayerData:GetHomeInfo().env_pro or {}
  DataModel.UpdataIntegralList(env_pro)
  DataModel.StationList = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)]
  DataModel.StationCA = PlayerData:GetFactoryData(DataModel.StationId)
end

function DataModel.UpdataRubishData(rubbish_area)
  PlayerData:GetHomeInfo().rubbish_area = rubbish_area
  DataModel.rubbish_cnt = rubbish_area.waste_block
  local unit_price = PlayerData:GetFactoryData(82900012).rewardsList[1].num
  DataModel.rubbish_price = unit_price * DataModel.rubbish_cnt
end

function DataModel.UpdataIntegralList(env_pro)
  PlayerData:GetHomeInfo().env_pro = env_pro
  DataModel.canReceiveCnt = 0
  DataModel.allIntegral = env_pro.env_points or 0
  for i, v in ipairs(DataModel.integralList) do
    if DataModel.allIntegral >= v.integral then
      local isRecived = false
      for k1, v1 in pairs(env_pro.reward) do
        if v1 == v.index - 1 then
          isRecived = true
          break
        end
      end
      if isRecived == false then
        DataModel.canReceiveCnt = DataModel.canReceiveCnt + 1
      end
      DataModel.integralInfoData[v.index] = isRecived and -1 or 1
    else
      DataModel.integralInfoData[v.index] = 0
    end
  end
  sortData()
  local redName = RedPointNodeStr.RedPointNodeStr.RubbishStationLevel
  if DataModel.canReceiveCnt > 0 then
    if RedpointTree:GetRedpointCnt(redName) == 0 then
      RedpointTree:ChangeRedpointCnt(redName, 1)
    end
  else
    RedpointTree:ChangeRedpointCnt(redName, -1)
  end
end

function DataModel:OpenConstructStage()
  local row = {}
  for k, v in pairs(DataModel.ConstructNowCA) do
    row[k] = v
  end
  row.ConstructMaxNum = DataModel.ConstructMaxNum
  row.ConstructNowNum = DataModel.ConstructNowNum
  row.Index_Construct = DataModel.Index_Construct
  row.stationId = DataModel.StationId
  CommonTips.OpenConstructStage(row)
end

function DataModel:RefreshLeftData(first)
  DataModel.ConstructMaxNum = 0
  DataModel.ConstructNowNum = 0
  DataModel.ConstructNowCA = {}
  DataModel.StationState = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].state
  for k, v in pairs(DataModel.StationList.construction) do
    DataModel.ConstructNowNum = DataModel.ConstructNowNum + v.proportion
  end
  local count = 0
  for i = 1, #DataModel.StationCA.constructStageList do
    local row = DataModel.StationCA.constructStageList[i]
    DataModel.ConstructMaxNum = DataModel.ConstructMaxNum + row.constructNum
    DataModel.ConstructNowCA = row
    count = i
    if row.state and row.state ~= -1 and DataModel.ConstructNowNum >= DataModel.ConstructMaxNum and DataModel.StationState < row.state then
      DataModel.StationState = row.state
      PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].state = row.state
    end
    if DataModel.ConstructNowNum <= DataModel.ConstructMaxNum then
      break
    end
  end
  DataModel.Index_Construct = count
  local Group_Zhu = View.Group_Zhu
  local row_config = DataModel.StationCA.constructStageList[count]
  local row_server = DataModel.StationList.construction[count]
  Group_Zhu.Group_Dingwei.Txt_Station:SetText(DataModel.StationCA.name)
  local Group_Construct = Group_Zhu.Group_Construct
  Group_Construct.Txt_Num:SetText(row_server.proportion .. "/" .. row_config.constructNum)
  Group_Construct.Txt_Dec:SetText(DataModel.ConstructNowCA.name)
  Group_Construct.Img_PB:SetFilledImgAmount(row_server.proportion / row_config.constructNum)
  Group_Construct.Btn_Construct:SetSprite(DataModel.StationCA.constructIconPath)
  Group_Construct.Img_RedPoint:SetActive(false)
  local stageRewardList = PlayerData:GetFactoryData(DataModel.ConstructNowCA.id).stageRewardList
  local count = 0
  for k, v in pairs(stageRewardList) do
    if v.construct <= DataModel.ConstructNowNum and row_server.rec_index[k] == nil then
      count = count + 1
    end
  end
  if count ~= 0 then
    Group_Construct.Img_RedPoint:SetActive(true)
  end
end

return DataModel
