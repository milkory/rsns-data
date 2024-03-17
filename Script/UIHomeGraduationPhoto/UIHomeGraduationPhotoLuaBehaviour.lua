local View = require("UIHomeGraduationPhoto/UIHomeGraduationPhotoView")
local DataModel = require("UIHomeGraduationPhoto/UIHomeGraduationPhotoDataModel")
local ViewFunction = require("UIHomeGraduationPhoto/UIHomeGraduationPhotoViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if PlayerData:GetUserInfo().gender == 1 then
      View.Img_photo:SetSprite("UI/Dialog/Back/TMT_Photo")
    else
      View.Img_photo:SetSprite("UI/Dialog/Back/TMT_Photo_Female")
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
