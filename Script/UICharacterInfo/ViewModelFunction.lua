local ViewModel = require("UICharacterInfo/ViewModel")
local DataModel = require("UICharacterInfo/Model_Data")
local AwakeLoader = require("UICharacterInfo/ViewAwake")
local EquipHandle = require("UICharacterInfo/Model_Equipment")
local BtnController = require("UICharacterInfo/Model_Btn")
local ViewModelFunction = {
  Group_TabInfo_Group_TIBottomLeft_Img_LevelBottom_Btn_LevelUp_click = function(str)
  end,
  Group_TabInfo_Group_TIBottomLeft_Btn_Attribute_click = function(str)
  end,
  Group_TabInfo_Group_TIBottomLeft_Btn_Skin_click = function(str)
  end,
  Group_TabInfo_Group_TIBottomLeft_Btn_Information_click = function(str)
  end,
  Group_TabInfo_Group_TIBottomLeft_Btn_Show_click = function(str)
  end,
  Group_TabInfo_Group_TIRight_Group_TIMiddle_Btn_Skill01_click = function(str)
  end,
  Group_TabInfo_Group_TIRight_Group_TIMiddle_Btn_Skill02_click = function(str)
  end,
  Group_TabInfo_Group_TIRight_Group_TIMiddle_Btn_Skill03_click = function(str)
  end,
  Group_TabInfo_Group_TIRight_Group_TIBottom_Btn_Equipment01_Btn_Item_click = function(str)
    EquipHandle:ClickIdx(0)
  end,
  Group_TabInfo_Group_TIRight_Group_TIBottom_Btn_Equipment02_Btn_Item_click = function(str)
    EquipHandle:ClickIdx(1)
  end,
  Group_TabInfo_Group_TIRight_Group_TIBottom_Btn_Equipment03_Btn_Item_click = function(str)
    EquipHandle:ClickIdx(2)
  end,
  Group_TabAwake_Group_TARight_Img_TABottom_Group_TABottom_Btn_Awake_click = function(str)
    local callBack = AwakeLoader:GetCallback()
    local p = ProtocolFactory:CreateProtocol(ProtocolType.CharacterAwake)
    p.roleId = DataModel.RoleId
    p:SetCallback(callBack)
    ServerConnectManager:Add(p)
  end,
  Group_TabAwake_Group_TARight_Img_TABottom_Group_TABottom_Img_Item01_Group_Item_Btn_Item_click = function(str)
  end,
  Group_TabAwake_Group_TARight_Img_TABottom_Group_TABottom_Img_Item02_Group_Item_Btn_Item_click = function(str)
  end,
  Group_TabAwake_Group_TARight_Img_TABottom_Group_TABottom_Img_Item03_Group_Item_Btn_Item_click = function(str)
  end,
  Group_TabBreakThrough_Group_TBRight_Img_TBBottom_Group_TBBottom_Img_Item01_Group_Item_Btn_Item_click = function(str)
  end,
  Group_TabBreakThrough_Group_TBRight_Img_TBBottom_Group_TBBottom_Img_Item02_Group_Item_Btn_Item_click = function(str)
  end,
  Group_TopLeft_Group_CommonTopLeft_Btn_Return_click = function(str)
    EquipHandle:Submit()
    UIManager:GoBack()
  end,
  Group_TopLeft_Group_CommonTopLeft_Btn_Home_click = function(str)
    EquipHandle:Submit()
    UIManager:GoHome()
  end,
  Group_TopLeft_Group_CommonTopLeft_Btn_Help_click = function(str)
  end,
  Group_TopRight_Btn_TabInfo_click = function(str)
    BtnController:Click(ViewModel.Group_TopRight.Btn_TabInfo)
  end,
  Group_TopRight_Btn_TabAwake_click = function(str)
    BtnController:Click(ViewModel.Group_TopRight.Btn_TabAwake)
  end,
  Group_TopRight_Btn_TabBreakThrough_click = function(str)
    BtnController:Click(ViewModel.Group_TopRight.Btn_TabBreakThrough)
  end,
  Group_TopRight_Btn_TabSkill_click = function(str)
    BtnController:Click(ViewModel.Group_TopRight.Btn_TabSkill)
  end,
  Group_TopRight_Btn_TabTalent_click = function(str)
    BtnController:Click(ViewModel.Group_TopRight.Btn_TabTalent)
  end
}
return ViewModelFunction
