local View = require("UIStationSaleTips/UIStationSaleTipsView")
local DataModel = {}

function DataModel:Init(param)
  local itemId = param.id
  local ca = PlayerData:GetFactoryData(itemId)
  self.itemCA = ca
  self.curSelectNum = nil
  self.maxNum = PlayerData:GetGoodsById(itemId).num
  View.Group_Slider.Group_Num.Txt_Possess:SetText(self.maxNum)
  View.Txt_Name:SetText(ca.name)
  local groupItem = View.Group_Item
  groupItem.Img_Item:SetSprite(ca.iconPath)
  groupItem.Img_Bottom:SetSprite(UIConfig.BottomConfig[ca.qualityInt + 1])
  groupItem.Img_Mask:SetSprite(UIConfig.MaskConfig[ca.qualityInt + 1])
  groupItem.Btn_Item:SetClickParam(itemId)
  self:SetSelectNum(1)
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
  View.Group_Slider.Group_Num.Txt_Select:SetText(num)
  View.Group_Gold.Txt_Num:SetText(self.itemCA.rewardList[1].num * num)
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
