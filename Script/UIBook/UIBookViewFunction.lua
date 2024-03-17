local View = require("UIBook/UIBookView")
local DataModel = require("UIBook/UIBookDataModel")
local Role = require("UIBook/UIBookRole")
local CG = require("UIBook/UIBookCG")
local Music = require("UIBook/UIBookMusic")
local Picture = require("UIBook/UIBookPicture")
local Enemy = require("UIBook/UIBookEnemy")
local Hint = require("UIBook/UIBookHint")
local ViewFunction = {
  Book_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if DataModel.CurrentPage == DataModel.EnumPage.CG then
      CG.Close()
    elseif DataModel.CurrentPage == DataModel.EnumPage.Camp then
      Role.CloseCamp()
    elseif DataModel.CurrentPage == DataModel.EnumPage.Role then
      Role.CloseRole()
    elseif DataModel.CurrentPage == DataModel.EnumPage.Music then
      Music.Close()
    elseif DataModel.CurrentPage == DataModel.EnumPage.Picture then
      Picture.Close()
    elseif DataModel.CurrentPage == DataModel.EnumPage.Enemy then
      Enemy.Close()
    elseif DataModel.CurrentPage == DataModel.EnumPage.Hint then
      Hint:Close()
    else
      View.self:PlayAnim("Out")
      UIManager:GoHome()
    end
  end,
  Book_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoHome()
  end,
  Book_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Btn_BG_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Career_Btn_All_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Career_Btn_C01_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Career_Btn_C02_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Career_Btn_C03_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Career_Btn_C04_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Career_Btn_C05_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Career_Btn_C06_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Group_Btn_All_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Group_Btn_G01_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Group_Btn_G02_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Group_Btn_G03_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Group_Btn_G04_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Group_Btn_G05_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Rarity_Btn_All_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Rarity_Btn_R01_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Rarity_Btn_R02_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Rarity_Btn_R03_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Rarity_Btn_R04_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Btn_OK_Click = function(btn, str)
  end,
  Book_Group_Topright_Btn_Role_Click = function(btn, str)
  end,
  Book_Group_Topright_Btn_CG_Click = function(btn, str)
  end,
  Book_Group_Role_Group_Camp_ScrollGrid_Camp_SetGrid = function(element, elementIndex)
    Role.SetCampElement(element, tonumber(elementIndex))
  end,
  Book_Group_Role_Group_Camp_ScrollGrid_Camp_Group_CampIcon_Btn_Camp_Click = function(btn, str)
    Role.OpenRole(tonumber(str))
  end,
  Book_Group_Role_Group_RoleList_Group_Top_Btn_All_Click = function(btn, str)
  end,
  Book_Group_Role_Group_RoleList_Group_Top_Btn_Camp_1_Click = function(btn, str)
  end,
  Book_Group_Role_Group_RoleList_Group_Top_Btn_Camp_2_Click = function(btn, str)
  end,
  Book_Group_Role_Group_RoleList_Group_Top_Btn_Camp_3_Click = function(btn, str)
  end,
  Book_Group_Role_Group_RoleList_Group_Top_Btn_Camp_4_Click = function(btn, str)
  end,
  Book_Group_Role_Group_RoleList_Group_Top_Btn_Camp_5_Click = function(btn, str)
  end,
  Book_Group_Role_Group_RoleList_ScrollGrid_Middle_SetGrid = function(element, elementIndex)
    Role.SetRoleElement(element, tonumber(elementIndex))
  end,
  Book_Group_Role_Group_RoleList_ScrollGrid_Middle_Group_Character_Btn_Item_Click = function(btn, str)
  end,
  Book_Group_CG_ScrollGrid_CG_SetGrid = function(element, elementIndex)
  end,
  Book_Group_CG_Group_Item_Btn_CG_Click = function(btn, str)
  end,
  Book_Group_CG_Group_Item_One_Btn_CG_Click = function(btn, str)
    CG.Play()
  end,
  Book_Group_BookMain_Btn_CG_Click = function(btn, str)
    CG.Open()
  end,
  Book_Group_BookMain_Btn_Role_Click = function(btn, str)
    Role.OpenCamp()
  end,
  Book_Screen_Chapter_Btn_Cancel_Click = function(btn, str)
  end,
  Book_Group_BookMain_Btn_Picture_Click = function(btn, str)
    Picture.Open()
  end,
  Book_Group_BookMain_Btn_Music_Click = function(btn, str)
    CommonTips.OpenTips(80600368)
  end,
  Book_Group_BookMain_Btn_Enemy_Click = function(btn, str)
    Enemy.Open()
  end,
  Book_Screen_Chapter_Group_Career_Btn_C07_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Career_Btn_C08_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Career_Btn_C09_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Group_Btn_G06_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Group_Btn_G07_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Group_Btn_G08_Click = function(btn, str)
  end,
  Book_Screen_Chapter_Group_Group_Btn_G09_Click = function(btn, str)
  end,
  Book_Group_Music_Group_MusicList_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Music.SetElement(element, elementIndex)
  end,
  Book_Group_Music_Group_MusicList_ScrollGrid_List_Group_Music_Btn_Music_Click = function(btn, str)
    Music.OnClickBtn(tonumber(str))
  end,
  Book_Group_Music_Group_Play_Group_Player_Btn_Pause_Click = function(btn, str)
    Music.Pause()
  end,
  Book_Group_Music_Group_Play_Group_Player_Btn_Pre_Click = function(btn, str)
    Music.Last()
  end,
  Book_Group_Music_Group_Play_Group_Player_Btn_Next_Click = function(btn, str)
    Music.Next()
  end,
  Book_Group_Music_Group_Play_Group_Player_Group_Time_Slider_Time_Slider = function(slider, value)
    Music.OnValueChange(value)
  end,
  Book_Group_Music_Group_Play_Group_Player_Group_Time_Slider_Time_SliderDown = function(slider)
    Music.OnPoint(true)
  end,
  Book_Group_Music_Group_Play_Group_Player_Group_Time_Slider_Time_SliderUp = function(slider)
    Music.OnPoint(false)
  end,
  Book_Group_Picture_Group_Item_Btn_Select_Click = function(btn, str)
  end,
  Book_Group_Picture_ScrollGrid_CG_SetGrid = function(element, elementIndex)
    Picture.SetElement(element, elementIndex)
  end,
  Book_Group_Picture_ScrollGrid_CG_Group_Item_Btn_Select_Click = function(btn, str)
    Picture.OnClickBtn(tonumber(str))
  end,
  Book_Group_PictureBig_Btn_Close_Click = function(btn, str)
    View.Group_PictureBig:SetActive(false)
  end,
  Book_Group_Enemy_ScrollGrid_Middle_SetGrid = function(element, elementIndex)
    Enemy.SetElement(element, elementIndex)
  end,
  Book_Group_Enemy_Group_TopRight_Btn_Rarity_Click = function(btn, str)
  end,
  Book_Group_Enemy_Group_TopRight_Btn_Time_Click = function(btn, str)
  end,
  Book_Group_Enemy_Group_TopRight_Btn_Screen_Click = function(btn, str)
  end,
  Book_Group_Enemy_Group_TopRight_Btn_Comat_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Btn_BG_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Career_Btn_All_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Career_Btn_C01_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Career_Btn_C02_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Career_Btn_C03_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Career_Btn_C04_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Career_Btn_C05_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Career_Btn_C06_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Career_Btn_C07_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Career_Btn_C08_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Career_Btn_C09_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Group_Btn_All_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Group_Btn_G01_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Group_Btn_G02_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Group_Btn_G03_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Group_Btn_G04_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Group_Btn_G05_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Group_Btn_G06_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Group_Btn_G07_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Group_Btn_G08_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Group_Btn_G09_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Rarity_Btn_All_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Rarity_Btn_R01_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Rarity_Btn_R02_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Rarity_Btn_R03_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Group_Rarity_Btn_R04_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Btn_OK_Click = function(btn, str)
  end,
  Book_Group_Enemy_Screen_Chapter_Btn_Cancel_Click = function(btn, str)
  end,
  Book_Group_EnemyDetail_Btn_BG_Click = function(btn, str)
    View.Group_EnemyDetail.self:SetActive(false)
  end,
  Book_Group_Enemy_ScrollGrid_Middle_Group_enemy_Btn_Enemy_Click = function(btn, str)
    Enemy.OnClickBtn(tonumber(str))
  end,
  Book_Group_BookMain_Btn_Hint_Click = function(btn, str)
    CommonTips.OpenTips(80600368)
  end,
  Book_Group_Hint_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    Hint:Close()
  end,
  Book_Group_Hint_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  Book_Group_Hint_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Book_Group_Hint_Btn_Postcard_Click = function(btn, str)
    Hint:OpenGroupPostcard()
  end,
  Book_Group_Hint_Btn_Video_Click = function(btn, str)
    Hint:OpenVideo()
  end,
  Book_Group_Hint_Btn_Tape_Click = function(btn, str)
    Hint:OpenTape()
  end,
  Book_Group_Postcard_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    Hint:CloseGroupPostcard()
  end,
  Book_Group_Postcard_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Book_Group_Postcard_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Book_Group_Video_Group_Item_Btn_Select_Click = function(btn, str)
  end,
  Book_Group_Video_ScrollGrid_Video_SetGrid = function(element, elementIndex)
    Hint:RefreshVideo(element, tonumber(elementIndex))
    for i = 1, 8 do
      local obj = "Group_picture_00" .. elementIndex - 1
      element[obj].Btn_click:SetClickParam(elementIndex)
    end
    element.Group_picture_000.Btn_click:SetClickParam(elementIndex)
  end,
  Book_Group_Video_ScrollGrid_Video_Group_Item_Btn_Select_Click = function(btn, str)
  end,
  Book_Group_Video_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    Hint:CloseVideo()
  end,
  Book_Group_Video_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Book_Group_Video_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Book_Group_Tape_Group_Item_Btn_Select_Click = function(btn, str)
  end,
  Book_Group_Tape_ScrollGrid_Tape_SetGrid = function(element, elementIndex)
    Hint:RefreshTape(element, tonumber(elementIndex))
  end,
  Book_Group_Tape_ScrollGrid_Tape_Group_Item_Btn_Select_Click = function(btn, str)
  end,
  Book_Group_Tape_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    Hint:CloseTape()
  end,
  Book_Group_Tape_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Book_Group_Tape_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Book_Group_CG_Video_CG_Skip_Click = function(btn, str)
  end,
  Book_Group_Postcard_ScrollGrid_Hint_SetGrid = function(element, elementIndex)
    Hint:RefreshPostCard(element, tonumber(elementIndex))
    for i = 1, 8 do
      local obj = "Group_picture_00" .. i - 1
      element[obj].Btn_click:SetClickParam(elementIndex)
    end
  end,
  Book_Group_Postcard_ScrollGrid_Hint_Group_NewPic_Group_picture_000_Btn_click_Click = function(btn, str)
    local row = DataModel.PostCardList[tonumber(str)][1]
    print_r(row)
    if row.isLock == true then
      return
    end
    Hint:ClickPostCard(row)
  end,
  Book_Group_Postcard_ScrollGrid_Hint_Group_NewPic_Group_picture_001_Btn_click_Click = function(btn, str)
    print_r(str)
    local row = DataModel.PostCardList[tonumber(str)][2]
    print_r(row)
    if row.isLock == true then
      return
    end
    Hint:ClickPostCard(row)
  end,
  Book_Group_Postcard_ScrollGrid_Hint_Group_NewPic_Group_picture_002_Btn_click_Click = function(btn, str)
    local row = DataModel.PostCardList[tonumber(str)][3]
    print_r(row)
    if row.isLock == true then
      return
    end
    Hint:ClickPostCard(row)
  end,
  Book_Group_Postcard_ScrollGrid_Hint_Group_NewPic_Group_picture_003_Btn_click_Click = function(btn, str)
    local row = DataModel.PostCardList[tonumber(str)][4]
    print_r(row)
    if row.isLock == true then
      return
    end
    Hint:ClickPostCard(row)
  end,
  Book_Group_Postcard_ScrollGrid_Hint_Group_NewPic_Group_picture_004_Btn_click_Click = function(btn, str)
    local row = DataModel.PostCardList[tonumber(str)][5]
    print_r(row)
    if row.isLock == true then
      return
    end
    Hint:ClickPostCard(row)
  end,
  Book_Group_Postcard_ScrollGrid_Hint_Group_NewPic_Group_picture_005_Btn_click_Click = function(btn, str)
    local row = DataModel.PostCardList[tonumber(str)][6]
    print_r(row)
    if row.isLock == true then
      return
    end
    Hint:ClickPostCard(row)
  end,
  Book_Group_Postcard_ScrollGrid_Hint_Group_NewPic_Group_picture_006_Btn_click_Click = function(btn, str)
    local row = DataModel.PostCardList[tonumber(str)][7]
    print_r(row)
    if row.isLock == true then
      return
    end
    Hint:ClickPostCard(row)
  end,
  Book_Group_Postcard_ScrollGrid_Hint_Group_NewPic_Group_picture_007_Btn_click_Click = function(btn, str)
    local row = DataModel.PostCardList[tonumber(str)][8]
    print_r(row)
    if row.isLock == true then
      return
    end
    Hint:ClickPostCard(row)
  end,
  Book_Group_Roles_Btn_Role_Click = function(btn, str)
    Role.OpenCamp()
  end,
  Book_Group_Roles_Btn_Enemy_Click = function(btn, str)
    Enemy.Open()
  end,
  Book_Group_PC_Btn_CG_Click = function(btn, str)
    CG.Open()
  end,
  Book_Group_PC_Btn_Picture_Click = function(btn, str)
    Picture.Open()
  end,
  Book_Group_Role_Group_RoleList_ScrollGrid_Middle_Group_Character_Btn_Mask_Click = function(btn, str)
  end,
  Book_Group_Role_Group_RoleList_ScrollGrid_Middle_Group_Character_Group_Break_StaticGrid_BK_SetGrid = function(element, elementIndex)
  end,
  Book_Group_Postcard_Group_Item_ScrollGrid_Postcard_SetGrid = function(element, elementIndex)
  end,
  Book_Group_Postcard_Group_Item_ScrollGrid_Postcard_Group_Item_Btn_Select_Click = function(btn, str)
  end,
  Book_Group_Postcard_Group_Item_Btn_Select_Click = function(btn, str)
  end
}
return ViewFunction
