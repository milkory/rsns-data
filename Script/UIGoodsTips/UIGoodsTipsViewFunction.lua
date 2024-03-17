local View = require("UIGoodsTips/UIGoodsTipsView")
local DataModel = require("UIGoodsTips/UIGoodsTipsDataModel")
local ViewFunction = {
  GoodsTips_Btn_BG_Click = function(btn, str)
    View.self:CloseUI()
  end,
  GoodsTips_Group_Show_Group_GetWay_Btn_Access_Click = function(btn, str)
    local data = {}
    data.itemID = DataModel.Id
    data.posX = 400
    data.posY = -40
    View.Group_Show.Group_GetWay.Btn_Access.Img_On:SetActive(true)
    UIManager:Open("UI/Common/Group_GetWay", Json.encode(data))
  end
}
return ViewFunction
