local View = require("UIHomeTrade/UIHomeTradeView")
local DataModel = require("UIHomeTrade/UIWarehouseDataModel")
local MainDataModel = require("UIHomeTrade/UIHomeTradeDataModel")
local MainController = require("UIHomeTrade/UIHomeTradeController")
local Controller = {}

function Controller:Init()
  View.self:PlayAnim("Warehouse")
  View.Group_Main.self:SetActive(false)
  UIManager:LoadSplitPrefab(View, "UI/HomeTrade/HomeTrade", "Group_Warehouse")
  View.Group_Warehouse.self:SetActive(true)
  DataModel.Init()
  MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.openWarehouseText)
  Controller:RefreshTopShow()
  local homeCommon = require("Common/HomeCommon")
  homeCommon.SetReputationElement(View.Group_Warehouse.Group_Reputation, MainDataModel.StationId)
  local stationCA = PlayerData:GetFactoryData(MainDataModel.StationId, "HomeStationFactory")
  View.Group_Warehouse.Group_NpcInfoL.Group_Station.Txt_Station:SetText(stationCA.name)
  Controller:RefreshCurGoodsBatchMode(2)
  Controller:RefreshStationGoodsBatchMode(2)
  Controller:RefreshCurGoodsShow()
  Controller:RefreshStationGoodsShow()
end

function Controller:RefreshTopShow()
  View.Group_Warehouse.Group_Resources.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetGoodsById(11400001).num)
  local remainCount = DataModel.GetRemainStationSpace()
  View.Group_Warehouse.Group_Resources.Group_TradeLv.Txt_Num:SetText(string.format(GetText(80601085), remainCount))
  View.Group_Warehouse.Group_Saveget.Group_Warehouse.Btn_Add.self:SetActive(remainCount ~= 0)
  View.Group_Warehouse.Group_Saveget.Group_Warehouse.Btn_NotAdd.self:SetActive(remainCount == 0)
end

