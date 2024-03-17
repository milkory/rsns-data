local View = require("UIConstructStage/UIConstructStageView")
local DataModel = require("UIConstructStage/UIConstructStageDataModel")
local ViewFunction = {
  ConstructStage_Group_Top_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.TopTipsList[elementIndex]
    row.ca = PlayerData:GetFactoryData(row.id)
    element.Txt_Dec:SetText(row.ca.text)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item1_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel:OpenReward(str)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item1_Group_Able_Btn__Click = function(btn, str)
    DataModel:ClickConstructStageReward(1)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item2_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel:OpenReward(str)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item2_Group_Able_Btn__Click = function(btn, str)
    DataModel:ClickConstructStageReward(2)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item3_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel:OpenReward(str)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item3_Group_Able_Btn__Click = function(btn, str)
    DataModel:ClickConstructStageReward(3)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item4_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel:OpenReward(str)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item4_Group_Able_Btn__Click = function(btn, str)
    DataModel:ClickConstructStageReward(4)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item5_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel:OpenReward(str)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item5_Group_Able_Btn__Click = function(btn, str)
    DataModel:ClickConstructStageReward(5)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item6_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel:OpenReward(str)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item6_Group_Able_Btn__Click = function(btn, str)
    DataModel:ClickConstructStageReward(6)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item7_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel:OpenReward(str)
  end,
  ConstructStage_Group_Schedule_Group_Reward_Group_Item7_Group_Able_Btn__Click = function(btn, str)
    DataModel:ClickConstructStageReward(7)
  end,
  ConstructStage_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  ConstructStage_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  ConstructStage_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ConstructStage_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ConstructStage_Group_Tab_StaticGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.ConstructStageList[elementIndex]
    row.element = element
    element.Group_Off:SetActive(true)
    element.Img_Limit:SetActive(row.isLock)
    element.Group_On:SetActive(false)
    element.Group_Off.Txt_Name:SetText(row.nameBtn)
    element.Group_On.Txt_Name:SetText(row.nameBtn)
    element.Btn_:SetClickParam(elementIndex)
    element.Img_RedPoint:SetActive(row.isRecive)
  end,
  ConstructStage_Group_Tab_StaticGrid_List_Group_Item_Btn__Click = function(btn, str)
    local row = DataModel.ConstructStageList[tonumber(str)]
    if row.isLock == true then
      return
    end
    DataModel:ChooseBottomTab(tonumber(str))
  end,
  ConstructStage_Group_Tab_Group_Item_Btn__Click = function(btn, str)
  end,
  ConstructStage_Group_ConTips_Btn__Click = function(btn, str)
    View.Group_Tips.self:SetActive(true)
  end,
  ConstructStage_Group_Tips_Btn_Close_Click = function(btn, str)
    View.Group_Tips.self:SetActive(false)
  end,
  ConstructStage_Group_Tab_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.ConstructStageList[elementIndex]
    row.element = element
    element.Group_Off:SetActive(true)
    element.Img_Limit:SetActive(false)
    element.Group_On:SetActive(false)
    element.Group_Off.Txt_Name:SetText(row.name)
    element.Group_On.Txt_Name:SetText(row.name)
    element.Btn_:SetClickParam(elementIndex)
  end,
  ConstructStage_Group_Tab_ScrollGrid_List_Group_Item_Btn__Click = function(btn, str)
  end
}
return ViewFunction
