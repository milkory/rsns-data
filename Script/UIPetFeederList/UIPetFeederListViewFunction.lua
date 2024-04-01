local View = require("UIPetFeederList/UIPetFeederListView")
local DataModel = require("UIPetFeederList/UIPetFeederListDataModel")
local ElementModel = require("UICharacterList/Model_Element")
local BindFeeder = function(data, roleId, u_pet)
  Net:SendProto("pet.bind", function()
    local pet = PlayerData:GetHomeInfo().pet[DataModel.u_pet]
    if pet.role_id and pet.role_id ~= "" then
      PlayerData:GetRoleById(pet.role_id).u_pet = ""
    end
    if pet.lv > 7 and pet.role_id ~= "" then
      pet.lv = 7
      pet.buff_list = {}
      pet.favor = 0
    end
    pet.role_id = roleId
    PlayerData:GetRoleById(data.roleId).u_pet = u_pet
    UIManager:GoBack()
  end, DataModel.u_pet, roleId)
end
local RefreshRoleList = function(nowSelectId, Up)
  local item = View.Group_TopRight
  local topTog = {
    item.Btn_Level,
    item.Btn_Rarity,
    item.Btn_Time,
    item.Btn_Screen
  }
  if nowSelectId == DataModel.selectTogId then
    local angel = Up and 0 or 180
    topTog[DataModel.selectTogId].Img_Select.Img_:SetLocalEulerAngles(angel)
    topTog[DataModel.selectTogId].Img_Normal.Img_:SetLocalEulerAngles(angel)
  else
    topTog[nowSelectId].Img_Select.self:SetActive(true)
    topTog[DataModel.selectTogId].Img_Select.self:SetActive(false)
    DataModel.selectTogId = nowSelectId
  end
  View.ScrollGrid_Middle.grid.self:SetDataCount(#DataModel.sortData)
  View.ScrollGrid_Middle.grid.self:RefreshAllElement()
end
local ViewFunction = {
  PetFeederList_ScrollGrid_Middle_SetGrid = function(element, elementIndex)
    local data = DataModel.sortData[elementIndex]
    DataModel.roleData = PlayerData:GetRoleById(data.roleId)
    ElementModel.SetElement(element, DataModel.roleData)
    element.Btn_Item:SetClickParam(elementIndex)
    element.Group_Pet:SetActive(DataModel.u_pet == data.u_pet)
    element.Img_Selected:SetActive(false)
  end,
  PetFeederList_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  PetFeederList_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
    if HomeManager.cam.isLock then
      local mainUIView = require("UIMainUI/UIMainUIView")
      mainUIView.self:SetRaycastBlock(false)
      HomeManager:CamFocusEnd(function()
        mainUIView.self:SetRaycastBlock(true)
      end)
    end
  end,
  PetFeederList_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  PetFeederList_Group_TopRight_Btn_Level_Click = function(btn, str)
    if DataModel.selectTogId == 1 then
      DataModel.lvUp = not DataModel.lvUp
    end
    DataModel.SortData(DataModel.lvFirst)
    RefreshRoleList(1, DataModel.lvUp)
  end,
  PetFeederList_Group_TopRight_Btn_Rarity_Click = function(btn, str)
    if DataModel.selectTogId == 2 then
      DataModel.qualityUp = not DataModel.qualityUp
    end
    DataModel.SortData(DataModel.qualityFirst)
    RefreshRoleList(2, DataModel.qualityUp)
  end,
  PetFeederList_Group_TopRight_Btn_Time_Click = function(btn, str)
    if DataModel.selectTogId == 3 then
      DataModel.timeUp = not DataModel.timeUp
    end
    DataModel.SortData(DataModel.timeFirst)
    RefreshRoleList(3, DataModel.timeUp)
  end,
  PetFeederList_Group_TopRight_Btn_Comat_Click = function(btn, str)
  end,
  PetFeederList_ScrollGrid_Middle_Group_Character_Btn_Mask_Click = function(btn, str)
  end,
  PetFeederList_ScrollGrid_Middle_Group_Character_Group_Break_StaticGrid_BK_SetGrid = function(element, elementIndex)
    element.Img_On:SetActive(false)
    if elementIndex <= DataModel.roleData.awake_lv then
      element.Img_On:SetActive(true)
    end
  end,
  PetFeederList_ScrollGrid_Middle_Group_Character_Btn_Item_Click = function(btn, str)
    local index = tonumber(str)
    local data = DataModel.sortData[index]
    local u_pet = DataModel.u_pet
    local roleId = data.roleId
    local petInfo = PlayerData:GetHomeInfo().pet[DataModel.u_pet]
    local petName = petInfo.name ~= "" and petInfo.name or PlayerData:GetFactoryData(petInfo.id).petName
    local roleName = PlayerData:GetFactoryData(roleId).name
    if u_pet == data.u_pet then
      u_pet = ""
      roleId = ""
    end
    if petInfo.lv > 7 and petInfo.role_id ~= "" then
      if u_pet ~= data.u_pet then
        roleName = PlayerData:GetFactoryData(petInfo.role_id).name
      end
      CommonTips.OnPrompt(string.format(GetText(80601010), petName, roleName), nil, nil, function()
        BindFeeder(data, roleId, u_pet)
      end)
    else
      BindFeeder(data, roleId, u_pet)
    end
  end,
  PetFeederList_Group_TopLeft_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  PetFeederList_Group_TopRight_Btn_Screen_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Btn_BG_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Btn_OK_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Btn_Cancel_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Career_Btn_All_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Career_Btn_C01_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Career_Btn_C02_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Career_Btn_C03_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Career_Btn_C04_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Career_Btn_C05_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Career_Btn_C06_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Career_Btn_C07_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Career_Btn_C08_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Career_Btn_C09_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Group_Btn_All_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Group_Btn_G01_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Group_Btn_G02_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Group_Btn_G03_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Group_Btn_G04_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Group_Btn_G05_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Group_Btn_G06_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Group_Btn_G07_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Group_Btn_G08_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Group_Btn_G09_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Rarity_Btn_All_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Rarity_Btn_R01_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Rarity_Btn_R02_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Rarity_Btn_R03_Click = function(btn, str)
  end,
  PetFeederList_Screen_Chapter_Group_Rarity_Btn_R04_Click = function(btn, str)
  end
}
return ViewFunction
