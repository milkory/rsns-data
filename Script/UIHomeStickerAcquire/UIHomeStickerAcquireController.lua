local View = require("UIHomeStickerAcquire/UIHomeStickerAcquireView")
local DataModel = require("UIHomeStickerAcquire/UIHomeStickerAcquireDataModel")
local Controller = {}

function Controller:Init()
  local itemData = DataModel.Data[1]
  local factoryName = DataManager:GetFactoryNameById(itemData.id)
  local isPhoto = factoryName == "ProfilePhotoFactory"
  local groupItem = View.Group_Item
  local groupPhoto = groupItem.Group_Photo
  local groupOther = groupItem.Group_Other
  groupPhoto:SetActive(isPhoto)
  groupOther:SetActive(not isPhoto)
  local str
  local factoryData = itemData.factoryName
  local txtText = View.Group_Text.Txt_Text
  local txtTip = txtText.Txt_Tip
  txtTip:SetActive(not isPhoto)
  if isPhoto then
    str = GetText(80601156)
    groupPhoto.Img_Photo:SetSprite(factoryData.imagePath)
  else
    local num = itemData.num
    str = string.format(GetText(80601157), factoryData.name)
    groupOther.Img_Item:SetSprite(factoryData.iconPath)
    groupOther.Txt_Num:SetText(num)
    local quality = itemData.quality
    groupOther.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality])
    groupOther.Img_Mask:SetSprite(UIConfig.MaskConfig[quality])
    txtTip:SetText(GetText(80601375))
  end
  txtText:SetText(str)
  View.self:PlayAnim("Animation", function()
    View.self:SetEnableAnimator(false)
  end)
end

return Controller
