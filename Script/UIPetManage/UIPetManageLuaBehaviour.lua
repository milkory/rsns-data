local View = require("UIPetManage/UIPetManageView")
local DataModel = require("UIPetManage/UIPetManageDataModel")
local ViewFunction = require("UIPetManage/UIPetManageViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.Init()
    View.Group_PetHouses:SetActive(true)
    View.Group_Pets:SetActive(false)
    View.Btn_PetHouses.Img_UnSelected:SetActive(false)
    View.Btn_Pets.Img_UnSelected:SetActive(true)
    View.Btn_Pets.Img_Selected:SetActive(true)
    View.Group_PetHouses.ScrollGrid_PetHouses.grid.self:SetDataCount(DataModel.petHouseCount)
    View.Group_PetHouses.ScrollGrid_PetHouses.grid.self:RefreshAllElement()
    View.Group_PetHouses.Group_PetNum.Txt_Num:SetText(string.format(GetText(80601045), DataModel.petInRoomCout, DataModel.roomCount))
    View.Group_Pets.Group_TopRight.Btn_Love.Img_Select:SetActive(true)
    View.Group_Pets.Group_TopRight.Btn_Love.Img_Select.Img_:SetLocalEulerAngles(0)
    View.Group_Pets.Group_TopRight.Btn_Love.Img_Normal.Img_:SetLocalEulerAngles(0)
    View.Group_Pets.Group_TopRight.Btn_Time.Img_Select:SetActive(false)
    View.Group_Pets.Group_TopRight.Btn_Time.Img_Select.Img_:SetLocalEulerAngles(0)
    View.Group_Pets.Group_TopRight.Btn_Time.Img_Normal.Img_:SetLocalEulerAngles(0)
    View.Group_Pets.Group_TopRight.Btn_Screen.Img_Select:SetActive(false)
    DataModel.Img_Select = View.Group_Pets.Group_TopRight.Btn_Love.Img_Select
    View.Screen_Filter:SetActive(false)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
