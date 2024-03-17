local View = require("UIPhotoTips/UIPhotoTipsView")
local DataModel = require("UIPhotoTips/UIPhotoTipsDataModel")
local ViewFunction = {
  PhotoTips_Btn_Close_Click = function(btn, str)
    UIManager:CloseTip("UI/PhotoTips/PhotoTips")
  end
}
return ViewFunction
