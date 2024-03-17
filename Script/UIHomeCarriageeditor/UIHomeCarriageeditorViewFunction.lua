local View = require("UIHomeCarriageeditor/UIHomeCarriageeditorView")
local DataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
local EditDataModel = require("UIHomeCarriageeditor/UIEditDataModel")
local FixDataModel = require("UIHomeCarriageeditor/UIFixDataModel")
local RefitDataModel = require("UIHomeCarriageeditor/UIRefitDataModel")
local WeaponDataModel = require("UIHomeCarriageeditor/UIWeaponDataModel")
local Controller = require("UIHomeCarriageeditor/UIHomeCarriageeditorController")
local EditController = require("UIHomeCarriageeditor/UIEditController")
local FixController = require("UIHomeCarriageeditor/UIFixController")
local RefitController = require("UIHomeCarriageeditor/UIRefitController")
local WeaponController = require("UIHomeCarriageeditor/UIWeaponController")
local SkinController = require("UIHomeCarriageeditor/UITrainSkinController")
local ViewFunction = {
  HomeCarriageeditor_Btn_edit_Click = function(btn, str)
    Controller:SelectTag(DataModel.TagType.Edit)
  end,
  HomeCarriageeditor_Btn_editselect_Click = function(btn, str)
  end,
  HomeCarriageeditor_Btn_fix_Click = function(btn, str)
    Controller:SelectTag(DataModel.TagType.Fix)
  end,
  HomeCarriageeditor_Btn_fixselect_Click = function(btn, str)
  end,
  HomeCarriageeditor_Btn_skin_Click = function(btn, str)
    Controller:SelectTag(DataModel.TagType.Skin)
  end,
  HomeCarriageeditor_Btn_skinselect_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_Edit_Btn_hold_Click = function(btn, str)
    EditController:SaveEdit()
  end,
  HomeCarriageeditor_Btn_repair_Click = function(btn, str)
    Controller:SelectTag(DataModel.TagType.Refit)
  end,
  HomeCarriageeditor_Btn_repairselect_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_Fix_Btn_TakeCare_Click = function(btn, str)
    FixController:SelectTag(FixDataModel.TagType.Upkeep)
  end,
  HomeCarriageeditor_Group_Fix_Btn_Wash_Click = function(btn, str)
    FixController:SelectTag(FixDataModel.TagType.Wash)
  end,
  HomeCarriageeditor_Group_Fix_Group_TakeCare_Btn_Fix_Click = function(btn, str)
    FixController:ConfirmUpkeep()
  end,
  HomeCarriageeditor_Group_Fix_Group_TakeCare_Btn_Button_Click = function(btn, str)
    FixController:AutoUpkeep()
  end,
  HomeCarriageeditor_Group_Fix_Group_Wash_Group_TextStatus_Btn_Button_Click = function(btn, str)
    FixController:AutoWash()
  end,
  HomeCarriageeditor_Group_Fix_Group_Wash_Group_WashButton_Btn_Wash_Click = function(btn, str)
    FixController:ConfirmWash()
  end,
  HomeCarriageeditor_Group_Edit_Group_Build_Btn_Build_Click = function(btn, str)
    EditController:ClickBuildCoach(false)
  end,
  HomeCarriageeditor_Group_Edit_Group_Build_Btn_Building_Click = function(btn, str)
    EditController:ClickBuildCoach(true)
  end,
  HomeCarriageeditor_Group_Edit_Group_Build_Btn_Built_Click = function(btn, str)
    EditController:ConfirmGetCoach()
  end,
  HomeCarriageeditor_Img_HavemoneyBg_Btn_Add_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_Edit_ScrollView_Train_Viewport_Content_Btn_Locomotivehead_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_Edit_ScrollView_Train_Viewport_Content_Btn_Locomotivehead_LongPress = function(btn, str)
  end,
  HomeCarriageeditor_Group_Edit_ScrollView_Train_Viewport_Content_StaticGrid_Train_SetGrid = function(element, elementIndex)
    EditController:RefreshCoachElement(element, elementIndex)
  end,
  HomeCarriageeditor_Group_Edit_ScrollView_Train_Viewport_Content_StaticGrid_Train_Group_Train_Group_Name_Btn_Name_Click = function(btn, str)
    local idx = tonumber(str)
    if EditDataModel.isEditMode then
      EditController:OpenChangeName(idx)
    else
      EditController:ShowCoachDetailPanel(1, btn, str)
    end
  end,
  HomeCarriageeditor_Group_Edit_ScrollView_Train_Viewport_Content_StaticGrid_Train_Group_Train_Group_Box_Btn_Train_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_Edit_ScrollView_Train_Viewport_Content_StaticGrid_Train_Group_Train_Group_Box_Btn_Train_LongPress = function(btn, str)
    local idx = tonumber(str)
    EditController:LongPressTrain(false, idx)
  end,
  HomeCarriageeditor_Group_Edit_ScrollView_Train_Viewport_Content_StaticGrid_Train_Group_Train_Group_Box_Btn_close_Click = function(btn, str)
    local idx = tonumber(str)
    EditController:UseToBag(idx)
  end,
  HomeCarriageeditor_Group_Edit_ScrollView_Train_Viewport_Content_StaticGrid_Train_Group_Train_Group_Box_Btn_add_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_Edit_ScrollView_Train_Viewport_Content_StaticGrid_Train_Group_Train_Group_Box_Btn_change_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_Edit_Btn_EditMode_Click = function(btn, str)
    EditController:RefreshSaveEditShow(true)
  end,
  HomeCarriageeditor_Group_return_Btn_Return_Click = function(btn, str)
    local cb = function()
      View.self:PlayAnim("Out", function()
        View.Group_Edit.self:SetActive(false)
        View.Group_Fix.self:SetActive(false)
        View.Group_TrainRefit.self:SetActive(false)
        Controller:RemoveCurScene()
        UIManager:GoBack()
      end)
    end
    if EditDataModel.isEditMode and EditDataModel.CompareIsEdit() then
      CommonTips.OnPrompt(80600388, nil, nil, function()
        EditController:SaveEdit(cb)
      end, function()
        cb()
      end, nil, true)
    else
      cb()
    end
  end,
  HomeCarriageeditor_Group_return_Btn_Home_Click = function(btn, str)
    local cb = function()
      View.self:PlayAnim("Out", function()
        View.Group_Edit.self:SetActive(false)
        View.Group_Fix.self:SetActive(false)
        View.Group_TrainRefit.self:SetActive(false)
        Controller:RemoveCurScene()
        UIManager:GoHome()
      end)
    end
    if EditDataModel.isEditMode then
      CommonTips.OnPrompt(80600388, nil, nil, function()
        EditController:SaveEdit(cb)
      end, function()
        cb()
      end, nil, true)
    else
      cb()
    end
  end,
  HomeCarriageeditor_Group_return_Btn_Menu_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_return_Btn_Help_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_Edit_NewScrollGrid_CoachList_SetGrid = function(element, elementIndex)
    EditController:RefreshCoachBagElement(element, elementIndex)
  end,
  HomeCarriageeditor_Group_Edit_NewScrollGrid_CoachList_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local idx = tonumber(str)
    if idx == EditDataModel.MaxElementCount then
      EditController:ExpandCoachBag()
      return
    end
    local bagInfo = EditDataModel.GetCurCoachBagInfo(idx)
    if bagInfo == nil then
      CommonTips.OnPrompt(80601815, nil, nil, function()
        EditController:ClickBuildCoach(false)
      end)
      return
    end
    if EditDataModel.isEditMode then
      EditController:BagToUse(idx)
    end
  end,
  HomeCarriageeditor_Group_Edit_NewScrollGrid_CoachList_Group_Item_Group_Item_Btn_Item_LongPress = function(btn, str)
    local idx = tonumber(str)
    EditController:LongPressTrain(true, idx)
  end,
  HomeCarriageeditor_Group_ChangeName_Btn_Close_Click = function(btn, str)
    View.Group_ChangeName.self:SetActive(false)
  end,
  HomeCarriageeditor_Group_ChangeName_Btn_Confirm_Click = function(btn, str)
    EditController:ConfirmRename()
  end,
  HomeCarriageeditor_Group_ChangeName_Btn_Cancel_Click = function(btn, str)
    View.Group_ChangeName.self:SetActive(false)
  end,
  HomeCarriageeditor_Group_Edit_ScrollView_Train_Viewport_Content_Group_Name_Btn_Name_Click = function(btn, str)
    if EditDataModel.isEditMode then
      EditController:OpenChangeName(tonumber(str))
    else
      EditController:ShowCoachDetailPanel(1, btn, str)
    end
  end,
  HomeCarriageeditor_Btn_weapon_Click = function(btn, str)
    Controller:SelectTag(DataModel.TagType.Weapon)
  end,
  HomeCarriageeditor_Btn_weaponselect_Click = function(btn, str)
  end,
  HomeCarriageeditor_Img_HaveelectricBg_Btn_Add_Click = function(btn, str)
    UIManager:Open("UI/Home/HomeElectric")
  end,
  HomeCarriageeditor_Group_Edit_NewScrollGrid_CoachList_Group_Item_Group_Item_Btn_Item_Btn_Tips_Click = function(btn, str)
    EditController:ShowCoachDetailPanel(2, btn, str)
  end,
  HomeCarriageeditor_Group_Edit_Btn_All_Click = function(btn, str)
    EditController:ShowCoachAllInfo()
  end,
  HomeCarriageeditor_Group_Edit_Btn_CloseOverview_Click = function(btn, str)
    View.Group_Edit.Group_Overview:SetActive(false)
    View.Group_Edit.Btn_CloseOverview:SetActive(false)
  end,
  HomeCarriageeditor_Group_Fix_Btn_TrainMaintenance_Click = function(btn, str)
    FixController:SelectTag(FixDataModel.TagType.Repair)
  end,
  HomeCarriageeditor_Group_Fix_Group_TrainMaintenance_Group_Auto_Btn_Auto_Click = function(btn, str)
    FixController:AutoRepair(true)
  end,
  HomeCarriageeditor_Group_Fix_Group_TrainMaintenance_Group_Auto_Btn_AutoSelect_Click = function(btn, str)
    FixController:AutoRepair(false)
  end,
  HomeCarriageeditor_Group_Fix_Group_TrainMaintenance_Group_FixButton_Btn_Fix_Click = function(btn, str)
    FixController:ConfirmRepair()
  end,
  HomeCarriageeditor_Group_TrainRefit_Btn_Oil_Click = function(btn, str)
    RefitController:SelectTag(RefitDataModel.TagType.Oil)
  end,
  HomeCarriageeditor_Group_TrainRefit_Btn_SpeedChange_Click = function(btn, str)
    RefitController:SelectTag(RefitDataModel.TagType.SpeedChange)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_Oil_Group_OilStatus_Btn_OilUp_Click = function(btn, str)
    RefitController:ClickOilUp()
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_Oil_Group_OilStatus_Btn_OilUpMax_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_Oil_Group_OilStatus_Btn_Button_Click = function(btn, str)
    RefitController:SetAutoUseBullet()
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_Oil_Group_TextStatus_Btn_Subtract_Click = function(btn, str)
    RefitController:RefreshOilBuyShow(RefitDataModel.oilBuyCount - 1)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_Oil_Group_TextStatus_Btn_Add_Click = function(btn, str)
    RefitController:RefreshOilBuyShow(RefitDataModel.oilBuyCount + 1)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_Oil_Group_TextStatus_Slider_Num_Slider = function(slider, value)
    RefitController:RefreshOilBuyShow(value)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_Oil_Group_TextStatus_Slider_Num_SliderDown = function(slider)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_Oil_Group_TextStatus_Slider_Num_SliderUp = function(slider)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_Oil_Group_OilButton_Btn_Oil_Click = function(btn, str)
    RefitController:ConfirmOil()
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_SpeedChange_Group_SpeedUp_Btn_OilUp_Click = function(btn, str)
    RefitController:ClickSpeedChange(1)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_SpeedChange_Group_SpeedUp_Btn_OilUpMax_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_SpeedChange_Group_SlowDown_Btn_OilUp_Click = function(btn, str)
    RefitController:ClickSpeedChange(2)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_SpeedChange_Group_SlowDown_Btn_OilUpMax_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_Edit_Group_BoxBtn_Img_Mask_StaticGrid_Type_SetGrid = function(element, elementIndex)
    EditController:RefreshBagTitleElement(element, elementIndex)
  end,
  HomeCarriageeditor_Group_Edit_Btn_NormalTrain_Click = function(btn, str)
    EditController:SelectCoachType(-1)
  end,
  HomeCarriageeditor_Group_Edit_Group_BoxBtn_Img_Mask_Group_Btn_Btn_Custom_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_Edit_Group_BoxBtn_Img_Mask_StaticGrid_Type_Group_Btn_Btn_Custom_Click = function(btn, str)
    local idx = tonumber(str)
    local coachType = EditDataModel.coachTypes[idx]
    EditController:SelectCoachType(coachType)
  end,
  HomeCarriageeditor_Group_TrainWeapon_ScrollView_Train_Viewport_Content_Group_Name_Btn_Name_Click = function(btn, str)
    WeaponController:ShowCoachDetailPanel(btn, str)
  end,
  HomeCarriageeditor_Group_TrainWeapon_ScrollView_Train_Viewport_Content_Btn_Locomotivehead_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_TrainWeapon_ScrollView_Train_Viewport_Content_Btn_Locomotivehead_Btn_Add1_Click = function(btn, str)
    WeaponController:ClickWeapon(WeaponDataModel.OperatorType.Weapon, 1, 0)
  end,
  HomeCarriageeditor_Group_TrainWeapon_ScrollView_Train_Viewport_Content_Btn_Locomotivehead_Btn_Add1_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_TrainWeapon_ScrollView_Train_Viewport_Content_Btn_Locomotivehead_Btn_Add2_Click = function(btn, str)
    WeaponController:ClickWeapon(WeaponDataModel.OperatorType.Weapon, 2, 0)
  end,
  HomeCarriageeditor_Group_TrainWeapon_ScrollView_Train_Viewport_Content_Btn_Locomotivehead_Btn_Add2_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_TrainWeapon_ScrollView_Train_Viewport_Content_StaticGrid_Train_SetGrid = function(element, elementIndex)
    WeaponController:RefreshCoachElement(element, elementIndex)
  end,
  HomeCarriageeditor_Group_TrainWeapon_ScrollView_Train_Viewport_Content_StaticGrid_Train_Group_Train_1_Group_Name_Btn_Name_Click = function(btn, str)
    WeaponController:ShowCoachDetailPanel(btn, str)
  end,
  HomeCarriageeditor_Group_TrainWeapon_ScrollView_Train_Viewport_Content_StaticGrid_Train_Group_Train_1_Group_Box_Btn_Train_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_TrainWeapon_ScrollView_Train_Viewport_Content_StaticGrid_Train_Group_Train_1_Group_Box_Btn_Add_Click = function(btn, str)
    WeaponController:ClickWeapon(WeaponDataModel.OperatorType.Weapon, 1, tonumber(str))
  end,
  HomeCarriageeditor_Group_TrainWeapon_ScrollView_Train_Viewport_Content_StaticGrid_Train_Group_Train_1_Group_Box_Btn_Add_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_TrainWeapon_Img_AccessoryBg_StaticGrid_Accessory_SetGrid = function(element, elementIndex)
    WeaponController:RefreshAccessoryElement(WeaponDataModel.OperatorType.Parts, element, elementIndex)
  end,
  HomeCarriageeditor_Group_TrainWeapon_Img_AccessoryBg_StaticGrid_Accessory_Group_Accessory_Group_Have_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_TrainWeapon_Img_AccessoryBg_StaticGrid_Accessory_Group_Accessory_Group_Have_Btn_Zhaozi_Click = function(btn, str)
    WeaponController:ClickWeapon(WeaponDataModel.OperatorType.Parts, tonumber(str))
  end,
  HomeCarriageeditor_Group_TrainWeapon_Img_AccessoryBg_StaticGrid_Accessory_Group_Accessory_Group_Empty_Btn_Empty_Click = function(btn, str)
    local coachCA = PlayerData:GetFactoryData(WeaponDataModel.coachHeadInfo.id, "HomeCoachFactory")
    CommonTips.OpenTips(string.format(GetText(80601348), coachCA.accessoryNum))
  end,
  HomeCarriageeditor_Group_TrainWeapon_Img_PendantBg_StaticGrid_Accessory_SetGrid = function(element, elementIndex)
    WeaponController:RefreshAccessoryElement(WeaponDataModel.OperatorType.Pendant, element, elementIndex)
  end,
  HomeCarriageeditor_Group_TrainWeapon_Img_PendantBg_StaticGrid_Accessory_Group_Accessory_Group_Have_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  HomeCarriageeditor_Group_TrainWeapon_Img_PendantBg_StaticGrid_Accessory_Group_Accessory_Group_Have_Btn_Zhaozi_Click = function(btn, str)
    WeaponController:ClickWeapon(WeaponDataModel.OperatorType.Pendant, tonumber(str))
  end,
  HomeCarriageeditor_Group_TrainWeapon_Img_PendantBg_StaticGrid_Accessory_Group_Accessory_Group_Empty_Btn_Empty_Click = function(btn, str)
    local needElectricLv = WeaponDataModel.pendantInfo[tonumber(str)].needElectricLv
    CommonTips.OpenTips(string.format(GetText(80602116), needElectricLv))
  end,
  HomeCarriageeditor_Group_TrainWeapon_Btn_All_Click = function(btn, str)
  end,
  HomeCarriageeditor_Btn_CloseTips_Click = function(btn, str)
    View.Btn_CloseTips:SetActive(false)
    View.Group_Tips.self:SetActive(false)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_SpeedChange_Img_CenterBg_Img_circle1_Btn_Electric_Click = function(btn, str)
    UIManager:Open("UI/Home/HomeElectric")
  end,
  HomeCarriageeditor_Group_Fix_Group_Wash_Group_RubbishStatus_Btn_RubbishBox_Click = function(btn, str)
    Controller:OpenRubbishView()
  end,
  HomeCarriageeditor_Group_Edit_ScrollView_Train_Viewport_Content_StaticGrid_Train_Group_Train_Group_Empty_Btn_Jump_Click = function(btn, str)
    UIManager:Open("UI/Home/HomeElectric")
  end,
  HomeCarriageeditor_Group_Fix_Group_Wash_Img_circle_Group_Limit_Btn_Limit_Click = function(btn, str)
    CommonTips.OnPrompt(string.format(GetText(80601817)), nil, nil, function()
      Controller:OpenRubbishView()
    end)
  end,
  HomeCarriageeditor_Group_TrainRefit_Group_Oil_Group_OilButton_Btn_Button_Click = function(btn, str)
    RefitController:AutoOil()
  end,
  HomeCarriageeditor_Group_TrainSkin_Group_QuickJump_ScrollGrid_QuickJump_SetGrid = function(element, elementIndex)
    SkinController:RefreshCoachElement(element, elementIndex)
  end,
  HomeCarriageeditor_Group_TrainSkin_Group_QuickJump_ScrollGrid_QuickJump_Group_Item_Group_Carriage_Btn_Off_Click = function(btn, str)
    SkinController:ClickCoachElement(str)
  end,
  HomeCarriageeditor_Group_TrainSkin_Group_QuickJump_ScrollGrid_QuickJump_Group_Item_Group_Carriage_Btn_On_Click = function(btn, str)
    SkinController:ClickCoachElement(str)
  end,
  HomeCarriageeditor_Group_TrainSkin_Btn_Use_Click = function(btn, str)
    SkinController:UseSkin()
  end,
  HomeCarriageeditor_Group_TrainSkin_Btn_Unlock_Click = function(btn, str)
    SkinController:UnlockSkin()
  end,
  HomeCarriageeditor_Group_TrainSkin_NewScrollGrid_CarriageSkin_SetGrid = function(element, elementIndex)
    SkinController:RefreshSkinElement(element, elementIndex)
  end,
  HomeCarriageeditor_Group_TrainSkin_NewScrollGrid_CarriageSkin_Group_Item_Group_CarriageSkin_Btn_Button_Click = function(btn, str)
    SkinController:ClickSkinElement(str)
  end
}
return ViewFunction
