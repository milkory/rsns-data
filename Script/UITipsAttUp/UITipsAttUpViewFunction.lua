local View = require("UITipsAttUp/UITipsAttUpView")
local DataModel = require("UITipsAttUp/UITipsAttUpDataModel")
local ViewFunction = {
  TipsAttUp_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  TipsAttUp_Group_Show_Group_TAMiddle_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local current = DataModel.RoleAttributeCurrent[tonumber(elementIndex)]
    local next = DataModel.RoleAttributeNext[tonumber(elementIndex)] ~= nil and DataModel.RoleAttributeNext[tonumber(elementIndex)] or "最大等级"
    element.Img_Icon:SetSprite(current.sprite)
    element.Txt_Name:SetText(current.name)
    element.Txt_PreNum:SetText(current.num)
    element.Txt_NextNum:SetText(next)
    element.Txt_PreNum:SetText(PlayerData:GetAttributeShow(current.name, current.num, 2))
    element.Txt_NextNum:SetText(PlayerData:GetAttributeShow(next.name, next.num, 2))
  end
}
return ViewFunction
