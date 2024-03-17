local View = require("UIPetList/UIPetListView")
local DataModel = require("UIPetList/UIPetListDataModel")
local ViewFunction = require("UIPetList/UIPetListViewFunction")
local params
local Luabehaviour = {
  serialize = function()
    return params
  end,
  deserialize = function(initParams)
    params = initParams
    local data = Json.decode(initParams)
    DataModel.InitData(data)
    View.ScrollGrid_Pet_List.grid.self:SetDataCount(#DataModel.sortData)
    View.ScrollGrid_Pet_List.grid.self:RefreshAllElement()
    ViewFunction.UpdatePetInfo()
    View.Group_TopRight.Btn_Love.Img_Select:SetActive(true)
    View.Group_TopRight.Btn_Love.Img_Select.Img_:SetLocalEulerAngles(0)
    View.Group_TopRight.Btn_Love.Img_Normal.Img_:SetLocalEulerAngles(0)
    View.Group_TopRight.Btn_Time.Img_Select:SetActive(false)
    View.Group_TopRight.Btn_Time.Img_Select.Img_:SetLocalEulerAngles(0)
    View.Group_TopRight.Btn_Time.Img_Normal.Img_:SetLocalEulerAngles(0)
    View.Group_TopRight.Btn_Screen.Img_Select:SetActive(false)
    DataModel.Img_Select = View.Group_TopRight.Btn_Love.Img_Select
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
