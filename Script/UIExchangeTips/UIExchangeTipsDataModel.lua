local View = require("UIExchangeTips/UIExchangeTipsView")
local DataModel = {}

function DataModel:Init(param)
  local ca = PlayerData:GetFactoryData(param.commodityId)
  self.commodityCA = ca
  self.shopId = param.shopId
  self.index = param.index
  self.remainNum = param.remainNum
  self.curSelectNum = nil
  self.cost = {}
  self:RefreshMaxNum()
  self:SetSelectNum(1)
end

function DataModel:RefreshMaxNum()
  local moneyList = self.commodityCA.moneyList
  local groupItem = View.Group_Exchange
  local maxNum
  for i = 1, groupItem.self.transform.childCount - 2 do
    local isShow = i <= #moneyList
    local groupConsume = groupItem["Group_Item" .. i]
    groupConsume.self:SetActive(isShow)
    if isShow then
      local moneyCA = PlayerData:GetFactoryData(moneyList[i].moneyID)
      groupConsume.Img_Item:SetSprite(moneyCA.iconPath or moneyCA.imagePath)
      groupConsume.Img_Bottom:SetSprite(UIConfig.BottomConfig[moneyCA.qualityInt + 1])
      groupConsume.Img_Mask:SetSprite(UIConfig.MaskConfig[moneyCA.qualityInt + 1])
      groupConsume.Btn_Item:SetClickParam(moneyCA.id)
      local needNum = moneyList[i].moneyNum
      local haveNum = PlayerData:GetGoodsById(moneyList[i].moneyID).num
      if maxNum ~= nil then
        maxNum = math.min(maxNum, math.floor(haveNum / needNum))
      else
        maxNum = math.floor(haveNum / needNum)
      end
    end
  end
  groupItem.Group_ExchangeItem.Img_Item:SetSprite(self.commodityCA.commodityView)
  groupItem.Group_ExchangeItem.Img_Bottom:SetSprite(UIConfig.BottomConfig[self.commodityCA.qualityInt + 1])
  groupItem.Group_ExchangeItem.Img_Mask:SetSprite(UIConfig.MaskConfig[self.commodityCA.qualityInt + 1])
  groupItem.Group_ExchangeItem.Btn_Item:SetClickParam(self.commodityCA.commodityItemList[1].id)
  if self.remainNum ~= -1 then
    self.maxNum = math.min(maxNum, self.remainNum)
  else
    self.maxNum = maxNum
  end
  View.Group_Slider.Group_Num.Txt_Possess:SetText(self.maxNum)
end

function DataModel:SetSelectNum(num)
  if num == self.curSelectNum then
    return
  end
  self.curSelectNum = num
  self:RefreshSelectNumView()
  self._isSliderChanging = true
  View.Group_Slider.Slider_Value:SetSliderValue((num - 1) / math.max(1, self.maxNum - 1))
  self._isSliderChanging = false
end

function DataModel:RefreshSelectNumView()
  local num = self.curSelectNum
  local ca = self.commodityCA
  View.Txt_Dec:SetText(string.format(GetText(80601870), ca.commodityName, ca.commodityNum * num))
  View.Group_Slider.Group_Num.Txt_Select:SetText(num)
  local moneyList = ca.moneyList
  local groupItem = View.Group_Exchange
  for i = 1, #moneyList do
    local groupConsume = groupItem["Group_Item" .. i]
    local costNum = moneyList[i].moneyNum * num
    groupConsume.Txt_Num:SetText(costNum)
    local moneyId = moneyList[i].moneyID
    if moneyId ~= 11400001 then
      self.cost[moneyId] = costNum
    end
  end
  groupItem.Group_ExchangeItem.Txt_Num:SetText(num * ca.commodityNum)
end

function DataModel:OnSliderValue(percent)
  if self._isSliderChanging == true then
    return
  end
  local newUseNum = math.ceil(math.max(self.maxNum - 1, 1) * percent + 1)
  newUseNum = math.min(self.maxNum, math.max(1, newUseNum))
  self.curSelectNum = newUseNum
  self:RefreshSelectNumView()
end

return DataModel
