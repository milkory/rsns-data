local View = require("UIEngineCore/UIEngineCoreView")
local DataModel = require("UIEngineCore/UIEngineCoreDataModel")
local Controller = require("UIEngineCore/UIEngineCoreController")
local ViewFunction = {
  EngineCore_Group_Now_Group_Check_Btn__Click = function(btn, str)
    Controller:ShowLevelDetail(str)
  end,
  EngineCore_Group_Now_Group_Upgrade_Btn_Challenge_Click = function(btn, str)
    Controller:ChallengeClick(str)
  end,
  EngineCore_Group_Now_Group_Upgrade_StaticGrid_List_SetGrid = function(element, elementIndex)
    Controller:ShowConditionTxt(element, elementIndex, View.Group_Now)
  end,
  EngineCore_Group_Now_Group_Break_Btn_Break_Click = function(btn, str)
    Controller:BreakClick(str)
  end,
  EngineCore_Group_Now_Group_Break_Group_Need_Group_Item_Group_Consume1_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickItem(str)
  end,
  EngineCore_Group_Now_Group_Break_Group_Need_Group_Item_Group_Consume2_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickItem(str)
  end,
  EngineCore_Group_Now_Group_Break_Group_Need_Group_Item_Group_Consume3_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickItem(str)
  end,
  EngineCore_Group_Now_Group_Limit_Btn_Challenge_Click = function(btn, str)
  end,
  EngineCore_Group_Next_Group_Check_Btn__Click = function(btn, str)
    Controller:ShowLevelDetail(str)
  end,
  EngineCore_Group_Next_Group_Upgrade_Btn_Challenge_Click = function(btn, str)
    Controller:ChallengeClick(str)
  end,
  EngineCore_Group_Next_Group_Upgrade_StaticGrid_List_SetGrid = function(element, elementIndex)
    Controller:ShowConditionTxt(element, elementIndex, View.Group_Next)
  end,
  EngineCore_Group_Next_Group_Break_Btn_Break_Click = function(btn, str)
    Controller:BreakClick(str)
  end,
  EngineCore_Group_Next_Group_Break_Group_Need_Group_Item_Group_Consume1_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickItem(str)
  end,
  EngineCore_Group_Next_Group_Break_Group_Need_Group_Item_Group_Consume2_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickItem(str)
  end,
  EngineCore_Group_Next_Group_Break_Group_Need_Group_Item_Group_Consume3_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickItem(str)
  end,
  EngineCore_Group_Next_Group_Limit_Btn_Challenge_Click = function(btn, str)
  end,
  EngineCore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  EngineCore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  EngineCore_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  EngineCore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  EngineCore_Group_Engine_Drag_Panel_BeginDrag = function(direction, dragPos)
    if DataModel.ComeBack then
      return
    end
    DataModel.NextElement:SetActive(true)
    DataModel.Dragging = true
    DataModel.CachePos = dragPos
  end,
  EngineCore_Group_Engine_Drag_Panel_EndDrag = function(direction, dragPos)
    DataModel.Dragging = false
    DataModel.ComeBack = true
  end,
  EngineCore_Group_Engine_Drag_Panel_OnDrag = function(direction, dragPos)
    local dir = {}
    dir.x = DataModel.CachePos.x - DataModel.DragScreenCenterPos.x
    dir.y = DataModel.CachePos.y - DataModel.DragScreenCenterPos.y
    local value = math.sqrt(dir.x * dir.x + dir.y * dir.y)
    dir.x = dir.x / value
    dir.y = dir.y / value
    local right = {}
    right.x = 1
    right.y = 0
    local dot = dir.x * right.x + dir.y * right.y
    DataModel.BeginDragAngle = math.acos(dot) * 180 / math.pi
    if dir.y < 0 then
      DataModel.BeginDragAngle = 360 - DataModel.BeginDragAngle
    end
    DataModel.DeltaCachePos = dragPos - DataModel.CachePos
    DataModel.CachePos = dragPos
  end
}
return ViewFunction
