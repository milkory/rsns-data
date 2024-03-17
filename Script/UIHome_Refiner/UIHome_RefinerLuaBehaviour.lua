local View = require("UIHome_Refiner/UIHome_RefinerView")
local ViewFunction = require("UIHome_Refiner/UIHome_RefinerViewFunction")
local Controller = require("UIHome_MachiningLathe/HomeMakeFurController")
local params
local Luabehaviour = {
  serialize = function()
    local data = Json.decode(params)
    data.isGoback = true
    return Json.encode(data)
  end,
  deserialize = function(initParams)
    params = initParams
    Controller.Init(View, initParams)
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
    local grid = View.Img_Right.Group_Choose.Img_Top.ScrollGrid_Toplist.grid
    for k, v in pairs(grid) do
      if v.Btn_Choose then
        DOTweenTools.Kill(v.Btn_Choose.Group_Name.Txt_Name.transform)
      end
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
