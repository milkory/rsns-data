local View = require("UIUseTips/UIUseTipsView")
local DataModel = {}
DataModel.OtherItemCommoditData = {}
DataModel.currentOtherNum = 0
DataModel.EnumOtherBtnType = {
  Add = 1,
  Subtraction = 2,
  Max = 3,
  Min = 4
}
local SetOtherItem = function(element, data, isDetail)
  local Group_Item = element.Group_Item
  Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.qualityInt + 1])
  Group_Item.Img_Item:SetSprite(data.iconPath)
  Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[data.qualityInt + 1])
  element.Txt_Name:SetText(data.name)
end

function DataModel:OpenOtherBuyTips(isOpen, data)
  if isOpen then
    DataModel.OtherItemCommoditData = data
    self.SetOtherNumBtn(self, DataModel.EnumOtherBtnType.Min)
    SetOtherItem(View.Group_Other, DataModel.CA)
    View.Group_Other.Group_Slider.Slider_Value:SetMinAndMaxValue(1, data.num)
    if data.num == 1 then
      View.Group_Other.Group_Slider.Slider_Value:SetMinAndMaxValue(0, data.num)
    end
  else
    UIManager:GoBack(false, 1)
  end
end

local SetOtherNum = function(maxNum)
  local num = DataModel.currentOtherNum
  View.Group_Other.Group_Slider.Group_Num.Txt_Select:SetText(math.ceil(num))
  View.Group_Other.Group_Slider.Group_Num.Txt_Possess:SetText(maxNum)
  View.Group_Other.Group_Slider.Slider_Value:SetSliderValue(num)
end

function DataModel:SetOtherNumBtn(btnType)
  local maxNum = DataModel.ItemInfo.num
  local num = DataModel.currentOtherNum
  if btnType == DataModel.EnumOtherBtnType.Add then
    if maxNum > num then
      num = num + 1
    else
      return
    end
  elseif btnType == DataModel.EnumOtherBtnType.Subtraction then
    if 1 < num then
      num = num - 1
    else
      return
    end
  elseif btnType == DataModel.EnumOtherBtnType.Max then
    num = maxNum
  elseif btnType == DataModel.EnumOtherBtnType.Min then
    num = 1
  end
  DataModel.currentOtherNum = num
  SetOtherNum(maxNum)
end

function DataModel:SetOtherSlider(value)
  if DataModel.ItemInfo.num == 1 then
    return
  end
  DataModel.currentOtherNum = value
  SetOtherNum(DataModel.ItemInfo.num)
end

function DataModel:Recycled()
  Net:SendProto("item.recycled", function(json)
    PlayerData:RefreshUseItems({
      [DataModel.ItemInfo.id] = math.ceil(DataModel.currentOtherNum)
    })
    CommonTips.OpenShowItem(json.reward, UIManager:GoBack())
  end, DataModel.ItemInfo.id, DataModel.currentOtherNum)
end

DataModel.EnergyCommoditData = {}
DataModel.currentNum = 0
DataModel.EnumEnergyBtnType = {
  Add = 1,
  Subtraction = 2,
  Max = 3,
  Min = 4
}
local SetEnergyItem = function(element, data)
  local Group_ItemEnergy = element.Group_ItemEnergy
  Group_ItemEnergy.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.qualityInt + 1])
  Group_ItemEnergy.Img_Item:SetSprite(data.iconPath)
  Group_ItemEnergy.Img_Mask:SetSprite(UIConfig.MaskConfig[data.qualityInt + 1])
  element.Txt_TitleItem:SetText(data.name)
end

function DataModel:OpenEnergyTips(isOpen, data)
  if isOpen then
    DataModel.EnergyCommoditData = data
    self.SetEnergyNumBtn(self, DataModel.EnumEnergyBtnType.Min, View.Group_Energy.Group_Des)
    SetEnergyItem(View.Group_Energy.Group_Des, DataModel.CA)
    View.Group_Energy.Group_Num.Group_Slider.Slider_Value:SetMinAndMaxValue(1, DataModel.ChangeMaxNum)
    if data.num == 1 or DataModel.ChangeMaxNum == 1 then
      View.Group_Energy.Group_Num.Group_Slider.Slider_Value:SetMinAndMaxValue(0, DataModel.ChangeMaxNum)
    end
  else
    UIManager:GoBack(false, 1)
  end
end

