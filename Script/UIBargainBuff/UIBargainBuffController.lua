local View = require("UIBargainBuff/UIBargainBuffView")
local DataModel = require("UIBargainBuff/UIBargainBuffDataModel")
local Controller = {}

function Controller:Init()
  Controller:DoSpineAni()
end

function Controller:DoSpineAni()
  local cb = function()
    View.Group_Spine:SetActive(false)
    Controller:DoBuffAnimation()
  end
  if DataModel.Data.stationId == nil then
    cb()
    return
  end
  local stationCA = PlayerData:GetFactoryData(DataModel.Data.stationId, "HomeStationFactory")
  if stationCA.bargainSpinePath and stationCA.bargainSpinePath ~= "" then
    local spineActionName = stationCA.action2M
    local gender = PlayerData:GetUserInfo().gender or 1
    if gender ~= 1 then
      spineActionName = stationCA.action2W
    end
    View.Group_Buff:SetActive(false)
    View.Group_Spine:SetActive(true)
    View.Group_Spine.SpineAnimation_Bargain:SetData(stationCA.bargainSpinePath, spineActionName)
    View.Group_Spine.SpineAnimation_Bargain:SetAction(spineActionName, false, false, cb)
  else
    cb()
  end
end

function Controller:DoBuffAnimation()
  local cb = function()
    Controller:CloseUI()
  end
  View.Group_Buff:SetActive(true)
  View.Group_Buff.Txt_Name:SetText(DataModel.Data.name)
  View.Group_Buff.Txt_Dec:SetText(DataModel.Data.desc)
  View.self:SelectPlayAnim(View.Group_Buff.self, "In", cb)
end

function Controller:SkipSpine()
  if View.Group_Spine.self.IsActive then
    View.Group_Spine:SetActive(false)
  end
  Controller:DoBuffAnimation()
end

function Controller:CloseUI()
  View.self:CloseUI()
  View.self:Confirm()
end

return Controller
