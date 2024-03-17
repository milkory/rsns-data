local View = require("UIPetManage/UIPetManageView")
local DataModel = require("UIPetManage/UIPetManageDataModel")
local nowIndex
local SortReshFreshPanel = function(isActive, btn, clickType)
  local angel = 0
  if clickType == 1 then
    DataModel.favorUp = not DataModel.favorUp
    angel = DataModel.favorUp and 0 or 180
    DataModel.SortData(DataModel.favorFirst)
  elseif clickType == 2 then
    DataModel.timeUp = not DataModel.timeUp
    angel = DataModel.timeUp and 0 or 180
    DataModel.SortData(DataModel.timeFirst)
  end
  if isActive then
    btn.Img_Select.Img_:SetLocalEulerAngles(angel)
    btn.Img_Normal.Img_:SetLocalEulerAngles(angel)
  else
    btn.Img_Select:SetActive(true)
    DataModel.Img_Select:SetActive(false)
    DataModel.Img_Select = btn.Img_Select
  end
  View.Group_Pets.ScrollGrid_PetList.grid.self:SetDataCount(#DataModel.sortData)
  View.Group_Pets.ScrollGrid_PetList.grid.self:RefreshAllElement()
end
local ViewFunction = {
  PetManage_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  PetManage_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  PetManage_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_SetGrid = function(element, elementIndex)
    nowIndex = elementIndex
    local furniture = PlayerData:GetHomeInfo().furniture[DataModel.petFurList[elementIndex].u_fid]
    element.StaticGrid_Rooms.grid.self:RefreshAllElement(#furniture.house.pets)
    local fCfg = PlayerData:GetFactoryData(furniture.id)
    local nowFoodNum = furniture.house.food_num or 0
    local foodCapacity = fCfg.maxFood
    element.Group_HouseFood.Txt_:SetText(string.format(GetText(80601029), nowFoodNum, foodCapacity))
    local houseName = furniture.name == "" and fCfg.name or furniture.name
    element.Group_HouseName.Img_HouseName.Txt_HouseName:SetText(houseName)
    element.Group_HouseNo.Txt_:SetText(elementIndex)
    element.Group_Place.Txt_:SetText(string.format(GetText(80601087), DataModel.petFurList[elementIndex].roomId + 1))
    element.Btn_Go:SetClickParam(elementIndex)
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_Group_GoHouse_List_StaticGrid_Rooms_SetGrid = function(element, elementIndex)
    local furniture = PlayerData:GetHomeInfo().furniture[DataModel.petFurList[nowIndex].u_fid]
    local fCfg = PlayerData:GetFactoryData(furniture.id)
    local petNum = fCfg.PetNum
    if elementIndex <= petNum then
      element.Group_Locked:SetActive(false)
      if not furniture.house.pets[elementIndex] then
        furniture.house.pets[elementIndex] = ""
      end
      local isPet = furniture.house.pets[elementIndex] ~= "" and true or false
      element.Group_Pet:SetActive(isPet)
      element.Group_CheckIn:SetActive(not isPet)
      if isPet then
        local petInfo = PlayerData:GetHomeInfo().pet[furniture.house.pets[elementIndex]]
        local petId = petInfo.id
        local petCfg = PlayerData:GetFactoryData(petId)
        local petIcon = petCfg.petIconPath
        element.Group_Pet.Img_Pet:SetSprite(petIcon)
        local name = petInfo.name ~= "" and petInfo.name or petCfg.petName
        element.Group_Pet.Group_Name.Txt_Name:SetText(name)
        element.Group_Pet.Group_Love.Txt_LoveLevel:SetText("LV " .. petInfo.lv)
        element.Group_Pet.Btn_:SetClickParam(elementIndex .. "|" .. nowIndex)
        element.Group_Pet.Group_State:SetActive(false)
      else
        element.Group_CheckIn.Btn_CheckIn:SetClickParam(DataModel.petFurList[nowIndex].u_fid)
      end
    else
      element.Group_Locked:SetActive(true)
      element.Group_CheckIn:SetActive(false)
      element.Group_Pet:SetActive(false)
    end
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_Group_GoHouse_List_StaticGrid_Rooms_Group_Room2_Group_CheckIn_Btn_CheckIn_Click = function(btn, str)
    print("----打开入住界面")
    UIManager:Open("UI/HomePet/PetList", Json.encode({selectType = 2, ufid = str}))
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_Group_GoHouse_List_StaticGrid_Rooms_Group_Room2_Group_Pet_Group_State_Btn__Click = function(btn, str)
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_Group_GoHouse_List_StaticGrid_Rooms_Group_Room2_Group_Pet_Btn__Click = function(btn, str)
    print("--宠物详情")
    local result = string.split(str, "|")
    local petIndex = tonumber(result[1])
    local furIndex = tonumber(result[2])
    local data = {}
    local furniture = PlayerData:GetHomeInfo().furniture[DataModel.petFurList[furIndex].u_fid]
    local fCfg = PlayerData:GetFactoryData(furniture.id)
    local petNum = fCfg.PetNum
    local index = 0
    local now_pet_index = 0
    for i = 1, petNum do
      local pet_uid = DataModel.petFurList[furIndex].pets[i]
      local value = PlayerData:GetHomeInfo().pet[pet_uid]
      if value then
        table.insert(data, pet_uid)
        value.pet_uid = pet_uid
        index = index + 1
        if petIndex == i then
          now_pet_index = index
        end
      end
    end
    UIManager:Open("UI/HomePet/PetInfo", Json.encode({petList = data, selectIndex = now_pet_index}))
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_Group_GoHouse_List_Btn_Go_Click = function(btn, str)
    local fur = DataModel.petFurList[tonumber(str)]
    View.self:StartC(LuaUtil.cs_generator(function()
      HomeManager:CloseCamAni()
      HomeManager.camRoom = fur.roomId
      HomeManager.cam:SetCameraPosx(HomeManager.rooms[fur.roomId].model.transform.position.x + fur.posx)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
      UIManager:Open("UI/HomePet/PetHouse", Json.encode({
        ufid = fur.u_fid
      }))
    end))
  end,
  PetManage_Group_Pets_ScrollGrid_PetList_SetGrid = function(element, elementIndex)
    local data = DataModel.sortData[elementIndex]
    local petCfg = PlayerData:GetFactoryData(data.id)
    local name = data.name ~= "" and data.name or petCfg.petName
    element.Group_Name.Txt_Name:SetText(name)
    element.Group_Love.Txt_Love:SetText(data.lv)
    local icon = petCfg.petIconPath
    element.Img_Pet:SetSprite(icon)
    element.Group_OtherHouse:SetActive(false)
    element.Group_Selected:SetActive(false)
    if data.u_fid ~= "" then
      element.Group_OtherHouse:SetActive(true)
    end
    element.Btn_PetUnit:SetClickParam(elementIndex)
  end,
  PetManage_Group_Pets_ScrollGrid_PetList_Group_PetUnit_Btn_PetUnit_Click = function(btn, str)
    local petList = {}
    for i, v in ipairs(DataModel.sortData) do
      table.insert(petList, v.pet_uid)
    end
    UIManager:Open("UI/HomePet/PetInfo", Json.encode({petList = petList, selectIndex = str}))
  end,
  PetManage_Group_Pets_Group_TopRight_Btn_Love_Click = function(btn, str)
    local btn = View.Group_Pets.Group_TopRight.Btn_Love
    local isActive = btn.Img_Select.IsActive
    SortReshFreshPanel(isActive, btn, 1)
  end,
  PetManage_Group_Pets_Group_TopRight_Btn_Time_Click = function(btn, str)
    local btn = View.Group_Pets.Group_TopRight.Btn_Time
    local isActive = btn.Img_Select.IsActive
    SortReshFreshPanel(isActive, btn, 1)
  end,
  PetManage_Group_Pets_Group_TopRight_Btn_Screen_Click = function(btn, str)
    View.Screen_Filter:SetActive(true)
    View.Screen_Filter.ScrollGrid_PetVarity.grid.self:SetDataCount(DataModel.petKindsCount)
    View.Screen_Filter.ScrollGrid_PetVarity.grid.self:RefreshAllElement()
    DataModel.now_kinds = Clone(DataModel.selectKindList)
  end,
  PetManage_Btn_PetHouses_Click = function(btn, str)
    if View.Btn_PetHouses.Img_UnSelected.IsActive then
      View.Group_PetHouses:SetActive(true)
      View.Group_Pets:SetActive(false)
      View.Btn_PetHouses.Img_UnSelected:SetActive(false)
      View.Btn_Pets.Img_UnSelected:SetActive(true)
    end
  end,
  PetManage_Btn_Pets_Click = function(btn, str)
    if View.Btn_Pets.Img_UnSelected.IsActive then
      View.Group_PetHouses:SetActive(false)
      View.Group_Pets:SetActive(true)
      View.Group_Pets.ScrollGrid_PetList.grid.self:SetDataCount(#DataModel.sortData)
      View.Group_Pets.ScrollGrid_PetList.grid.self:RefreshAllElement()
      View.Btn_PetHouses.Img_UnSelected:SetActive(true)
      View.Btn_Pets.Img_UnSelected:SetActive(false)
    end
  end,
  PetManage_Screen_Filter_Btn_BG_Click = function(btn, str)
    View.Screen_Filter:SetActive(false)
    DataModel.selectKindList = DataModel.now_kinds
  end,
  PetManage_Screen_Filter_ScrollGrid_PetVarity_SetGrid = function(element, elementIndex)
    local id = DataModel.petKindsList[elementIndex].id
    local data = PlayerData:GetFactoryData(id)
    element.Btn_Varity.Img_Select:SetActive(DataModel.selectKindList[id])
    element.Btn_Varity.Txt_:SetText(data.petVarity)
    element.Btn_Varity:SetClickParam(id)
  end,
  PetManage_Screen_Filter_ScrollGrid_PetVarity_Group_Varity_Btn_Varity_Click = function(btn, str)
    local id = tonumber(str)
    local selectImg = btn.transform:Find("Img_Select"):GetComponent(typeof(CS.Seven.UIImg))
    if DataModel.selectKindList[id] then
      DataModel.selectKindList[id] = nil
      selectImg:SetActive(false)
      DataModel.selectKindList.count = DataModel.selectKindList.count - 1
    else
      DataModel.selectKindList[id] = true
      selectImg:SetActive(true)
      DataModel.selectKindList.count = DataModel.selectKindList.count + 1
    end
  end,
  PetManage_Screen_Filter_Btn_OK_Click = function(btn, str)
    View.Screen_Filter:SetActive(false)
    DataModel.SelectSortData()
    local conditionList = DataModel.favorUp and DataModel.favorFirst or DataModel.timeFirst
    DataModel.SortData(conditionList)
    View.Group_Pets.ScrollGrid_PetList.grid.self:SetDataCount(#DataModel.sortData)
    View.Group_Pets.ScrollGrid_PetList.grid.self:RefreshAllElement()
    local count = DataModel.selectKindList.count
    if count == 0 or count == DataModel.petKindsCount then
      View.Group_Pets.Group_TopRight.Btn_Screen.Img_Select:SetActive(false)
    else
      View.Group_Pets.Group_TopRight.Btn_Screen.Img_Select:SetActive(true)
    end
  end,
  PetManage_Screen_Filter_Btn_Cancel_Click = function(btn, str)
    View.Screen_Filter:SetActive(false)
    DataModel.selectKindList = DataModel.now_kinds
  end,
  PetManage_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end
}
return ViewFunction