function Controller:RefreshCurGoodsShow()
  if #DataModel.CurGoods == 0 then
    View.Group_Warehouse.Group_Saveget.Group_Train.Img_Kong:SetActive(true)
    View.Group_Warehouse.Group_Saveget.Group_Train.ScrollGrid_GoodsList.self:SetActive(false)
  else
    View.Group_Warehouse.Group_Saveget.Group_Train.Img_Kong:SetActive(false)
    View.Group_Warehouse.Group_Saveget.Group_Train.ScrollGrid_GoodsList.self:SetActive(true)
    View.Group_Warehouse.Group_Saveget.Group_Train.ScrollGrid_GoodsList.grid.self:SetDataCount(#DataModel.CurGoods)
    View.Group_Warehouse.Group_Saveget.Group_Train.ScrollGrid_GoodsList.grid.self:RefreshAllElement()
  end
  Controller:RefreshCurGoodsSpace()
end

function Controller:RefreshStationGoodsShow()
  if #DataModel.StationGoods == 0 then
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.Img_Kong:SetActive(true)
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.ScrollGrid_GoodsList.self:SetActive(false)
  else
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.Img_Kong:SetActive(false)
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.ScrollGrid_GoodsList.self:SetActive(true)
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.ScrollGrid_GoodsList.grid.self:SetDataCount(#DataModel.StationGoods)
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.ScrollGrid_GoodsList.grid.self:RefreshAllElement()
  end
  Controller:RefreshStationGoodsSpace()
end

function Controller:ClickCurGoods(idx)
  local data = DataModel.CurGoods[idx]
  if data.info.isGoods then
    CommonTips.OpenTips(80601101)
    return
  end
  if DataModel.CurGoodsBatchMode == 1 then
    MainController:OpenBatchPanel(data, idx, 2)
  else
    Controller:CurToStation(idx, data.num)
  end
end

function Controller:CurToStation(idx, num)
  if DataModel.CurToStation(idx, num) then
    Controller:RefreshCurGoodsShow()
    Controller:RefreshStationGoodsShow()
  end
end

function Controller:ClickStationGoods(idx)
  local data = DataModel.StationGoods[idx]
  if DataModel.StationGoodsBatchMode == 1 then
    MainController:OpenBatchPanel(data, idx, 3)
  else
    Controller:StationToCur(idx, data.num)
  end
end

function Controller:StationToCur(idx, num)
  if DataModel.StationToCur(idx, num) then
    Controller:RefreshCurGoodsShow()
    Controller:RefreshStationGoodsShow()
  end
end

function Controller:RefreshCurGoodsBatchMode(mode)
  if DataModel.CurGoodsBatchMode == mode then
    return
  end
  DataModel.CurGoodsBatchMode = mode
  View.Group_Warehouse.Group_Saveget.Group_Train.Btn_Batch.Group_Off.self:SetActive(mode ~= 1)
  View.Group_Warehouse.Group_Saveget.Group_Train.Btn_Max.Group_Off.self:SetActive(mode ~= 2)
  View.Group_Warehouse.Group_Saveget.Group_Train.Btn_Batch.Group_On.self:SetActive(mode == 1)
  View.Group_Warehouse.Group_Saveget.Group_Train.Btn_Max.Group_On.self:SetActive(mode == 2)
end

function Controller:RefreshCurGoodsSpace()
  local element = View.Group_Warehouse.Group_Saveget.Group_Train
  element.Txt_Space:SetText(DataModel.CurGoodsSpace .. "/" .. DataModel.CurGoodsMaxSpace)
  element.Img_PBNow:SetFilledImgAmount(DataModel.CurGoodsSpace / DataModel.CurGoodsMaxSpace)
end

function Controller:RefreshStationGoodsSpace()
  local element = View.Group_Warehouse.Group_Saveget.Group_Warehouse
  element.Txt_Space:SetText(DataModel.StationGoodsSpace .. "/" .. DataModel.StationGoodsMaxSpace)
  element.Img_PBNow:SetFilledImgAmount(DataModel.StationGoodsSpace / DataModel.StationGoodsMaxSpace)
end

function Controller:RefreshStationGoodsBatchMode(mode)
  if DataModel.StationGoodsBatchMode == mode then
    return
  end
  DataModel.StationGoodsBatchMode = mode
  View.Group_Warehouse.Group_Saveget.Group_Warehouse.Btn_Batch.Group_Off.self:SetActive(mode ~= 1)
  View.Group_Warehouse.Group_Saveget.Group_Warehouse.Btn_Max.Group_Off.self:SetActive(mode ~= 2)
  View.Group_Warehouse.Group_Saveget.Group_Warehouse.Btn_Batch.Group_On.self:SetActive(mode == 1)
  View.Group_Warehouse.Group_Saveget.Group_Warehouse.Btn_Max.Group_On.self:SetActive(mode == 2)
end

function Controller:RefreshElement(element, data, idx)
  local btnItem = require("Common/BtnItem")
  btnItem:SetItem(element.Group_Item, {
    id = data.info.id,
    num = data.num
  })
  element.Group_Item.Btn_Item:SetClickParam(idx)
  if element.Img_Order then
    element.Img_Order:SetActive(data.info.isGoods)
    element.Img_Not.self:SetActive(data.info.isGoods)
  end
end

function Controller:ClickExpandSpace()
  View.Group_Warehouse.Group_BuyTips.self:SetActive(true)
  local maxNum, minNum
  local stationId = MainDataModel.StationId
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
    stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  end
  local price = stationCA.buyPrice[1]
  local remainGoodSpace = DataModel.GetRemainStationSpace()
  maxNum = remainGoodSpace
  local canBuyNum = math.floor(PlayerData:GetGoodsById(price.id).num / price.num)
  if maxNum > canBuyNum then
    maxNum = canBuyNum
  end
  if maxNum == 0 then
    maxNum = 1
    DataModel.CanBuySpace = false
  else
    DataModel.CanBuySpace = true
  end
  minNum = 1
  View.Group_Warehouse.Group_BuyTips.Group_Slider.Group_Num.Txt_Select:SetText(minNum)
  View.Group_Warehouse.Group_BuyTips.Group_Slider.Group_Num.Txt_Possess:SetText(maxNum)
  View.Group_Warehouse.Group_BuyTips.Group_Slider.Slider_Value.self:SetMinAndMaxValue(minNum, maxNum, true)
  View.Group_Warehouse.Group_BuyTips.Group_Slider.Slider_Value.self:SetSliderValue(minNum)
  Controller:RefreshBuyTipsMoney(minNum)
  DataModel.BuySpaceNum = minNum
  if not DataModel.CanBuySpace then
    View.Group_Warehouse.Group_BuyTips.Group_Gold.Txt_Num:SetColor("#FF0000")
    View.Group_Warehouse.Group_BuyTips.Group_Gold.Txt_Num:SetText(price.num)
  else
    View.Group_Warehouse.Group_BuyTips.Group_Gold.Txt_Num:SetColor("#FFFFFF")
  end
end

function Controller:RefreshBuyTipsMoney(num)
  View.Group_Warehouse.Group_BuyTips.Group_Slider.Group_Num.Txt_Select:SetText(num)
  local stationCA = PlayerData:GetFactoryData(MainDataModel.StationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationCA = PlayerData:GetFactoryData(stationCA.attachedToCity, "HomeStationFactory")
  end
  local price = stationCA.buyPrice[1]
  View.Group_Warehouse.Group_BuyTips.Group_Gold.Txt_Num:SetText(num * price.num)
end

function Controller:ConfirmExpand()
  if not DataModel.CanBuySpace then
    CommonTips.OpenTips(80600461)
    return
  end
  Net:SendProto("station.expand_warehouse", function(json)
    if json.reward then
      CommonTips.OpenShowItem(json.reward)
    end
    local curSpace = PlayerData:GetHomeInfo().stations[tostring(MainDataModel.StationId)].max_goods_space or 0
    PlayerData:GetHomeInfo().stations[tostring(MainDataModel.StationId)].max_goods_space = curSpace + DataModel.BuySpaceNum
    DataModel.StationGoodsMaxSpace = curSpace + DataModel.BuySpaceNum
    Controller:RefreshTopShow()
    Controller:RefreshStationGoodsSpace()
    local homeCommon = require("Common/HomeCommon")
    homeCommon.SetReputationElement(View.Group_Warehouse.Group_Reputation, MainDataModel.StationId)
    CommonTips.OpenRepLvUp()
    View.Group_Warehouse.Group_BuyTips.self:SetActive(false)
  end, DataModel.BuySpaceNum)
end

function Controller:InnerReturnToMain()
  View.Group_Warehouse.self:SetActive(false)
  View.Group_Main.self:SetActive(true)
  View.self:PlayAnim("Main")
end

function Controller:ReturnToMain()
  DataModel.DealWithGoods(function()
    Controller.InnerReturnToMain(self)
  end)
end

function Controller:GoHome()
  DataModel.DealWithGoods(function()
    UIManager:GoHome()
  end)
end

return Controller
