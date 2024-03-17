local View = require("UICharacterList/UICharacterListView")
local BtnController = require("UICharacterList/Controller_Btn")
local DataModel = require("UICharacterList/UICharacterListDataModel")
local ElementModel = require("UICharacterList/Model_Element")
local PaintingModel = require("UICharacterList/Model_Painting")
local ViewFunction = {
  CharacterList_ScrollGrid_Middle_SetGrid = function(element, elementIndex)
    local roleData = PlayerData.ServerData.roles[DataModel.Roles[elementIndex]]
    element.Btn_Item:SetClickParam(elementIndex)
    DataModel.RefreshBreakIndex = elementIndex
    ElementModel.SetElement(element, roleData)
  end,
  CharacterList_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if DataModel.isSetPainting then
      PaintingModel.SetPainting()
    else
      View.self:PlayAnim("Out")
      UIManager:GoBack()
    end
  end,
  CharacterList_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    if DataModel.isSetPainting then
      PaintingModel.SetPainting()
    else
      View.self:PlayAnim("Out")
      UIManager:GoHome()
    end
  end,
  CharacterList_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  CharacterList_Group_TopRight_Btn_Level_Click = function(btn, str)
    BtnController:Click(View.Group_TopRight.Btn_Level)
  end,
  CharacterList_Group_TopRight_Btn_Rarity_Click = function(btn, str)
    BtnController:Click(View.Group_TopRight.Btn_Rarity)
  end,
  CharacterList_Group_TopRight_Btn_Time_Click = function(btn, str)
    BtnController:Click(View.Group_TopRight.Btn_Time)
  end,
  CharacterList_Group_TopRight_Btn_Screen_Click = function(btn, str)
    BtnController.Open_Screen_Chapter(true)
  end,
  CharacterList_Group_TopRight_Btn_Comat_Click = function(btn, str)
  end,
  CharacterList_Screen_Chapter_Btn_BG_Click = function(btn, str)
    BtnController.Open_Screen_Chapter(false)
  end,
  CharacterList_Screen_Chapter_Group_Career_Btn_All_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Career, btn, 0)
  end,
  CharacterList_Screen_Chapter_Group_Career_Btn_C01_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Career, btn, 1)
  end,
  CharacterList_Screen_Chapter_Group_Career_Btn_C02_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Career, btn, 2)
  end,
  CharacterList_Screen_Chapter_Group_Career_Btn_C03_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Career, btn, 3)
  end,
  CharacterList_Screen_Chapter_Group_Career_Btn_C04_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Career, btn, 4)
  end,
  CharacterList_Screen_Chapter_Group_Career_Btn_C05_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Career, btn, 5)
  end,
  CharacterList_Screen_Chapter_Group_Career_Btn_C06_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Career, btn, 6)
  end,
  CharacterList_Screen_Chapter_Group_Group_Btn_All_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Group, btn, 0)
  end,
  CharacterList_Screen_Chapter_Group_Group_Btn_G01_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Group, btn, 1)
  end,
  CharacterList_Screen_Chapter_Group_Group_Btn_G02_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Group, btn, 2)
  end,
  CharacterList_Screen_Chapter_Group_Group_Btn_G03_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Group, btn, 3)
  end,
  CharacterList_Screen_Chapter_Group_Group_Btn_G04_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Group, btn, 4)
  end,
  CharacterList_Screen_Chapter_Group_Group_Btn_G05_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Group, btn, 5)
  end,
  CharacterList_Screen_Chapter_Group_Rarity_Btn_All_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Rarity, btn, 0)
  end,
  CharacterList_Screen_Chapter_Group_Rarity_Btn_R01_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Rarity, btn, 1)
  end,
  CharacterList_Screen_Chapter_Group_Rarity_Btn_R02_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Rarity, btn, 2)
  end,
  CharacterList_Screen_Chapter_Group_Rarity_Btn_R03_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Rarity, btn, 3)
  end,
  CharacterList_Screen_Chapter_Group_Rarity_Btn_R04_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Rarity, btn, 4)
  end,
  CharacterList_Screen_Chapter_Btn_OK_Click = function(btn, str)
    BtnController.Open_Screen_Chapter(false)
    BtnController.Filter()
  end,
  CharacterList_ScrollGrid_Middle_Group_Character_Btn_Item_Click = function(btn, str)
    local idx = tonumber(str)
    DataModel.selectRoleIndex = idx
    if DataModel.isSetPainting then
      DataModel.selectRoleId = tostring(DataModel.Roles[idx])
      View.ScrollGrid_Middle.grid.self:RefreshAllElement()
      PaintingModel.SetPainting()
    else
      View.self:PlayAnim("Out")
      local data = {
        sortType = DataModel.SortType,
        currentRoleId = DataModel.Roles[idx],
        fromView = EnumDefine.CommonFilterType.OtherSort
      }
      Net:SendProto("hero.info", function(json)
        if json.roles then
          PlayerData.ServerData.roles[DataModel.Roles[idx]] = json.roles[DataModel.Roles[idx]]
          UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
        end
      end, tonumber(DataModel.Roles[idx]))
    end
  end,
  CharacterList_ScrollGrid_Middle_Group_Character_Group_Break_StaticGrid_BK_SetGrid = function(element, elementIndex)
    local roleData = PlayerData.ServerData.roles[DataModel.Roles[DataModel.RefreshBreakIndex]]
    element.Img_On:SetActive(false)
    if elementIndex <= roleData.awake_lv then
      element.Img_On:SetActive(true)
    end
  end,
  CharacterList_Screen_Chapter_Btn_Cancel_Click = function(btn, str)
    BtnController.Open_Screen_Chapter(false)
  end,
  CharacterList_Screen_Chapter_Group_Career_Btn_C07_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Career, btn, 7)
  end,
  CharacterList_Screen_Chapter_Group_Career_Btn_C08_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Career, btn, 8)
  end,
  CharacterList_Screen_Chapter_Group_Career_Btn_C09_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Career, btn, 9)
  end,
  CharacterList_Screen_Chapter_Group_Group_Btn_G06_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Group, btn, 6)
  end,
  CharacterList_Screen_Chapter_Group_Group_Btn_G07_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Group, btn, 7)
  end,
  CharacterList_Screen_Chapter_Group_Group_Btn_G08_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Group, btn, 8)
  end,
  CharacterList_Screen_Chapter_Group_Group_Btn_G09_Click = function(btn, str)
    BtnController.ScreenBtn(View.Screen_Chapter.Group_Group, btn, 9)
  end,
  CharacterList_ScrollGrid_Middle_Group_Character_Btn_Mask_Click = function(btn, str)
  end,
  CharacterList_Group_TopLeft_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end
}
return ViewFunction
