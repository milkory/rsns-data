local View = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local DataModel = require("UIDialog/UIDialogDataModel")
local PlotChangeBg = Class.New("PlotChangeBg", base)

function PlotChangeBg:Ctor()
end

function PlotChangeBg:OnStart(ca)
  local bgRes = ca.bgResUrl
  local spineUrl = ca.spineUrl
  if spineUrl == nil or spineUrl == "" then
    View.Group_Shake.SpineAnimation_BG:SetActive(false)
    if bgRes == nil or bgRes == "" then
      View.Group_Shake.Img_TEMP:SetActive(false)
      if DataModel.isReview == true then
        View.Group_Shake.Img_TEMP:SetActive(true)
        bgRes = PlayerData:GetFactoryData(20600293).bgResUrl
        View.Group_Shake.Img_TEMP:SetSprite(bgRes)
      end
    else
      View.Group_Shake.Img_TEMP:SetActive(true)
      View.Group_Shake.Img_TEMP:SetSprite(bgRes)
    end
  else
    View.Group_Shake.Img_TEMP:SetActive(false)
    View.Group_Shake.SpineAnimation_BG:SetActive(true)
    View.Group_Shake.SpineAnimation_BG:SetData("")
    View.Group_Shake.SpineAnimation_BG:SetData(spineUrl, ca.animName, ca.isLoop)
  end
end

function PlotChangeBg.GetState()
  return true
end

function PlotChangeBg:Dtor()
end

return PlotChangeBg
