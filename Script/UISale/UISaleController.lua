local View = require("UISale/UISaleView")
local DataModel = require("UISale/UISaleDataModel")
local Controller = {}

function Controller:RefreshGrid(Type)
  DataModel.SelectTop = Type
  View.Group_Sale.Btn_TabItem.Img_P:SetActive(Type == EnumDefine.Depot.Item)
  View.Group_Sale.ScrollGrid_Items.self:SetActive(Type == EnumDefine.Depot.Item)
  View.Group_Sale.Btn_TabMaterial.Img_P:SetActive(Type == EnumDefine.Depot.Material)
  View.Group_Sale.ScrollGrid_Materials.self:SetActive(Type == EnumDefine.Depot.Material)
  DataModel.Data[Type] = {}
  if Type == EnumDefine.Depot.Item then
    DataModel.SetData(Type, PlayerData:GetItems(), CacheAndGetFactory("ItemFactory"))
    View.Group_Sale.ScrollGrid_Items.grid.self:SetDataCount(#DataModel.Data[Type])
    View.Group_Sale.ScrollGrid_Items.grid.self:RefreshAllElement()
  elseif Type == EnumDefine.Depot.Material then
    DataModel.SetData(Type, PlayerData:GetMaterials(), CacheAndGetFactory("SourceMaterialFactory"))
    View.Group_Sale.ScrollGrid_Materials.grid.self:SetDataCount(#DataModel.Data[Type])
    View.Group_Sale.ScrollGrid_Materials.grid.self:RefreshAllElement()
  end
end

function Controller:SetElement(element, data, isDetail)
  local qualityInt = data.data.qualityInt + 1
  element.Img_Bottom:SetSprite(UIConfig.BottomConfig[qualityInt])
  element.Img_Item:SetSprite(data.data.iconPath)
  element.Img_Mask:SetSprite(UIConfig.MaskConfig[qualityInt])
  if isDetail then
    element.Txt_Num:SetText(data.server.num)
    element.Img_Time:SetActive(data.isDue)
  else
    element.Img_Time:SetActive(false)
  end
end

local num = 0
local info = {}

function Controller:OpenSaleTips(isOpen, data)
  if isOpen then
    info = data
    self.SetNumBtn(self, 3)
    self.SetElement(self, View.Group_SaleTips.Group_Item, info)
    View.Group_SaleTips.Group_Slider.Slider_Value:SetMinAndMaxValue(1, info.server.num)
  end
  View.Group_SaleTips:SetActive(isOpen)
end

function Controller:Sale()
  self.OpenSaleTips(self, false)
  Net:SendProto("item.sell_items", function(json)
    PlayerData:RefreshUseItems({
      [info.id] = math.ceil(num)
    })
    CommonTips.OpenShowItem(json.reward)
    self.RefreshGrid(self, DataModel.SelectTop)
  end, tostring(info.id), math.ceil(num))
end

local SetNum = function(maxNum)
  View.Group_SaleTips.Group_Slider.Group_Num.Txt_Select:SetText(math.ceil(num))
  View.Group_SaleTips.Group_Slider.Group_Num.Txt_Possess:SetText(maxNum)
  local price = num * info.data.rewardList[1].num
  View.Group_SaleTips.Group_Gold.Txt_Num:SetText(math.ceil(price))
end

function Controller:SetNumBtn(index)
  local maxNum = info.server.num
  if index == 0 then
    if maxNum > num then
      num = num + 1
    end
  elseif index == 1 then
    if 1 < num then
      num = num - 1
    end
  elseif index == 2 then
    num = maxNum
  elseif index == 3 then
    num = 1
  end
  SetNum(maxNum)
  View.Group_SaleTips.Group_Slider.Slider_Value:SetSliderValue(num)
end

function Controller:SetSlider(value)
  num = value
  SetNum(info.server.num)
end

function Controller:OpenShowItem()
  local params = {
    itemId = info.id,
    type = EnumDefine.OpenTip.NoDepot
  }
  CommonTips.OpenItem(params)
end

return Controller
