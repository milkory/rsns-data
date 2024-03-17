local View = require("UIHomeCapsule/UIHomeCapsuleView")
local DataModel = require("UIHomeCapsule/UIHomeCapsuleDataModel")
local HomeStoreDataModel = require("UIHomeCapsule/UIHomeStoreDataModel")
local HomeStoreController = require("UIHomeCapsule/UIHomeStoreController")
local Controller = {}

function Controller:Init(defaultSelect)
  DataModel.Init()
  for i = 1, 5 do
    local element = View.Group_ND.Group_BQ["Group_" .. i]
    if element ~= nil then
      local data = DataModel.pondInfo[i]
      if data == nil then
        element.self:SetActive(false)
      else
        element.self:SetActive(true)
        element.Group_CZ.self:SetActive(not data.limit)
        element.Group_XS.self:SetActive(data.limit)
        element.Group_CZ.Img_XZ.Txt_Name:SetText(data.ca.themeName)
        element.Group_CZ.Img_WXZ.Txt_Name:SetText(data.ca.themeName)
        element.Group_XS.Img_XZ.Txt_Name:SetText(data.ca.themeName)
        element.Group_XS.Img_WXZ.Txt_Name:SetText(data.ca.themeName)
      end
      element.Group_CZ.Btn_:SetClickParam(i)
      element.Group_XS.Btn_:SetClickParam(i)
    end
  end
  Controller:RefreshCoin()
  if defaultSelect == true then
    Controller:SelectPond(1)
  end
end

function Controller:ChangeToView(type, force)
  if not force and DataModel.viewType == type then
    return
  end
  if type == 1 then
    Net:SendProto("recruit.cap_info", function(json)
      PlayerData.ServerData.user_home_info.pool = json.pool
      View.Group_Zhu.Group_niudan.Img_xuanzhong.self:SetActive(true)
      View.Group_Zhu.Group_niudan.Img_weixuanzhong.self:SetActive(false)
      View.Group_Zhu.Group_shangdian.Img_xuanzhong.self:SetActive(false)
      View.Group_Zhu.Group_shangdian.Img_weixuanzhong.self:SetActive(true)
      View.Group_ND.self:SetActive(true)
      View.Group_HomeStore.self:SetActive(false)
      Controller:Init(true)
    end)
  elseif type == 2 then
    local a, b = PlayerData:OpenStoreCondition()
    if a == false then
      CommonTips.OpenTips(b[1].txt)
      return
    end
    Net:SendProto("shop.info", function(json)
      View.Group_Zhu.Group_niudan.Img_xuanzhong.self:SetActive(false)
      View.Group_Zhu.Group_niudan.Img_weixuanzhong.self:SetActive(true)
      View.Group_Zhu.Group_shangdian.Img_xuanzhong.self:SetActive(true)
      View.Group_Zhu.Group_shangdian.Img_weixuanzhong.self:SetActive(false)
      Controller:RefreshCoin()
      View.Group_ND.self:SetActive(false)
      View.Group_HomeStore.self:SetActive(true)
      HomeStoreController.InitStore()
      HomeStoreDataModel.curIndex = 1
      HomeStoreController:ChooseTab(HomeStoreDataModel.curIndex)
    end)
  end
  DataModel.viewType = type
end

function Controller:ClearView()
  if View.Group_ND.self.IsActive then
    for i = 1, 5 do
      local element = View.Group_ND.Group_BQ["Group_" .. i]
      if element ~= nil then
        element.self:SetActive(false)
      end
    end
    View.Group_ND.Group_ZT.ScrollGrid_PrizeList.grid.self:SetDataCount(0)
  elseif View.Group_HomeStore.self.IsActive then
    View.Group_HomeStore.Group_FurnitureStore.ScrollGrid_List.grid.self:SetDataCount(0)
    View.Group_HomeStore.Group_Right.StaticGrid_BQ.grid.self:RefreshAllElement()
  end
end

function Controller:TimeRefresh()
  Net:SendProto("recruit.cap_info", function(json)
    PlayerData.ServerData.user_home_info.pool = json.pool
    local data = DataModel.pondInfo[DataModel.curSelectIdx]
    local id = data.id
    Controller:Init(false)
    local curSelectIdx = 1
    for k, v in pairs(DataModel.pondInfo) do
      if id == v.id then
        curSelectIdx = k
        break
      end
    end
    Controller:SelectPond(curSelectIdx)
  end)
end

function Controller:RefreshCoin()
  View.Group_JYB.Txt_Num:SetText(DataModel.GetFurnitureMoney())
  View.Group_YN.Txt_Num:SetText(DataModel.GetYNMoney())
end

