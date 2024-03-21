local View = require("UICardDrawing/UICardDrawingView")
local DataModel = require("UICardDrawing/UICardDrawingDataModel")
local ViewFunction = require("UICardDrawing/UICardDrawingViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.self:PlayAnim("CardDrawing_In", function()
      View.self:PlayAnim("CardDrawing_Loop")
    end)
    View.Btn_Return:SetBtnInteractable(false)
    View.animator = View.self.transform:GetComponent(typeof(CS.UnityEngine.Animator))
    View.animator.enabled = true
    local cardId = Json.decode(initParams).cardId or PlayerData:GetFactoryData(86300001).otherCardList[math.random(1, #PlayerData:GetFactoryData(86300001).otherCardList)].id
    local cardCfg = PlayerData:GetFactoryData(cardId)
    local cardPackCfg = PlayerData:GetFactoryData(cardCfg.correspondingPack)
    local cardBgPath = cardPackCfg.cardBack
    if cardId == cardPackCfg.topCard then
      cardBgPath = cardPackCfg.topCardBack
    end
    View.Group_Common.Img_CardBack:SetSprite(cardBgPath)
    View.Group_Common.Img_Card:SetSprite(cardCfg.iconPath)
    View.Img_CardPack:SetSprite(cardPackCfg.cardPack)
    View.Group_activity_CardDrawing.Group_AnimPose.Img_T1:SetSprite(cardPackCfg.topOne)
    View.Group_activity_CardDrawing.Group_AnimPose.Img_T2:SetSprite(cardPackCfg.topTwo)
    View.Group_activity_CardDrawing.Group_AnimPose.Img_T3:SetSprite(cardPackCfg.topThree)
    View.Group_activity_CardDrawing.Group_AnimPose.Img_T4:SetSprite(cardPackCfg.topFour)
    View.Group_activity_CardDrawing.Group_AnimPose.Img_T5:SetSprite(cardPackCfg.topFive)
    View.Group_activity_CardDrawing.Group_AnimPose.Img_D:SetSprite(cardPackCfg.topSix)
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
