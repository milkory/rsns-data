local View = require("UIFurnitureTips/UIFurnitureTipsView")
local DataModel = require("UIFurnitureTips/UIFurnitureTipsDataModel")
local ViewFunction = {
  FurnitureTips_Btn_BG_Click = function(btn, str)
    UIManager:CloseTip("UI/Home/FurnitureTips")
  end,
  FurnitureTips_Group_Show_StaticGrid_Attr_SetGrid = function(element, elementIndex)
    local info = DataModel.furnitureAttrList[elementIndex]
    element:SetActive(info.param > 0)
    if info.param > 0 then
      element.Txt_Num:SetText(info.param == 0 and 0 or "+" .. info.param)
      element.Group_Attr.Img_Icon:SetSprite(info.iconPath)
      element.Group_Attr.Txt_Name:SetText(info.attrName)
      element:SetAlpha(info.param == 0 and 0.3 or 1)
    end
  end
}
return ViewFunction