function Controller:SelectPond(idx, force)
  if not force and DataModel.curSelectIdx == idx then
    return
  end
  DataModel.curSelectIdx = idx
  local element = View.Group_ND.Group_BQ["Group_" .. idx]
  local data = DataModel.pondInfo[idx]
  if data == nil then
    return
  end
  local selectView
  if data.limit then
    selectView = element.Group_XS.Img_XZ
  else
    selectView = element.Group_CZ.Img_XZ
  end
  if DataModel.lastSelectView ~= nil then
    DataModel.lastSelectView.self:SetActive(false)
  end
  selectView.self:SetActive(true)
  DataModel.lastSelectView = selectView
  local imageInfo = data.ca.imageList[1]
  if imageInfo ~= nil then
    View.Group_ND.Img_ND:SetSprite(imageInfo.image)
    View.Group_ND.Img_ND:SetAnchoredPosition(Vector2(imageInfo.x, imageInfo.y))
    View.Group_ND.Img_ND:SetNativeSize()
  end
  View.Group_ND.Group_Pay.Group_Ten.Img_Ten.self:SetActive(not data.limit)
  View.Group_ND.Group_Pay.Group_Ten.Img_TenZhuti.self:SetActive(data.limit)
  View.Group_ND.Group_ZT.Group_TP.Img_Common:SetActive(not data.limit)
  View.Group_ND.Group_ZT.Group_TP.Img_Zhuti:SetActive(data.limit)
  View.Group_ND.Group_Time.self:SetActive(data.limit)
  View.Group_ND.Group_ZT.Btn_Tips:SetActive(not data.limit)
  if data.limit then
    local month = string.sub(data.ca.endTime, 6, 7)
    local day = string.sub(data.ca.endTime, 9, 10)
    local hour = string.sub(data.ca.endTime, 12, 13)
    local min = string.sub(data.ca.endTime, 15, 16)
    View.Group_ND.Group_Time.Txt_FinishTime:SetText(string.format(GetText(80600447), month, day, hour, min))
  end
  View.Group_ND.Group_ZT.Txt_Name:SetText(data.ca.pictureName)
  local temp = data.ca.costList[1]
  local itemCA = PlayerData:GetFactoryData(temp.id, "ItemFactory")
  View.Group_ND.Group_Pay.Group_One.Img_Item:SetSprite(itemCA.buyPath or itemCA.iconPath)
  View.Group_ND.Group_Pay.Group_One.Txt_Num:SetText(string.format(GetText(80600407), temp.num))
  View.Group_ND.Group_Pay.Group_One.Img_OneNot.self:SetActive(data.totalRemainCount == 0)
  View.Group_ND.Group_Pay.Group_One.Btn_1:SetActive(data.totalRemainCount ~= 0)
  View.Group_ND.Group_Pay.Group_One1.Img_Item:SetSprite(itemCA.buyPath or itemCA.iconPath)
  View.Group_ND.Group_Pay.Group_One1.Txt_Num:SetText(string.format(GetText(80600407), temp.num))
  View.Group_ND.Group_Pay.Group_One1.Img_OneNot.self:SetActive(data.totalRemainCount == 0)
  View.Group_ND.Group_Pay.Group_One1.Btn_1:SetActive(data.totalRemainCount ~= 0)
  temp = data.ca.costTenList[1]
  itemCA = PlayerData:GetFactoryData(temp.id, "ItemFactory")
  View.Group_ND.Group_Pay.Group_Ten.Img_Item:SetSprite(itemCA.buyPath or itemCA.iconPath)
  View.Group_ND.Group_Pay.Group_Ten.Txt_Num:SetText(string.format(GetText(80600407), temp.num))
  local count = #data.capsuleList
  View.Group_ND.Group_ZT.ScrollGrid_PrizeList.grid.self:SetDataCount(count)
  View.Group_ND.Group_ZT.ScrollGrid_PrizeList.grid.self:RefreshAllElement()
  Controller:RefreshPickShow()
end

function Controller:OnePick()
  local cb = function()
    Controller:ShowReward()
    Controller:RefreshCoin()
    Controller:RefreshPickShow()
    View.Group_ND.Group_ZT.ScrollGrid_PrizeList.grid.self:RefreshAllElement()
  end
  DataModel.OnePick(cb)
end

function Controller:TenPick()
  local cb = function()
    Controller:ShowReward()
    Controller:RefreshCoin()
    Controller:RefreshPickShow()
    View.Group_ND.Group_ZT.ScrollGrid_PrizeList.grid.self:RefreshAllElement()
  end
  DataModel.TenPick(cb)
end

function Controller:ShowReward()
  if DataModel.rewardShow == nil or #DataModel.rewardShow == 0 then
    return
  end
  local t = {}
  t.clientCustom = DataModel.rewardShow
  CommonTips.OpenShowItem(t)
end

function Controller:RefreshPickShow()
  local data = DataModel.pondInfo[DataModel.curSelectIdx]
  View.Group_ND.Group_Pay.Group_One.self:SetActive(data.totalRemainCount == nil or data.totalRemainCount >= 10)
  View.Group_ND.Group_Pay.Group_One1.self:SetActive(data.totalRemainCount ~= nil and data.totalRemainCount < 10)
  View.Group_ND.Group_Pay.Group_Ten.self:SetActive(data.totalRemainCount == nil or data.totalRemainCount >= 10)
  View.Group_ND.Group_Pay.Group_One1.Img_OneNot.self:SetActive(data.totalRemainCount == 0)
  View.Group_ND.Group_Pay.Group_One1.Btn_1:SetActive(data.totalRemainCount ~= 0)
end

return Controller
