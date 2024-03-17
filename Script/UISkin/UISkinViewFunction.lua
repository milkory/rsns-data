local View = require("UISkin/UISkinView")
local DataModel = require("UISkin/UISkinDataModel")
local DataModel_Info = require("UICharacterInfo/DataModel")
local ViewFunction = {
  Skin_Img_Bg_Group_Left_Group_Bottom_Btn_Look_Click = function(btn, str)
  end,
  Skin_Img_Bg_Group_Right_Group_HoldingStatus_Btn_On_Click = function(btn, str)
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
      DataModel_Info.RoleData.current_skin = current_skin
      PlayerData.RefreshRoleInCoachSkin(DataModel.RoleId)
    end, DataModel.RoleId, row.unitViewId, row.isSpine2)
  end,
  Skin_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:Confirm()
    UIManager:GoBack()
  end,
  Skin_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Skin_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Skin_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Skin_Img_Bg_Group_Right_Img_Frame_ScrollGrid_SkinList_SetGrid = function(element, elementIndex)
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
  Skin_Img_Bg_Group_Right_Img_Frame_ScrollGrid_SkinList_Group_Item_Btn_SkinBg_Click = function(btn, str)
    DataModel:ClickLeftSkin(tonumber(str))
  end,
  Skin_Img_Bg_Group_Left_Group_Bottom_Img_Live2dBg_Btn_Click_Click = function(btn, str)
    DataModel:ClickLive2D(DataModel.live2D)
  end,
  Skin_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end
}
return ViewFunction
