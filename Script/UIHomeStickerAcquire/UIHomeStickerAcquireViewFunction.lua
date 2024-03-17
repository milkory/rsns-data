local View = require("UIHomeStickerAcquire/UIHomeStickerAcquireView")
local DataModel = require("UIHomeStickerAcquire/UIHomeStickerAcquireDataModel")
local ViewFunction = {
  HomeStickerAcquire_Btn_Mask_Click = function(btn, str)
    local stickerController = require("UIHomeSticker/UIHomeStickerController")
    stickerController:SetUIVisible(true)
    UIManager:GoBack(false, 1)
  end,
  HomeStickerAcquire_Group_Item_Group_Other_Btn_Other_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.Data[1].id, DataModel.Data[1])
  end
}
return ViewFunction
