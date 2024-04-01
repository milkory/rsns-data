local CommonItem = require("Common/BtnItem")
local View = require("UIBuyGiftTips/UIBuyGiftTipsView")
local DataModel = require("UIBuyGiftTips/UIBuyGiftTipsDataModel")
local ViewFunction = require("UIBuyGiftTips/UIBuyGiftTipsViewFunction")
local Init = function()
  DataModel.isEnough = true
  local commoditData = DataModel.Data.commoditData
  local row = DataModel.Data
  View.Img_Gift:SetSprite(commoditData.buyPath)
  View.Txt_Name:SetText(commoditData.name)
  View.Img_chaozhi:SetActive(false)
  if commoditData.superValue ~= 0 then
    View.Img_chaozhi:SetActive(true)
    View.Img_chaozhi.Txt_shuzhi:SetText(string.format(GetText(80602486), commoditData.superValue))
  end
  View.Group_Price:SetActive(false)
  View.Group_Free:SetActive(false)
  View.Group_Cost:SetActive(false)
  if row.isFree == true then
    View.Group_Bottom.Txt_Free:SetActive(true)
  end
  if row.isFree == false then
    if commoditData.buyType == "Money" and commoditData.value ~= 0 then
      View.Group_Price:SetActive(true)
      View.Group_Price.Txt_Price:SetText(string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(commoditData.value, 2)))
    end
    if commoditData.buyType == "Item" and commoditData.buyItemList[1] then
      View.Group_Cost:SetActive(true)
      View.Group_Cost.Img_Icon:SetSprite(PlayerData:GetFactoryData(commoditData.buyItemList[1].id).buyPath)
      View.Group_Cost.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(commoditData.buyItemList[1].num, 2))
      local now_value = PlayerData:GetGoodsById(commoditData.buyItemList[1].id).num
      View.Group_Cost.Txt_Num:SetColor(UIConfig.Color.White)
      if now_value < commoditData.buyItemList[1].num then
        View.Group_Cost.Txt_Num:SetColor(UIConfig.Color.Red)
        DataModel.isEnough = false
      end
    end
  end
  View.Group_Time.self:SetActive(false)
  View.Group_Moon.self:SetActive(false)
  View.Group_LimitNum.self:SetActive(false)
  if commoditData.purchase == true then
    local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
    if typeTxtId ~= nil then
      View.Group_LimitNum:SetActive(true)
      View.Group_LimitNum.Txt_LimitNum:SetText(string.format(GetText(typeTxtId), commoditData.purchaseNum - row.num, commoditData.purchaseNum))
    end
  end
  if commoditData.isTime == true then
    local lastTime = TimeUtil:LastTime(commoditData.endTime)
    if 0 < lastTime then
      local time = TimeUtil:SecondToTable(lastTime)
      View.Group_Time:SetActive(true)
      View.Group_Time.Txt_Time:SetText(string.format(GetText(80601059), time.day, time.hour))
    end
  end
  View.ScrollGrid_List.grid.self:SetActive(false)
  if commoditData.ismonthCard == true then
    View.Group_Moon.self:SetActive(true)
    View.Group_Moon.Group_Time.self:SetActive(false)
    if PlayerData.ServerData.monthly_card and PlayerData.ServerData.monthly_card["11400018"] then
      local t = PlayerData.ServerData.monthly_card["11400018"]
      local diff = 0
      if t.reward_ts then
        if t.reward_ts <= t.deadline then
          diff = t.deadline - t.reward_ts
        end
      else
        if t.reward_date == nil or t.reward_date == "" then
          t.reward_date = os.date("%Y-%m-%d %H:%M:%S", TimeUtil:GetFutureTime(0, 6))
        end
        local lastTime = os.time(TimeUtil:GetTimeTable(t.reward_date))
        if lastTime <= t.deadline then
          diff = t.deadline - lastTime
        end
      end
      if 0 < diff then
        local time = TimeUtil:SecondToTable(diff)
        View.Group_Moon.Group_Time.self:SetActive(true)
        View.Group_Moon.Group_Time.Txt_Time:SetText(string.format(GetText(80601102), time.day - 1))
      end
    end
    local Content = View.Group_Moon.ScrollView_List.Viewport.Content
    for i = 1, 4 do
      local item = "Group_Item" .. i
      local obj = Content[item]
      obj:SetActive(false)
      local showList = DataModel.Data.commoditData.showList
      local row = showList[i]
      if row then
        obj:SetActive(true)
        local ca = PlayerData:GetFactoryData(row.id)
        local num = row.num
        CommonItem:SetItem(obj.Group_Item, row)
        obj.Txt_Name:SetText(ca.name)
        obj.Group_1.Txt_Num:SetText(num)
      end
    end
  elseif commoditData.rewardList ~= nil and table.count(commoditData.rewardList) ~= 0 then
    View.ScrollGrid_List.grid.self:SetActive(true)
    View.ScrollGrid_List.grid.self:SetDataCount(table.count(commoditData.rewardList))
    View.ScrollGrid_List.grid.self:RefreshAllElement()
    View.ScrollGrid_List.grid.self:MoveToTop()
  end
end
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.Data)
  end,
  deserialize = function(initParams)
    DataModel.Data = Json.decode(initParams)
    DataModel.Data.commoditData = PlayerData:GetFactoryData(DataModel.Data.id)
    Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
