local CommonItem = require("Common/BtnItem")
local View = require("UIItemPreTips/UIItemPreTipsView")
local DataModel = require("UIItemPreTips/UIItemPreTipsDataModel")
local ViewFunction = {
  ItemPreTips_Btn_BG_Click = function(btn, str)
    View.self:CloseUI()
  end,
  ItemPreTips_Group_Show_Btn_Access_Click = function(btn, str)
    local data = {}
    data.itemID = DataModel.Id
    data.posX = 270
    data.posY = -180
    View.Group_Show.Btn_Access.Img_On:SetActive(true)
    UIManager:Open("UI/Common/Group_GetWay", Json.encode(data), function()
      View.Group_Show.Btn_Access.Img_On:SetActive(false)
    end)
  end,
  ItemPreTips_Group_Show_ScrollView_Describe_Viewport_Group_Describe_Group_DropList_StaticGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.Data.dropList[tonumber(elementIndex)]
    CommonItem:SetItem(element, row)
    element.Btn_Item:SetClickParam(elementIndex)
  end,
  ItemPreTips_Group_Show_ScrollView_Describe_Viewport_Group_Describe_Group_DropList_StaticGrid_List_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.Data.dropList[tonumber(str)].id)
  end,
  ItemPreTips_Group_Item_Btn_Item_Click = function(btn, str)
  end
}
return ViewFunction
