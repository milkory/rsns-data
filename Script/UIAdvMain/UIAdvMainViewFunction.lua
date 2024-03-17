local View = require("UIAdvMain/UIAdvMainView")
local DataModel = require("UIAdvMain/UIAdvMainDataModel")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  AdvMain_Group_TopRight_Btn_Pause_Click = function(btn, str)
    View.Group_PauseFrame.self:SetActive(true)
    UIManager:Pause(true)
  end,
  AdvMain_Group_PauseFrame_Btn_BG_Click = function(btn, str)
  end,
  AdvMain_Group_PauseFrame_Btn_Exit_Click = function(btn, str)
    UIManager:Pause(true)
    local advReward = ""
    for i, v in pairs(DataModel.resReward) do
      advReward = advReward .. i .. ":" .. v .. ";"
    end
    Net:SendProto("adventure.end_adv", function(json)
      View.Group_PauseFrame.self:SetActive(false)
      View.Group_SettlementFrame.self:SetActive(true)
      DataModel.Data = PlayerData:SortShowItem(json.reward)
      View.Group_SettlementFrame.Group_ExploreSumUp.ScrollGrid_Items.grid.self:SetDataCount(table.count(DataModel.Data))
      View.Group_SettlementFrame.Group_ExploreSumUp.ScrollGrid_Items.grid.self:RefreshAllElement()
    end, advReward)
  end,
  AdvMain_Group_PauseFrame_Btn_Setting_Click = function(btn, str)
  end,
  AdvMain_Group_PauseFrame_Btn_Continue_Click = function(btn, str)
    UIManager:Pause(false)
    View.Group_PauseFrame.self:SetActive(false)
    View.Group_SettlementFrame.self:SetActive(false)
  end,
  AdvMain_Group_SettlementFrame_Btn_BG_Click = function(btn, str)
  end,
  AdvMain_Group_SettlementFrame_Btn_EndExplore_Click = function(btn, str)
    View.self:StartC(LuaUtil.cs_generator(function()
      MainManager:SetTrainViewFilter(30, true)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
      local cb = function()
        UIManager:Pause(false)
        CBus:ChangeScene("Home")
      end
      CommonTips.OpenLoading(cb, "UI/Home/HomeLoading")
    end))
  end,
  AdvMain_Group_TopRight_Btn_Exit_Click = function(btn, str)
    UIManager:Pause(true)
    local advReward = ""
    for i, v in pairs(DataModel.resReward) do
      advReward = advReward .. i .. ":" .. v .. ";"
    end
    Net:SendProto("adventure.end_adv", function(json)
      View.Group_PauseFrame.self:SetActive(false)
      View.Group_SettlementFrame.self:SetActive(true)
      DataModel.Data = PlayerData:SortShowItem(json.reward)
      View.Group_SettlementFrame.Group_ExploreSumUp.ScrollGrid_Items.grid.self:SetDataCount(table.count(DataModel.Data))
      View.Group_SettlementFrame.Group_ExploreSumUp.ScrollGrid_Items.grid.self:RefreshAllElement()
    end, advReward)
  end,
  AdvMain_Group_SettlementFrame_Group_ExploreSumUp_ScrollGrid_Items_SetGrid = function(element, elementIndex)
    local row = DataModel.Data[tonumber(elementIndex)]
    CommonItem:SetItem(element.Group_Item, row, nil, 1)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    View.self:SelectPlayAnim(element.Group_Item.self, "Animation_itemShow")
  end,
  AdvMain_Group_SettlementFrame_Group_ExploreSumUp_ScrollGrid_Items_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.Data[tonumber(str)].id, DataModel.Data[tonumber(str)])
  end,
  AdvMain_Group_TopRight_Btn__Click = function(btn, str)
  end,
  AdvMain_Group_SettlementFrame_Group_ExploreSumUp_ScrollGrid_CollectItem_SetGrid = function(element, elementIndex)
  end
}
return ViewFunction
