local View = require("UIcargocompartment/UIcargocompartmentView")
local DataModel = require("UIcargocompartment/UIcargocompartmentDataModel")
local ViewFunction = {
  cargocompartment_Btn_tips_Click = function(btn, str)
    View.Group_Tips.self:SetActive(true)
  end,
  cargocompartment_ScrollGrid_list_SetGrid = function(element, elementIndex)
    local data = DataModel.WareHouse.Goods[tonumber(elementIndex)]
    View.Img_goods_1:SetSprite(data.data.imagePath)
    View.Txt_name_1:SetText(data.data.name)
    View.Txt_number_1:SetText("X" .. data.serverData.num)
  end,
  cargocompartment_Btn_shut_Click = function(btn, str)
    UIManager:CloseTip("UI/Cargocompartment/cargocompartment")
  end,
  cargocompartment_Group_Tips_Btn_CloseTips_Click = function(btn, str)
    View.Group_Tips.self:SetActive(false)
  end
}
return ViewFunction
