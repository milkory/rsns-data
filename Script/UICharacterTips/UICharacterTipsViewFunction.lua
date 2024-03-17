local View = require("UICharacterTips/UICharacterTipsView")
local DataModel = require("UICharacterTips/UICharacterTipsDataModel")
local ViewFunction = {
  CharacterTips_Group_Information_Btn_Button_Click = function(btn, str)
    DataModel.isSpine2 = not DataModel.isSpine2
    local callback = function()
      View.self:PlayAnim("TipsOut")
    end
    DataModel:CharacterLoad(self, DataModel.isSpine2, callback)
  end,
  CharacterTips_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("TipsOut")
    if DataModel.IsGoback then
      UIManager:GoBack()
    else
      View.self:CloseUI()
    end
    DataModel:Clear()
  end,
  CharacterTips_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("TipsOut")
    UIManager:GoHome()
    DataModel:Clear()
  end,
  CharacterTips_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  CharacterTips_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  CharacterTips_Img_PageBg_StaticGrid_Top_SetGrid = function(element, elementIndex)
    local row = DataModel.Top_Right_List[tonumber(elementIndex)]
    element.Btn_Close.Txt_Skill:SetText(row.name)
    element.Btn_Open.Txt_Skill:SetText(row.name)
    element.Btn_Close:SetActive(true)
    element.Btn_Open:SetActive(false)
    element.Btn_Close:SetClickParam(elementIndex)
    element.Btn_Open:SetClickParam(elementIndex)
    row.element = element
  end,
  CharacterTips_Img_PageBg_StaticGrid_Top_Group_Title_Btn_Open_Click = function(btn, str)
    DataModel:ClickRightTop(tonumber(str))
  end,
  CharacterTips_Img_PageBg_StaticGrid_Top_Group_Title_Btn_Close_Click = function(btn, str)
    DataModel:ClickRightTop(tonumber(str))
  end,
  CharacterTips_Img_PageBg_Group_Title_Btn_Open_Click = function(btn, str)
  end,
  CharacterTips_Img_PageBg_Group_Title_Btn_Close_Click = function(btn, str)
  end,
  CharacterTips_Img_PageBg_Btn_1_Click = function(btn, str)
    DataModel:ClickRightTop(1)
  end,
  CharacterTips_Img_PageBg_Btn_2_Click = function(btn, str)
    DataModel:ClickRightTop(2)
  end,
  CharacterTips_Img_PageBg_Btn_3_Click = function(btn, str)
    DataModel:ClickRightTop(3)
  end,
  CharacterTips_Btn_Close_Click = function(btn, str)
    DataModel.isSpine2 = not DataModel.isSpine2
    DataModel:CharacterLoad(self, DataModel.isSpine2)
    View.Btn_Close:SetActive(false)
    View.self:PlayAnim("TipsIn")
  end,
  CharacterTips_Group_CommonTopLeft2_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("TipsSkin_in")
    DataModel:Reset()
    if DataModel.NowSkin.isSpine2 == 1 then
      DataModel:MoveSpine2Live2D(0)
    end
  end,
  CharacterTips_Group_CommonTopLeft2_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("TipsOut")
    UIManager:GoHome()
    DataModel:Clear()
  end,
  CharacterTips_Group_CommonTopLeft2_Btn_Menu_Click = function(btn, str)
  end,
  CharacterTips_Group_CommonTopLeft2_Btn_Help_Click = function(btn, str)
  end,
  CharacterTips_Group_Information_Img_Live2dBg_Btn_Click_Click = function(btn, str)
    DataModel:ClickLive2D(DataModel.live2D)
  end,
  CharacterTips_Group_Information_Group_Top_Btn_Look_Click = function(btn, str)
    View.self:PlayAnim("TipsSkin_out")
    if DataModel.NowSkin.isSpine2 == 0 then
      View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = true
    else
      DataModel:MoveSpine2Live2D(1)
    end
  end
}
return ViewFunction
