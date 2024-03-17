local View = require("UIBargainTips/UIBargainTipsView")
local DataModel = require("UIBargainTips/UIBargainTipsDataModel")
local Controller = {}

function Controller:DoSpineAni()
  View.Group_Success.self:SetActive(false)
  View.Group_Success2.self:SetActive(false)
  View.Group_Fail.self:SetActive(false)
  local stationCA = PlayerData:GetFactoryData(DataModel.data.stationId, "HomeStationFactory")
  local cb = function()
    View.Group_Spine:SetActive(false)
    Controller:DoBargainAnim()
  end
  if stationCA.bargainSpinePath and stationCA.bargainSpinePath ~= "" then
    local key = "TradeFirstSpine" .. DataModel.data.stationId
    local record = PlayerData:GetPlayerPrefs("int", key)
    if record == 0 then
      PlayerData:SetPlayerPrefs("int", key, 1)
      local spineActionName = stationCA.actionM
      local gender = PlayerData:GetUserInfo().gender or 1
      if gender ~= 1 then
        spineActionName = stationCA.actionW
      end
      View.Group_Spine:SetActive(true)
      View.Group_Spine.SpineAnimation_Bargain:SetData(stationCA.bargainSpinePath, spineActionName)
      View.Group_Spine.SpineAnimation_Bargain:SetAction(spineActionName, false, false, cb)
      return
    end
  end
  cb()
end

function Controller:DoBargainAnim()
  local cb = function()
    Controller:CloseUI()
  end
  if DataModel.data.isSuccess then
    if DataModel.data.isBuy then
      View.Group_Success.Txt_Before:SetText(string.format("%.1f%%", DataModel.data.quota * 100))
      View.Group_Success.Txt_After:SetText(string.format("%.1f%%", DataModel.data.bargainPercent * 100))
      View.Group_Success.self:SetActive(true)
      View.self:SelectPlayAnim(View.Group_Success.self, "Success", cb)
      Controller:PlaySound(DataModel.SoundEnum.tradeBarginSuccess)
    else
      View.Group_Success2.Txt_Before:SetText(string.format("%.1f%%", DataModel.data.quota * 100))
      View.Group_Success2.Txt_After:SetText(string.format("%.1f%%", DataModel.data.bargainPercent * 100))
      View.Group_Success2.self:SetActive(true)
      View.self:SelectPlayAnim(View.Group_Success2.self, "Success", cb)
      Controller:PlaySound(DataModel.SoundEnum.tradeRaiseSuccess)
    end
  else
    View.Group_Fail.Txt_Before:SetText(string.format("%.1f%%", DataModel.data.quota * 100))
    View.Group_Fail.Txt_After:SetText(string.format("%.1f%%", 0))
    View.Group_Fail.self:SetActive(true)
    View.self:SelectPlayAnim(View.Group_Fail.self, "Fail", cb)
    Controller:PlaySound(DataModel.SoundEnum.tradeBargainFailure)
  end
end

function Controller:CloseUI()
  View.self:CloseUI()
  View.self:Confirm()
end

function Controller:PlaySound(enum)
  local uiSoundConfig = PlayerData:GetFactoryData(99900002, "ConfigFactory")
  local soundId = uiSoundConfig[enum]
  if type(soundId) == "table" then
    local count = #soundId
    local randomIdx = 1
    if 1 < count then
      randomIdx = math.random(count)
    end
    local sound = SoundManager:CreateSound(soundId[randomIdx].id)
    if sound ~= nil then
      sound:Play()
    end
  elseif type(soundId) == "number" and 0 < soundId then
    local sound = SoundManager:CreateSound(soundId)
    if sound ~= nil then
      sound:Play()
    end
  end
end

return Controller