local SetEnergyNum = function(maxNum)
  local num = DataModel.currentNum
  View.Group_Energy.Img_Num.Txt_Num:SetText(string.format(GetText(80602056), DataModel.ItemInfo.num))
  View.Group_Energy.Group_Num.Group_Slider.Group_Num.Txt_Select:SetText(math.ceil(num))
  View.Group_Energy.Group_Num.Group_Slider.Group_Num.Txt_Possess:SetText(maxNum)
  local Group_Change = View.Group_Energy.Group_Change
  if DataModel.CA.batchUsetype == "Tired" then
    Group_Change.Txt_BeforeDes:SetText(GetText(80602057))
    Group_Change.Txt_AfterDes:SetText(GetText(80602058))
    Group_Change.Txt_BeforeNum:SetText(PlayerData:GetUserInfo().move_energy)
    local now_num = math.ceil(PlayerData:GetUserInfo().move_energy - DataModel.ChangeNum * num)
    Group_Change.Txt_AfterNum:SetText(now_num < 0 and 0 or now_num)
  else
    Group_Change.Txt_BeforeDes:SetText(GetText(80602059))
    Group_Change.Txt_AfterDes:SetText(GetText(80602060))
    Group_Change.Txt_BeforeNum:SetText(PlayerData:GetUserInfo().energy)
    local now_num = PlayerData:GetUserInfo().energy + DataModel.ChangeNum * num
    Group_Change.Txt_AfterNum:SetText(math.ceil(now_num))
  end
  if DataModel.CA.batchUsetype == "Energy" then
    View.Group_Energy.Group_Des.Txt_Des:SetText(string.format(GetText(80600497), DataModel.ChangeNum))
  elseif DataModel.CA.exchangeList and DataModel.CA.exchangeList[1] then
    View.Group_Energy.Group_Des.Txt_Des:SetText(string.format(GetText(80601512), DataModel.CA.exchangeList[1].num))
  end
  if DataModel.CA.id == 11400065 then
    View.Group_Energy.Group_Des.Txt_Des:SetText(GetText(80601972))
  end
  View.Group_Energy.Group_Num.Group_Slider.Slider_Value:SetSliderValue(num)
end

function DataModel:SetEnergyNumBtn(btnType, element)
  local maxNum = DataModel.ChangeMaxNum
  local num = DataModel.currentNum
  if btnType == DataModel.EnumEnergyBtnType.Add then
    if maxNum > num then
      num = num + 1
    else
      return
    end
  elseif btnType == DataModel.EnumEnergyBtnType.Subtraction then
    if 1 < num then
      num = num - 1
    else
      return
    end
  elseif btnType == DataModel.EnumEnergyBtnType.Max then
    num = maxNum
  elseif btnType == DataModel.EnumEnergyBtnType.Min then
    num = 1
  end
  DataModel.currentNum = num
  SetEnergyNum(maxNum)
end

function DataModel:SetEnergySlider(value)
  if DataModel.ItemInfo.num == 1 then
    return
  end
  DataModel.currentNum = value
  SetEnergyNum(DataModel.ChangeMaxNum)
end

function DataModel:UseEnergy()
  local connect = ","
  local itemType = 0
  local num
  if DataModel.Index == 1 then
    num = DataModel.currentNum
  else
    num = DataModel.currentOtherNum
  end
  num = math.ceil(num)
  local id = DataModel.ItemInfo.id
  local itemList = {}
  if DataModel.Data.limitedId then
    id = DataModel.Data.limitedId
    itemType = 1
    if 1 < num then
      id = ""
      for i = 1, table.count(DataModel.LimitedTimeData.uid) do
        if i <= num then
          local itemid = DataModel.LimitedTimeData.uid[i]
          if itemid ~= "" then
            table.insert(itemList, itemid)
            id = id .. itemid .. connect
          end
        end
      end
      if id ~= "" then
        id = string.sub(id, 1, string.len(id) - 1)
      end
    end
  end
  local move_energy = PlayerData:GetUserInfo().move_energy
  Net:SendProto("item.use_items", function(json)
    if table.count(itemList) > 0 then
      for k, v in pairs(itemList) do
        PlayerData:RefreshUseItems({
          [v] = 1
        })
      end
    else
      PlayerData:RefreshUseItems({
        [id] = num
      })
    end
    UIManager:GoBack()
    if DataModel.CA.batchUsetype == "Tired" then
      CommonTips.OpenTips(string.format(GetText(80601513), DataModel.ChangeNum * num > move_energy and move_energy or DataModel.ChangeNum * num))
    else
      CommonTips.OpenShowItem(json.reward)
    end
  end, id, num, nil, itemType)
end

return DataModel
