local View = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local PlotItem = Class.New("PlotItem", base)
local DataModel = require("UIDialog/UIDialogDataModel")
local maxCount = 4
local itemList

function PlotItem:Ctor()
end

function PlotItem:OnStart(ca)
  View.Group_Item:SetActive(true)
  local item = View.Group_Item.Img_Item
  item:SetLocalPositionOffset(ca.offsetX, ca.offsetY)
  item:SetLocalScale(Vector3(ca.scaleX, ca.scaleY, 1))
  DOTweenTools.DOFadeCallback(item.transform, 0, 1, DataModel.GetCurrentScaleValue(ca.duration), nil, ca.easeInt)
  item:SetSprite(ca.itemPath)
  itemList = ca.list
  local view, isActive
  for i = 1, maxCount do
    view = View.Group_Item.Group_Clues["Group_Clue0" .. tostring(i)]
    isActive = false
    for k, v in pairs(itemList) do
      if v.identifier == i then
        isActive = true
        view:SetLocalPositionOffset(v.offsetX, v.offsetY)
        break
      end
    end
    view:SetActive(isActive)
    if isActive then
      view.Img_Clue:SetActive(false)
    end
  end
end

function PlotItem.GetState()
  return true
end

function PlotItem:Dtor()
end

function PlotItem.ShowClue(identifier)
  for k, v in pairs(itemList) do
    if v.identifier == identifier then
      local view = View.Group_Item.Group_Clues["Group_Clue0" .. tostring(identifier)]
      local isActive = not view.Img_Clue.IsActive
      view.Img_Clue:SetActive(isActive)
      if isActive then
        view.Img_Clue.Txt_Clue:SetText(v.clue)
      end
      break
    end
  end
end

return PlotItem
