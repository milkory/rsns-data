local View = require("UIBalloonTips/UIBalloonTipsView")
local DataModel = require("UIBalloonTips/UIBalloonTipsDataModel")
local Controller = {}

function Controller:InitSlider()
  View.Group_Slider.Slider_Value:SetMinAndMaxValue(1, DataModel.MaxNum)
end

function Controller:RefreshShow(isRefreshSlider)
  local eventCfg = PlayerData:GetFactoryData(DataModel.TrainEventId, "AFKEventFactory")
  if eventCfg.levelId then
    local currIndex = 1
    if DataModel.TrainEventAreaId and PlayerData.pollute_areas and table.count(PlayerData.pollute_areas) > 0 then
      local t = PlayerData.pollute_areas[tostring(DataModel.TrainEventAreaId)]
      currIndex = t.po_curIndex and tonumber(t.po_curIndex) + 1 or 1
    end
    local cfg = PlayerData:GetFactoryData(99900043, "ConfigFactory")
    local balloonCfg = cfg.polluteBalloonList[currIndex]
    local listId = balloonCfg.id
    local listCfg = PlayerData:GetFactoryData(listId, "ListFactory")
    local ratio = listCfg.balloonList[DataModel.CurrNum].ratio + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddBalloonSR) + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AddBalloonSR, listCfg.balloonList[DataModel.CurrNum].ratio)
    ratio = math.min(100, MathEx.roundToDecimalPlaces(ratio * 100, 1))
    View.Group_Success.Txt_Num:SetText(ratio .. "%")
    View.Group_Slider.Group_Num.Txt_Select:SetText(math.floor(DataModel.CurrNum))
    View.Group_Slider.Group_Num.Txt_Possess:SetText(DataModel.MaxNum)
    if isRefreshSlider then
      View.Group_Slider.Slider_Value:SetSliderValue(DataModel.CurrNum)
    end
    DataModel:SetSliderRefreshState(true)
  else
    error(DataModel.TrainEventId .. "在AFKEventFactory没有配置，自行检查")
  end
end

return Controller
