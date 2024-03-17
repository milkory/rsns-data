local View = require("UINewHomeLive/UINewHomeLiveView")
local DataModel = require("UINewHomeLive/UINewHomeLiveDataModel")
local Controller = require("UINewHomeLive/UINewHomeLiveController")
local ViewFunction = {
  NewHomeLive_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
    local mainUIView = require("UIMainUI/UIMainUIView")
    mainUIView.self:SetRaycastBlock(false)
    HomeManager:CamFocusEnd(function()
      mainUIView.self:SetRaycastBlock(true)
    end)
  end,
  NewHomeLive_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
    local mainUIView = require("UIMainUI/UIMainUIView")
    mainUIView.self:SetRaycastBlock(false)
    HomeManager:CamFocusEnd(function()
      mainUIView.self:SetRaycastBlock(true)
    end)
  end,
  NewHomeLive_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  NewHomeLive_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  NewHomeLive_Group_Details_Group_Bed_Group_Bed1_Group_Checkin_Btn_Checkin_Click = function(btn, str)
    DataModel.curLiveInPos = 1
    Controller.RefreshSelectLiveIn(DataModel.ESortType.level)
  end,
  NewHomeLive_Group_Details_Group_Bed_Group_Bed1_Group_Change_Group_Member_Btn_Change_Click = function(btn, str)
    DataModel.curLiveInPos = 1
    Controller.RefreshSelectLiveIn(1)
  end,
  NewHomeLive_Group_Details_Group_Bed_Group_Bed1_Group_Change_Group_sleep_Btn_gotoSleep_Click = function(btn, str)
    PosClickHandler.GotoSleep(DataModel.curFurUfid, 1)
  end,
  NewHomeLive_Group_Details_Group_Bed_Group_Bed2_Group_Checkin_Btn_Checkin_Click = function(btn, str)
    DataModel.curLiveInPos = 2
    Controller.RefreshSelectLiveIn(DataModel.ESortType.level)
  end,
  NewHomeLive_Group_Details_Group_Bed_Group_Bed2_Group_Change_Group_Member_Btn_Change_Click = function(btn, str)
    DataModel.curLiveInPos = 2
    Controller.RefreshSelectLiveIn(DataModel.ESortType.level)
  end,
  NewHomeLive_Group_Details_Group_Bed_Group_Bed2_Group_Change_Group_sleep_Btn_gotoSleep_Click = function(btn, str)
    PosClickHandler.GotoSleep(DataModel.curFurUfid, 2)
  end,
  NewHomeLive_Group_CharacterList_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.Group_CharacterList:SetActive(false)
  end,
  NewHomeLive_Group_CharacterList_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
    local mainUIView = require("UIMainUI/UIMainUIView")
    mainUIView.self:SetRaycastBlock(false)
    HomeManager:CamFocusEnd(function()
      mainUIView.self:SetRaycastBlock(true)
    end)
  end,
  NewHomeLive_Group_CharacterList_Group_TopLeft_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  NewHomeLive_Group_CharacterList_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  NewHomeLive_Group_CharacterList_Group_TopRight_Btn_Level_Click = function(btn, str)
    Controller.RefreshSelectLiveIn(DataModel.ESortType.level)
  end,
  NewHomeLive_Group_CharacterList_Group_TopRight_Btn_Rarity_Click = function(btn, str)
    Controller.RefreshSelectLiveIn(DataModel.ESortType.quality)
  end,
  NewHomeLive_Group_CharacterList_Group_TopRight_Btn_Time_Click = function(btn, str)
    Controller.RefreshSelectLiveIn(DataModel.ESortType.time)
  end,
  NewHomeLive_Group_CharacterList_Group_TopRight_Btn_Comat_Click = function(btn, str)
  end,
  NewHomeLive_Group_CharacterList_ScrollGrid__SetGrid = function(element, elementIndex)
    local info = DataModel.allCanLiveInCharacter[elementIndex]
    element.Group_Character.Group_State:SetActive(info.liveInfo ~= nil)
    if info.liveInfo ~= nil then
      local isCurLive = info.liveInfo.ufid == DataModel.curFurUfid
      element.Group_Character.Group_State.Group_Livehere:SetActive(isCurLive)
      element.Group_Character.Group_State.Group_Liveelse:SetActive(not isCurLive)
      if not isCurLive then
        local roomIdx = HomeManager:GetFurnitureByUfid(info.liveInfo.ufid).roomIdx + 1
        element.Group_Character.Group_State.Group_Liveelse.Img_Label.Txt_:SetText(roomIdx .. "车厢")
      end
    end
    element.Group_Character.Img_Bottom:SetSprite(UIConfig.CharacterBottom[info.qualityInt])
    local portraitId = PlayerData:GetRoleById(info.id).current_skin[1]
    local unitViewCA = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    element.Group_Character.Img_Character.Img_Character:SetSprite(unitViewCA.roleListResUrl)
    local ca = PlayerData:GetFactoryData(info.id, "UnitFactory")
    if PlayerData:GetRoleById(info.id).current_skin[2] == 1 and ca.isSpine2 == 1 then
      element.Group_Character.Img_Character.Img_Character:SetSprite(unitViewCA.State2RoleListRes)
    end
    element.Group_Character.Btn_Item:SetClickParam(info.id)
    element.Group_Character.Txt_Name:SetText(info.name)
    element.Group_Character.Txt_LVNum:SetText(info.lv)
    element.Group_Character.Group_Awake.Img_Awake:SetSprite("UI/Common/Common_icon_Awake_" .. info.awake_lv)
    local cardList = PlayerData:GetRoleCardList(ca.id)
    for i = 1, table.count(cardList) do
      local cardCA = PlayerData:GetFactoryData(cardList[table.count(cardList) - i + 1].id)
      local color = cardCA.color
      element.Group_Character.Group_SkillColor["Group_SkillColor" .. i].Img_Color:SetSprite(UIConfig.CharacterSkillColor[color])
    end
    local Group_Locate = element.Group_Character.Group_SkillColor.Group_Locate
    Group_Locate.Img_Line:SetSprite(UIConfig.CharacterLine[ca.line])
    element.Group_Character.Img_Decorate:SetSprite(UIConfig.CharacterDecorate[info.qualityInt])
    DataModel.roleIndex = elementIndex
    element.Group_Character.Group_Break.StaticGrid_BK.grid.self:RefreshAllElement()
  end,
  NewHomeLive_Group_CharacterList_ScrollGrid__Group_Item_Group_Character_Btn_Mask_Click = function(btn, str)
  end,
  NewHomeLive_Group_CharacterList_ScrollGrid__Group_Item_Group_Character_Group_Break_StaticGrid_BK_SetGrid = function(element, elementIndex)
    local roleData = DataModel.allCanLiveInCharacter[DataModel.roleIndex]
    element.Img_On:SetActive(elementIndex <= roleData.awake_lv)
  end,
  NewHomeLive_Group_CharacterList_ScrollGrid__Group_Item_Group_Character_Btn_Item_Click = function(btn, str)
    Controller.CharacterLiveIn(str)
  end,
  NewHomeLive_Group_Details_Group_Light_Img_colordisc_Btn_red_Click = function(btn, str)
    Controller.SetRotateZAndColor(EnumDefine.EFurLightColorType.Red, true)
  end,
  NewHomeLive_Group_Details_Group_Light_Img_colordisc_Btn_purple_Click = function(btn, str)
    Controller.SetRotateZAndColor(EnumDefine.EFurLightColorType.Purple, true)
  end,
  NewHomeLive_Group_Details_Group_Light_Img_colordisc_Btn_green_Click = function(btn, str)
    Controller.SetRotateZAndColor(EnumDefine.EFurLightColorType.Green, true)
  end,
  NewHomeLive_Group_Details_Group_Light_Img_colordisc_Btn_yellow_Click = function(btn, str)
    Controller.SetRotateZAndColor(EnumDefine.EFurLightColorType.Yellow, true)
  end,
  NewHomeLive_Group_Details_Group_Light_Img_colordisc_Btn_blue_Click = function(btn, str)
    Controller.SetRotateZAndColor(EnumDefine.EFurLightColorType.Blue, true)
  end,
  NewHomeLive_Group_Details_Group_Light_Img_colordisc_Btn_cyan_Click = function(btn, str)
    Controller.SetRotateZAndColor(EnumDefine.EFurLightColorType.Cyan, true)
  end
}
return ViewFunction
