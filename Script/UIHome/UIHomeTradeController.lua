local View = require("UIMainUI/UIMainUIView")
local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
local Controller = {}

function Controller:RefreshResources()
  View.Group_Resources.Group_Home.Txt_Num:SetText(TradeDataModel.GetMoney())
  local homeCommon = require("Common/HomeCommon")
  View.Group_Resources.Group_Energy.Txt_Num:SetText(TradeDataModel.GetActionValue() .. "/" .. homeCommon.GetMaxHomeEnergy())
  View.Group_Resources.Group_Weapon.Txt_Num:SetText(PlayerData:GetGoodsById(11400040).num)
end

function Controller:RefreshTradeBtn()
  local isTravel = TradeDataModel.GetIsTravel()
  local isGarbageStation = not isTravel and TradeDataModel.CurStayCity == 83000011 or false
  View.Group_OutSide.Group_Station.Btn_SellG.self:SetActive(not isTravel and isGarbageStation)
  View.Group_OutSide.Group_Station.Btn_City.self:SetActive(not isTravel)
  View.Group_OutSide.Group_Station.Btn_Build.self:SetActive(not isTravel)
end

function Controller:HandleGarbage()
  Net:SendProto("home.refresh_coach", function(json)
    PlayerData:GetHomeInfo().rubbish_area = json.rubbish_area
    if json.rubbish_area.waste_block <= 0 then
      CommonTips.OpenTips(80601175)
      return
    end
    local home_cfg = PlayerData:GetFactoryData(82900012)
    local unit_cnt = home_cfg.costList[1].num
    local cost_num = unit_cnt * json.rubbish_area.waste_block
    CommonTips.OnPrompt(string.format(GetText(80601150), cost_num), nil, nil, function()
      if cost_num > PlayerData:GetUserInfo().gold then
        CommonTips.OpenTips(80601025)
        return
      end
      Net:SendProto("station.clean", function()
        PlayerData:GetHomeInfo().rubbish_area.waste_block = 0
        View.Group_Common.Group_TopLeft.Btn_Gold.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
        CommonTips.OpenTips(80601247)
      end)
    end)
  end)
end

function Controller:SaleGarbage()
  if #TradeDataModel.StockInfo == 0 then
    CommonTips.OpenTips(80600291)
    return
  end
  local cost = 0
  local saleTable = {}
  for k, v in pairs(TradeDataModel.StockInfo) do
    for k1, v1 in pairs(TradeDataModel.GarbageId) do
      if v.id == v1 then
        local goodsCA = PlayerData:GetFactoryData(v.id, "HomeGoodsFactory")
        local t = {}
        t.id = v.id
        t.num = v.num
        t.cost = goodsCA.rewardsList[1].num
        t.space = goodsCA.space
        cost = cost + t.num * t.cost
        table.insert(saleTable, t)
        break
      end
    end
  end
  CommonTips.OnPrompt(string.format(GetText(80601150), cost), nil, nil, function()
    Net:SendProto("station.clean", function(json)
      CommonTips.OpenShowItem(json.reward)
      TradeDataModel.ConfirmHandleGarbage(saleTable)
      Controller:RefreshResources()
    end)
  end)
end

return Controller
