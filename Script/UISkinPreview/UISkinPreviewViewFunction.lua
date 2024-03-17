local View = require("UISkinPreview/UISkinPreviewView")
local DataModel = require("UISkinPreview/UISkinPreviewDataModel")
local ViewFunction = {
  SkinPreview_Img_Bg_Group_Left_Group_Bottom_Btn_Look_Click = function(btn, str)
    View.self:PlayAnim("Animation_Skin_out")
    if DataModel.NowSkin.isSpine2 == 0 then
      View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = true
    else
      DataModel:MoveSpine2Live2D(1)
    end
  end,
  SkinPreview_Img_Bg_Group_Left_Group_Bottom_Img_Live2dBg_Btn_Click_Click = function(btn, str)
    DataModel:ClickLive2D(DataModel.live2D)
  end,
  SkinPreview_Img_Bg_Group_Right_Img_Frame_ScrollGrid_SkinList_SetGrid = function(element, elementIndex)
    local row = DataModel.SkinList[tonumber(elementIndex)]
    local Btn_SkinBg = element.Btn_SkinBg
    Btn_SkinBg:SetClickParam(elementIndex)
    Btn_SkinBg.Img_LockMask:SetActive(not row.isHave)
    Btn_SkinBg.Img_Selected:SetActive(false)
    element.Img_Selected2:SetActive(row.isSelect)
    element.Img_Selected:SetActive(row.isSelect)
    Btn_SkinBg.Img_SkinFrame:SetSprite(row.ca.roleListResUrl)
    local SkinName = row.ca.SkinName
    local SkinDesc = row.ca.SkinDesc
    if row.isSpine2 == 1 then
      SkinName = row.ca.State2Name
      SkinDesc = row.ca.State2Desc
      Btn_SkinBg.Img_SkinFrame:SetSprite(row.ca.State2RoleListRes)
    end
    row.SkinName = SkinName
    row.SkinDesc = SkinDesc
    Btn_SkinBg.Img_SkinFrame.Img_SkinNameBg.Txt_:SetText(SkinName)
    Btn_SkinBg.Img_SkinFrame.Img_FrameMask.Img_Belonging:SetSprite(UIConfig.RoleCamp[tonumber(PlayerData:SearchRoleCampInt(DataModel.RoleCA.sideId))])
    Btn_SkinBg.Img_SkinFrame.Img_InUsingBg:SetActive(row.isWear)
    row.element = element
  end,
  SkinPreview_Img_Bg_Group_Right_Img_Frame_ScrollGrid_SkinList_Group_Item_Btn_SkinBg_Click = function(btn, str)
    DataModel:ClickLeftSkin(tonumber(str))
  end,
  SkinPreview_Img_Bg_Group_Right_Group_HoldingStatus_Btn_On_Click = function(btn, str)
    local row = DataModel.SkinList[tonumber(DataModel.ChooseIndex)]
    if row.Btn_Index == 0 then
      return
    end
    Net:SendProto("hero.change_skin", function(json)
      print_r(json)
      local current_skin = PlayerData:GetRoleById(DataModel.RoleId).current_skin
      current_skin[1] = row.unitViewId
      current_skin[2] = row.isSpine2
      DataModel:RefreshPage()
      DataModel.RoleData.current_skin = current_skin
      PlayerData.RefreshRoleInCoachSkin(DataModel.RoleId)
    end, DataModel.RoleId, row.unitViewId, row.isSpine2)
  end,
  SkinPreview_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:Confirm()
    UIManager:GoBack()
  end,
  SkinPreview_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    MapNeedleData.GoHome()
  end,
  SkinPreview_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  SkinPreview_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  SkinPreview_Group_View_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
  end,
  SkinPreview_Group_View_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  SkinPreview_Group_View_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  SkinPreview_Group_View_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  SkinPreview_Group_CommonTopLeft2_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("Animation_Skin_in")
    DataModel:Reset()
    if DataModel.NowSkin.isSpine2 == 1 then
      DataModel:MoveSpine2Live2D(0)
    end
  end,
  SkinPreview_Group_CommonTopLeft2_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  SkinPreview_Group_CommonTopLeft2_Btn_Menu_Click = function(btn, str)
  end,
  SkinPreview_Group_CommonTopLeft2_Btn_Help_Click = function(btn, str)
  end
}
return ViewFunction
