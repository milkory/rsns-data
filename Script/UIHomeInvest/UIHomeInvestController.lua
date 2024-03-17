local View = require("UIHomeInvest/UIHomeInvestView")
local DataModel = require("UIHomeInvest/UIHomeInvestDataModel")
local NPCDialog = require("Common/NPCDialog")
local Controller = {}

function Controller:Init()
  View.self:PlayAnim("In")
  View.Group_Invest.self:SetActive(false)
  View.Group_Main.self:SetActive(true)
  View.Img_BG:SetSprite(DataModel.BgPath)
  View.Img_BG:SetColor(DataModel.BgColor)
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_Main.Group_NpcInfo.Group_Dingwei.Txt_Station:SetText(stationCA.name)
  Controller:SetNPC()
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
end

function Controller:ShowInvest()
  Net:SendProto("station.refresh", function(json)
    for k, v in pairs(json.stations) do
      for k1, v1 in pairs(v) do
        PlayerData:GetHomeInfo().stations[k][k1] = v1
      end
    end
    View.self:PlayAnim("InvestList")
    DataModel.serverStationData = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)]
    DataModel.DevDegree = PlayerData:GetHomeInfo().dev_degree[tostring(DataModel.StationId)].dev_degree or 0
    if DataModel.serverStationData.invest == nil then
      DataModel.serverStationData.invest = {}
    end
    DataModel.TotalTZ = DataModel.GetTotalTZ()
    DataModel.InitData()
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.investText)
    View.Group_Main.self:SetActive(false)
    UIManager:LoadSplitPrefab(View, "UI/HomeInvest/HomeInvest", "Group_Invest")
    View.Group_Invest.self:SetActive(true)
    local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
    View.Group_Invest.Group_Zhu.Group_Dingwei.Txt_Station:SetText(stationCA.name)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.SetReputationElement(View.Group_Invest.Group_Zhu.Group_Reputation, DataModel.StationId)
    View.Group_Invest.Group_Ding.Img_BG.Group_TZZE.Txt_Tips:SetText(DataModel.TotalTZ)
    View.Group_Invest.ScrollGrid_Level.grid.self:SetDataCount(#DataModel.InvestList)
    View.Group_Invest.ScrollGrid_Level.grid.self:RefreshAllElement()
    Controller:RefreshResource()
  end, DataModel.StationId)
end

function Controller:ReturnToMain()
  View.self:PlayAnim("Main")
  View.Group_Invest.self:SetActive(false)
  View.Group_Main.self:SetActive(true)
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
end

function Controller:DoInvest(idx)
  local info = DataModel.InvestList[idx]
  local costInfo = info.costList[1]
  if PlayerData:GetGoodsById(costInfo.id).num < costInfo.num then
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.ItemText)
    return
  end
  Net:SendProto("station.invest", function(json)
    if PlayerData.TempCache.repLvUpCache ~= nil then
      DataModel.CurRepLv = PlayerData.TempCache.repLvUpCache.repLv
    end
    CommonTips.OpenShowItem(json.reward, function()
      CommonTips.OpenRepLvUp()
    end)
    DataModel.InvestList[idx].remainNum = DataModel.InvestList[idx].remainNum - 1
    DataModel.AllNoInvest = false
    DataModel.DevDegree = PlayerData:GetHomeInfo().dev_degree[tostring(DataModel.StationId)].dev_degree or 0
    local enum = DataModel.NPCDialogEnum.investOneText
    if costInfo.num >= 1000000 then
      enum = DataModel.NPCDialogEnum.investSixText
    elseif costInfo.num >= 500000 then
      enum = DataModel.NPCDialogEnum.investFiveText
    elseif costInfo.num >= 400000 then
      enum = DataModel.NPCDialogEnum.investFourText
    elseif costInfo.num >= 300000 then
      enum = DataModel.NPCDialogEnum.investThreeText
    elseif costInfo.num >= 200000 then
      enum = DataModel.NPCDialogEnum.investTwoText
    elseif costInfo.num >= 100000 then
      enum = DataModel.NPCDialogEnum.investOneText
    end
    Controller:ShowNPCTalk(enum)
    local serverDetail = DataModel.serverStationData.invest[tostring(idx - 1)]
    if serverDetail == nil then
      serverDetail = {}
      serverDetail.cost = 0
      serverDetail.cnt = 0
      DataModel.serverStationData.invest[tostring(idx - 1)] = serverDetail
    end
    serverDetail.cost = serverDetail.cost + costInfo.num
    serverDetail.cnt = serverDetail.cnt + 1
    DataModel.TotalTZ = DataModel.GetTotalTZ()
    Controller:RefreshResource()
    View.Group_Invest.Group_Ding.Img_BG.Group_TZZE.Txt_Tips:SetText(DataModel.TotalTZ)
    View.Group_Invest.ScrollGrid_Level.grid.self:RefreshAllElement()
    local homeCommon = require("Common/HomeCommon")
    homeCommon.SetReputationElement(View.Group_Invest.Group_Zhu.Group_Reputation, DataModel.StationId)
  end, idx - 1)
end

function Controller:ItemUseRefresh()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local info = homeConfig.investMoneyList[1]
  local t = {}
  t.itemId = info.id
  t.useNum = info.num
  t.itemNum = PlayerData:GetGoodsById(info.id).num
  local itemCA = PlayerData:GetFactoryData(t.itemId, "ItemFactory")
  CommonTips.OnItemPrompt(string.format(GetText(80600688), itemCA.name), t, function()
    if t.itemNum < t.useNum then
      CommonTips.OpenTips(80600488)
      return
    end
    if DataModel.AllNoInvest then
      CommonTips.OpenTips(80600689)
      return
    end
    Net:SendProto("station.refresh_invest", function(json)
      local t = {}
      t[info.id] = info.num
      PlayerData:RefreshUseItems(t)
      for k, v in pairs(DataModel.InvestList) do
        v.remainNum = v.limitNum
      end
      for k, v in pairs(DataModel.serverStationData.invest) do
        v.cnt = 0
      end
      View.Group_Invest.ScrollGrid_Level.grid.self:RefreshAllElement()
    end)
  end)
end

function Controller:RefreshResource()
  View.Group_Invest.Group_Ding.Btn_YN.Txt_Num:SetText(PlayerData:GetGoodsById(11400001).num)
  View.Group_Invest.Group_Ding.Group_FZ.Txt_Tips:SetText(string.format("%.0f", DataModel.DevDegree))
end

function Controller:ShowTradePermission()
  View.Group_Invest.Group_XK.self:SetActive(true)
  View.Group_Invest.Group_XK.ScrollGrid_List.grid.self:SetDataCount(#DataModel.TradePermissionGoods)
  View.Group_Invest.Group_XK.ScrollGrid_List.grid.self:RefreshAllElement()
end

function Controller:SetNPC()
  NPCDialog.SetNPC(View.Group_NPC, DataModel.NpcId)
  local HomeCommon = require("Common/HomeCommon")
  local repLv = HomeCommon.GetRepLv(DataModel.StationId)
  NPCDialog.HandleNPCTxtTable({repLv = repLv})
end

function Controller:ShowNPCTalk(dialogEnum)
  local npcConfig = PlayerData:GetFactoryData(DataModel.NpcId, "NPCFactory")
  local textTable = npcConfig[dialogEnum]
  if textTable == nil then
    return
  end
  NPCDialog.SetNPCText(View.Group_NPC, textTable, dialogEnum)
end

return Controller
