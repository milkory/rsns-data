local View = require("UIBattleLoss/UIBattleLossView")
local DataModel = require("UIBattleLoss/UIBattleLossDataModel")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  BattleLoss_Group_Btn_Btn_Police_Click = function(btn, str)
    Net:SendProto("building.report_level", function(json)
      UIManager:CloseTip("UI/MainUI/BattleLoss")
      if json.sid then
        local city_id = json.sid
        local city_name = PlayerData:GetFactoryData(city_id).name
        CommonTips.OpenTips(string.format(GetText(80601347), city_name))
      end
    end, PlayerData.BattleInfo.battleStageId)
  end,
  BattleLoss_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.Data[tonumber(elementIndex)]
    CommonItem:SetItem(element, row, nil, 1)
    element.Btn_Item:SetClickParam(elementIndex)
  end,
  BattleLoss_ScrollGrid_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.Data[tonumber(str)].id, DataModel.Data[tonumber(str)])
  end,
  BattleLoss_Btn_Back_Click = function(btn, str)
    UIManager:CloseTip("UI/MainUI/BattleLoss")
  end,
  BattleLoss_Btn_Close_Click = function(btn, str)
    UIManager:CloseTip("UI/MainUI/BattleLoss")
  end,
  BattleLoss_Group_NoLoss_Btn_Choose_Click = function(btn, str)
    UIManager:CloseTip("UI/MainUI/BattleLoss")
  end,
  BattleLoss_Group_Btn_Btn_Next_Click = function(btn, str)
    UIManager:CloseTip("UI/MainUI/BattleLoss")
  end
}
return ViewFunction
