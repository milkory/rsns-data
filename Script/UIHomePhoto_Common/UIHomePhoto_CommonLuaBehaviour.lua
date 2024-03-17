local View = require("UIHomePhoto_Common/UIHomePhoto_CommonView")
local DataModel = require("UIHomePhoto_Common/UIHomePhoto_CommonDataModel")
local ViewFunction = require("UIHomePhoto_Common/UIHomePhoto_CommonViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local info = Json.decode(initParams)
      DataModel.furId = info.furId
      local furCA = PlayerData:GetFactoryData(info.furId, "HomeFurnitureFactory")
      if furCA.PictureUrl and furCA.PictureUrl ~= "" then
        View.Group_Photos.Img_Show:SetSprite(furCA.PictureUrl)
      end
    end
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
