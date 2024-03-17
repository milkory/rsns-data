local View = require("UIPetFeederList/UIPetFeederListView")
local DataModel = require("UIPetFeederList/UIPetFeederListDataModel")
local ViewFunction = require("UIPetFeederList/UIPetFeederListViewFunction")
local params = ""
local Luabehaviour = {
  serialize = function()
    return params
  end,
  deserialize = function(initParams)
    params = initParams
    local data = Json.decode(initParams)
    DataModel.Init(data)
    View.ScrollGrid_Middle.grid.self:SetDataCount(#DataModel.sortData)
    View.ScrollGrid_Middle.grid.self:RefreshAllElement()
    local item = View.Group_TopRight
    local topTog = {
      item.Btn_Level,
      item.Btn_Rarity,
      item.Btn_Time,
      item.Btn_Screen
    }
    for i, v in ipairs(topTog) do
      v.Img_Select.Img_:SetLocalEulerAngles(0)
      v.Img_Normal.Img_:SetLocalEulerAngles(0)
      v.Img_Select:SetActive(false)
    end
    topTog[DataModel.selectTogId].Img_Select:SetActive(true)
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
