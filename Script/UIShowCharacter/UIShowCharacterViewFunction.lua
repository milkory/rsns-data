local View = require("UIShowCharacter/UIShowCharacterView")
local DataModel = require("UIShowCharacter/UIShowCharacterDataModel")
local index = 0
local sound
local StopSound = function()
  if sound ~= nil and sound.audioSource ~= nil then
    sound:Stop()
  end
  if DataModel.Sound ~= nil and DataModel.Sound.audioSource ~= nil then
    DataModel.Sound:Stop()
  end
  DataModel.Sound = nil
  View.Group_Chuxian.Group_R.Group_R:SetActive(false)
  View.Group_Chuxian.Group_SR.Group_SR:SetActive(false)
  View.Group_Chuxian.Group_SSR.Group_SSR:SetActive(false)
  View.Group_Guang.Group_R.Group_R:SetActive(false)
  View.Group_Guang.Group_SR.Group_SR:SetActive(false)
  View.Group_Guang.Group_SSR.Group_SSR:SetActive(false)
end
local ViewFunction = {
  ShowCharacter_Btn_Skip_Click = function(btn, str)
    if DataModel.isReady == false then
      return
    end
    StopSound()
    if DataModel.Type == EnumDefine.DrawCard.Ten then
      local hasSSr = -1
      local cardCnt = #DataModel.Cards
      for i = DataModel.Index + 1, cardCnt do
        local CurrCard = DataModel.Cards[i]
        local detail = PlayerData:GetFactoryData(CurrCard.id, "UnitFactory")
        if detail.qualityInt > 3 or CurrCard.isNew == true then
          hasSSr = i
          break
        end
      end
      if hasSSr == -1 then
        View.self:SetRaycastBlock(false)
        DataModel.isReady = false
        local t
        if DataModel.ShowItem == 1 then
          t = {
            cards = DataModel.Cards,
            reward = DataModel.Reward
          }
        else
          t = {
            cards = DataModel.Cards
          }
        end
        UIManager:Open("UI/Gacha/TenPulls", Json.encode(t))
      else
        local t = {}
        if DataModel.ShowItem == 1 then
          t = {
            type = EnumDefine.DrawCard.Ten,
            cards = DataModel.Cards,
            index = hasSSr,
            material = DataModel.Reward,
            poolId = DataModel.poolId
          }
        else
          t = {
            type = EnumDefine.DrawCard.Ten,
            cards = DataModel.Cards,
            index = hasSSr,
            poolId = DataModel.poolId
          }
        end
        UIManager:Open("UI/ShowCharacter/ShowCharacter", Json.encode(t), nil, nil, false, true)
      end
    else
      View.self:SetRaycastBlock(false)
      DataModel.isReady = false
      UIManager:GoBack()
      View.self:Confirm()
      if DataModel.ShowItem == 1 then
        CommonTips.OpenShowItem(DataModel.Reward)
      end
    end
  end,
  ShowCharacter_Btn_BG_Click = function(btn, str)
    if DataModel.isReady == false then
      return
    end
    if DataModel.Cards == nil then
      return
    end
    StopSound()
    if DataModel.Index == #DataModel.Cards then
      if DataModel.Type == EnumDefine.DrawCard.Ten then
        DataModel.isReady = false
        UIManager:Open("UI/Gacha/TenPulls", Json.encode({
          cards = DataModel.Cards,
          reward = DataModel.Reward
        }))
      elseif DataModel.ShowItem == 1 then
        DataModel.isReady = false
        UIManager:GoBack(true, 1)
        CommonTips.OpenShowItem(DataModel.Reward)
      else
        DataModel.isReady = false
        UIManager:GoBack(DataModel.GoBackState, 1)
        View.self:Confirm()
      end
    else
      local t = {}
      if DataModel.ShowItem == 1 then
        t = {
          type = EnumDefine.DrawCard.Ten,
          cards = DataModel.Cards,
          index = DataModel.Index + 1,
          material = DataModel.Reward,
          poolId = DataModel.poolId
        }
      else
        t = {
          type = EnumDefine.DrawCard.Ten,
          cards = DataModel.Cards,
          index = DataModel.Index + 1,
          poolId = DataModel.poolId
        }
      end
      UIManager:Open("UI/ShowCharacter/ShowCharacter", Json.encode(t), nil, nil, false, true)
    end
  end,
  PlaySound = function(qualityInt)
    local tSoundId
    local tBGMConfig = PlayerData:GetFactoryData(99900002, "ConfigFactory")
    if tBGMConfig ~= nil then
      if qualityInt < 2 then
        tSoundId = tBGMConfig.choukaN
      elseif qualityInt < 3 then
        tSoundId = tBGMConfig.choukaR
      elseif qualityInt < 4 then
        tSoundId = tBGMConfig.choukaSR
      else
        tSoundId = tBGMConfig.choukaSSR
      end
      if tSoundId ~= nil then
        sound = SoundManager:CreateSound(tSoundId)
        if sound ~= nil then
          sound:Play()
        end
      end
    end
  end,
  ShowCharacter_Group_Reward_StaticGrid_List_SetGrid = function(element, elementIndex)
    local rewardData = DataModel.extraList[tonumber(elementIndex)]
    local rewardCA = PlayerData:GetFactoryData(rewardData.id)
    element.Img_Repeat.Img_Icon:SetSprite(rewardCA.iconPath)
    element.Img_Repeat.Group_Txt.Txt_Item:SetText(string.format(GetText(80602310), rewardCA.name, rewardData.num))
    local typeTxt
    if rewardData.way == 1 then
      typeTxt = 80602304
    else
      typeTxt = 80602311
    end
    element.Img_Repeat.Group_Txt.Txt_Type:SetText(string.format(GetText(typeTxt)))
  end
}
return ViewFunction
