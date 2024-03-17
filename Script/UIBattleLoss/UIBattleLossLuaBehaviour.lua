local View = require("UIBattleLoss/UIBattleLossView")
local DataModel = require("UIBattleLoss/UIBattleLossDataModel")
local ViewFunction = require("UIBattleLoss/UIBattleLossViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.EventId = PlayerData.TempCache.EventId
    PlayerData.TempCache.EventId = nil
    local current = tonumber(PlayerData:GetHomeInfo().readiness.repair.current_durable)
    local max = tonumber(PlayerData.GetCoachMaxDurability())
    local ratio = current / max
    if 0.8 <= ratio then
      View.Group_Tip.Txt_Context:SetText(GetText(80601256))
    elseif 0.5 <= ratio and ratio < 0.8 then
      View.Group_Tip.Txt_Context:SetText(GetText(80601390))
    elseif 0.3 <= ratio and ratio < 0.5 then
      View.Group_Tip.Txt_Context:SetText(GetText(80601391))
    elseif 0.1 <= ratio and ratio < 0.3 then
      View.Group_Tip.Txt_Context:SetText(GetText(80601392))
    else
      View.Group_Tip.Txt_Context:SetText(GetText(80601393))
    end
    View.Group_Tip.Group_Health.Img_HealthBlood:SetFilledImgAmount(ratio)
    local loss = PlayerData.TempCache.minus_durable
    View.Group_Tip.Group_Health.Img_BloodLoss:SetFilledImgAmount((loss + current) / max)
    print_r(GetText(80601374))
    View.Group_Tip.Group_Health.Txt_Blood:SetText(string.format(GetText(80601374), current, loss, max))
    View.Group_Tip.Group_Health.Txt_Percent:SetText(math.floor(ratio * 100))
    local consumables = PlayerData.TempCache.consumables
    local isHaveData
    if consumables ~= nil then
      DataModel.Data = PlayerData:SortShowItem(consumables)
      isHaveData = #DataModel.Data ~= 0
    else
      isHaveData = false
    end
    View.ScrollGrid_Item.grid.self:SetActive(isHaveData)
    View.Group_Btn.self:SetActive(isHaveData)
    View.Group_NoLoss.self:SetActive(not isHaveData)
    if isHaveData then
      View.ScrollGrid_Item.grid.self:SetDataCount(#DataModel.Data)
      View.ScrollGrid_Item.grid.self:RefreshAllElement()
      if consumables.gold and consumables.gold["11400001"] then
        View.Group_coin.Txt_coin:SetText(consumables.gold["11400001"].num)
      else
        View.Group_coin.Txt_coin:SetText(0)
      end
    else
      View.Group_coin.Txt_coin:SetText(0)
    end
    PlayerData.TempCache.consumables = nil
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
