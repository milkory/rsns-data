local View = require("UITestLevelDetail/UITestLevelDetailView")
local DataModel = require("UITestLevelDetail/UITestLevelDetailDataModel")
local Controller = require("UITestLevelDetail/UITestLevelDetailController")
local ViewFunction = {
  TestLevelDetail_Group_Card_ScrollGrid_Card_SetGrid = function(element, elementIndex)
    Controller.SetElement(element, elementIndex)
  end,
  TestLevelDetail_Group_Character_StaticGrid_Character_SetGrid = function(element, elementIndex)
    element.Btn_Character:SetClickParam(elementIndex)
    Controller.SetRolesElement(element, elementIndex)
  end,
  TestLevelDetail_Group_CharacterCard_ScrollGrid_Card_SetGrid = function(element, elementIndex)
    Controller.SetRoleCardElement(element, elementIndex)
  end,
  TestLevelDetail_Btn_GoBack_Click = function(btn, str)
    Controller.Destroy()
    UIManager:GoBack(false)
  end,
  TestLevelDetail_Group_Character_StaticGrid_Character_TestLevelRoleInfo_Btn_Character_Click = function(btn, str)
    Controller.OnClickRole(tonumber(str))
  end,
  TestLevelDetail_Group_CharacterCard_Btn_GoBack_Click = function(btn, str)
    Controller.OpenRoleCardList(false)
  end,
  TestLevelDetail_Group_CharacterCard_Txt_Card_Btn_GoBack_Click = function(btn, str)
  end,
  TestLevelDetail_Group_CharacterCard_TestLevelRoleInfo_003_Btn_Character_Click = function(btn, str)
  end,
  TestLevelDetail_Group_CharacterCard_TestLevelRoleInfo_002_Btn_Character_Click = function(btn, str)
  end,
  TestLevelDetail_Group_CharacterCard_TestLevelRoleInfo_001_Btn_Character_Click = function(btn, str)
  end,
  TestLevelDetail_Group_CharacterCard_TestLevelRoleInfo_000_Btn_Character_Click = function(btn, str)
  end,
  TestLevelDetail_Group_Character_TestLevelRoleInfo_Btn_Character_Click = function(btn, str)
  end
}
return ViewFunction
