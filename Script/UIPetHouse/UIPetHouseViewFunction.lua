local View = require("UIPetHouse/UIPetHouseView")
local DataModel = require("UIPetHouse/UIPetHouseDataModel")
local CommonItem = require("Common/BtnItem")
local RefreshFoodInfo = function()
  View.Group_LeftPanel.Group_PetScore.Txt_Score:SetText(DataModel.houseScores)
  View.Group_LeftPanel.Group_PetHouseGarbage.Txt_Garbage:SetText(string.format(GetText(80600743), DataModel.wasteoutput))
  View.Group_LeftPanel.Group_PetFood.Txt_PetFood:SetText(string.format(GetText(80601029), DataModel.nowFoodNum, DataModel.foodCapacity))
  View.Group_LeftPanel.Group_PetFood.Img_ResideFood:SetFilledImgAmount(DataModel.nowFoodNum / DataModel.foodCapacity)
  local content = string.format("(-%s)", GetText(80601033))
  View.Group_LeftPanel.Group_PetFood.Txt_PetConsume:SetText(string.format(content, DataModel.eatNum))
  if DataModel.furniture.house.food_id ~= "" then
    local icon = PlayerData:GetFactoryData(DataModel.furniture.house.food_id).iconPath
    View.Group_LeftPanel.Group_PetFood.Img_NowFood.Img_Item:SetSprite(icon)
    View.Group_LeftPanel.Group_PetFood.Img_NowFood.Img_Item:SetActive(true)
  else
    View.Group_LeftPanel.Group_PetFood.Img_NowFood.Img_Item:SetActive(false)
  end
end
local AddFood = function(foodData)
  local foodnum = PlayerData:GetGoodsById(foodData.id).num
  local addNum = foodnum - foodData.num
  local param = foodData.id .. ":" .. addNum
  Net:SendProto("pet.food", function(json)
    DataModel.furniture.house.food_id = foodData.id
    DataModel.furniture.house.food_num = DataModel.nowFoodNum
    PlayerData:GetGoodsById(foodData.id).num = foodData.num
    local icon = PlayerData:GetFactoryData(foodData.id).iconPath
    View.Screen_AddFood.Group_Window.Img_NowFood.Img_Item:SetSprite(icon)
  end, param, DataModel.ufid)
end
local RefreshAddFoodInfo = function(txt, num, unitCount)
  txt:SetText(num)
  DataModel.UpdateFoodNum(DataModel.nowFoodNum + unitCount)
  View.Screen_AddFood.Group_Window.Img_ResideFood:SetFilledImgAmount(DataModel.nowFoodNum / DataModel.foodCapacity)
  View.Screen_AddFood.Group_Window.Txt_PetFood:SetText(string.format(GetText(80601029), DataModel.nowFoodNum, DataModel.foodCapacity))
end
local InitPetHouse = function(ufid)
  DataModel.ufid = ufid
  local furniture = PlayerData.ServerData.user_home_info.furniture[ufid]
  DataModel.Init(furniture)
  View.Group_CheckPets_List.StaticGrid_Rooms.grid.self:RefreshAllElement()
  RefreshFoodInfo()
  View.Group_CheckPets_List.Group_HouseName.Img_HouseName.Txt_HouseName:SetText(DataModel.houseName)
end
local ViewFunction = {
  PetHouse_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
    local mainUIView = require("UIMainUI/UIMainUIView")
    mainUIView.self:SetRaycastBlock(false)
    HomeManager:CamFocusEnd(function()
      mainUIView.self:SetRaycastBlock(true)
    end)
  end,
  PetHouse_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
    local mainUIView = require("UIMainUI/UIMainUIView")
    mainUIView.self:SetRaycastBlock(false)
    HomeManager:CamFocusEnd(function()
      mainUIView.self:SetRaycastBlock(true)
    end)
  end,
  PetHouse_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80300364}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  PetHouse_Group_ChangeHouse_Btn_Left_Click = function(btn, str)
    DataModel.selectIndex = DataModel.selectIndex - 1 < 1 and DataModel.petHouseCount or DataModel.selectIndex - 1
    local ufid = DataModel.petFurList[DataModel.selectIndex].u_fid
    InitPetHouse(ufid)
  end,
  PetHouse_Group_ChangeHouse_Btn_Right_Click = function(btn, str)
    DataModel.selectIndex = DataModel.selectIndex + 1 > DataModel.petHouseCount and 1 or DataModel.selectIndex + 1
    local ufid = DataModel.petFurList[DataModel.selectIndex].u_fid
    InitPetHouse(ufid)
  end,
  PetHouse_Group_CheckPets_List_Btn_Manage_Click = function(btn, str)
    UIManager:Open("UI/HomePet/PetList", Json.encode({
      selectType = 2,
      ufid = DataModel.ufid
    }))
  end,
  PetHouse_Group_CheckPets_List_StaticGrid_Rooms_SetGrid = function(element, elementIndex)
    if elementIndex <= DataModel.petNum then
      element.Group_Locked:SetActive(false)
      local isPet = DataModel.petList[elementIndex] ~= "" and true or false
      element.Group_Pet:SetActive(isPet)
      element.Group_CheckIn:SetActive(not isPet)
      if isPet then
        do
          local petInfo = PlayerData:GetHomeInfo().pet[DataModel.petList[elementIndex]]
          local petId = petInfo.id
          local feedId = petInfo.role_id
          local petCfg = PlayerData:GetFactoryData(petId)
          local petIcon = petCfg.petIconPath
          if feedId ~= "" and feedId then
            local viewId = PlayerData:GetFactoryData(feedId).viewId
            local feedIcon = PlayerData:GetFactoryData(viewId).face
            element.Group_Pet.Group_Feeder.Btn_feeder.Img_icon:SetActive(true)
            element.Group_Pet.Group_Feeder.Btn_feeder.Img_icon:SetSprite(feedIcon)
          else
            element.Group_Pet.Group_Feeder.Btn_feeder.Img_icon:SetActive(false)
          end
          element.Group_Pet.Img_Pet:SetSprite(petIcon)
          local name = petInfo.name ~= "" and petInfo.name or petCfg.petName
          element.Group_Pet.Group_Name.Txt_Name:SetText(name)
          element.Group_Pet.Group_Love.Txt_LoveLevel:SetText("LV " .. petInfo.lv)
          local nowLvFavor = petInfo.favor
          DataModel.lvFavorMax = DataModel.GetNextLevelFavor(petInfo.lv)
          element.Group_Pet.Group_Love.Txt_Love:SetText(string.format("%d/%d", nowLvFavor, DataModel.lvFavorMax))
          element.Group_Pet.Group_Love.Img_LoveBar:SetFilledImgAmount(nowLvFavor / DataModel.lvFavorMax)
          element.Group_Pet.Btn_:SetClickParam(elementIndex)
          element.Group_Pet.Group_Feeder.Btn_feeder:SetClickParam(DataModel.petList[elementIndex])
          element.Group_Pet.Group_State:SetActive(false)
          if petInfo.status_level < 700 then
            element.Group_Pet.Group_State.Group_Bad:SetActive(true)
            element.Group_Pet.Group_State.Group_Good:SetActive(false)
          else
            element.Group_Pet.Group_State.Group_Bad:SetActive(false)
            element.Group_Pet.Group_State.Group_Good:SetActive(false)
            if petInfo.interact_num < DataModel.interactMax then
              element.Group_Pet.Group_State.Group_Good:SetActive(true)
              element.Group_Pet.Group_State.Group_Good.Btn_:SetClickParam(DataModel.petList[elementIndex])
            else
            end
          end
        end
      end
    else
      element.Group_Locked:SetActive(true)
      element.Group_CheckIn:SetActive(false)
      element.Group_Pet:SetActive(false)
    end
  end,
  PetHouse_Group_CheckPets_List_StaticGrid_Rooms_Group_Room_Group_CheckIn_Btn_CheckIn_Click = function(btn, str)
    UIManager:Open("UI/HomePet/PetList", Json.encode({
      selectType = 2,
      ufid = DataModel.ufid
    }))
  end,
  PetHouse_Group_CheckPets_List_StaticGrid_Rooms_Group_Room_Group_Pet_Btn__Click = function(btn, str)
    local index = tonumber(str)
    local data = {}
    local count = 0
    local nowIndex = 1
    for i = 1, DataModel.petNum do
      local value = PlayerData:GetHomeInfo().pet[DataModel.petList[i]]
      if value then
        table.insert(data, DataModel.petList[i])
        value.pet_uid = DataModel.petList[i]
        count = count + 1
        if index == i then
          nowIndex = count
        end
      end
    end
    UIManager:Open("UI/HomePet/PetInfo", Json.encode({petList = data, selectIndex = nowIndex}))
  end,
  PetHouse_Group_LeftPanel_Group_PetFood_Btn_AddFood_Click = function(btn, str)
    View.Screen_AddFood:SetActive(true)
    local data = {}
    for i, v in ipairs(DataModel.foodList) do
      if v.num > 0 then
        table.insert(data, v)
      end
    end
    DataModel.foodList = data
    View.Screen_AddFood.Group_Window.ScrollGrid_FoodList.grid.self:SetDataCount(#DataModel.foodList)
    View.Screen_AddFood.Group_Window.ScrollGrid_FoodList.grid.self:RefreshAllElement()
    View.Screen_AddFood.Group_Window.Txt_PetFood:SetText(string.format(GetText(80601029), DataModel.nowFoodNum, DataModel.foodCapacity))
    View.Screen_AddFood.Group_Window.Img_ResideFood:SetFilledImgAmount(DataModel.nowFoodNum / DataModel.foodCapacity)
    if DataModel.furniture.house.food_id ~= "" then
      local icon = PlayerData:GetFactoryData(DataModel.furniture.house.food_id).iconPath
      View.Screen_AddFood.Group_Window.Img_NowFood.Img_Item:SetSprite(icon)
      View.Screen_AddFood.Group_Window.Img_NowFood.Img_Item:SetActive(true)
    else
      View.Screen_AddFood.Group_Window.Img_NowFood.Img_Item:SetActive(false)
    end
  end,
  PetHouse_Group_CheckPets_List_Group_HouseName_Btn_Rename_Click = function(btn, str)
    View.Group_ChangeName:SetActive(true)
  end,
  PetHouse_Group_CheckPets_List_StaticGrid_Rooms_Group_Room_Group_Pet_Group_Feeder_Btn_feeder_Click = function(btn, str)
    UIManager:Open("UI/HomePet/PetFeederList", Json.encode({u_pet = str}))
  end,
  RefreshFoodInfo = RefreshFoodInfo,
  PetHouse_Screen_AddFood_Btn_BG_Click = function(btn, str)
    View.Screen_AddFood:SetActive(false)
    RefreshFoodInfo()
  end,
  PetHouse_Screen_AddFood_Group_Window_ScrollGrid_FoodList_SetGrid = function(element, elementIndex)
    CommonItem:SetItem(element.Group_Item, DataModel.foodList[elementIndex], EnumDefine.ItemType.Item)
    element.Group_Item.Btn_Item:SetClickParam(DataModel.foodList[elementIndex].id)
    element.Btn_AddItem:SetClickParam(elementIndex)
  end,
  PetHouse_Screen_AddFood_Group_Window_ScrollGrid_FoodList_Group_FodItem_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreItemTips({itemId = itemId})
  end,
  PetHouse_Screen_AddFood_Group_Window_ScrollGrid_FoodList_Group_FodItem_Btn_AddItem_Click = function(btn, str)
    local data = DataModel.foodList[tonumber(str)]
    local unitCount = PlayerData:GetFactoryData(data.id).petFoodNum
    if data.num > 0 then
      local quality1 = PlayerData:GetFactoryData(data.id).qualityInt
      local quality2 = quality1
      if DataModel.furniture.house.food_id ~= "" and 0 < DataModel.furniture.house.food_num then
        quality2 = PlayerData:GetFactoryData(DataModel.furniture.house.food_id).qualityInt
      end
      if quality1 == quality2 then
        if DataModel.CalFoodOverflow(unitCount, unitCount) then
          CommonTips.OpenTips(80601027)
        else
          data.num = data.num - 1
          local txtNum = btn.transform.parent:Find("Group_Item/Txt_Num"):GetComponent(typeof(CS.Seven.UITxt))
          RefreshAddFoodInfo(txtNum, data.num, unitCount)
          AddFood(data)
        end
      else
        CommonTips.OnPrompt(80601034, nil, nil, function()
          data.num = data.num - 1
          local txtNum = btn.transform.parent:Find("Group_Item/Txt_Num"):GetComponent(typeof(CS.Seven.UITxt))
          DataModel.UpdateFoodNum(0)
          RefreshAddFoodInfo(txtNum, data.num, unitCount)
          AddFood(data)
        end)
      end
    else
      CommonTips.OpenTips(80601026)
    end
  end,
  PetHouse_Screen_AddFood_Group_Window_ScrollGrid_FoodList_Group_FodItem_Btn_AddItem_LongPress = function(btn, str)
    local data = DataModel.foodList[tonumber(str)]
    local count = 0
    local itemNum = data.num
    local unitCount = PlayerData:GetFactoryData(data.id).petFoodNum
    local txtNum = btn.transform.parent:Find("Group_Item/Txt_Num"):GetComponent(typeof(CS.Seven.UITxt))
    local quality1 = PlayerData:GetFactoryData(data.id).qualityInt
    local quality2 = quality1
    if DataModel.furniture.house.food_id ~= "" and 0 < DataModel.furniture.house.food_num then
      quality2 = PlayerData:GetFactoryData(DataModel.furniture.house.food_id).qualityInt
    end
    if quality1 == quality2 then
      View.self:StartC(LuaUtil.cs_generator(function()
        while btn.Btn.isHandled do
          coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
          if DataModel.CalFoodOverflow(unitCount * 1, unitCount) then
            CommonTips.OpenTips(80601027)
            break
          end
          if count < itemNum then
            count = count + 1
            RefreshAddFoodInfo(txtNum, data.num - count, unitCount)
          else
            CommonTips.OpenTips(80601026)
            break
          end
        end
        if 0 < count then
          data.num = data.num - count
          AddFood(data)
        end
      end))
    else
      CommonTips.OnPrompt(80601034, nil, nil, function()
        data.num = data.num - 1
        local txtNum = btn.transform.parent:Find("Group_Item/Txt_Num"):GetComponent(typeof(CS.Seven.UITxt))
        DataModel.UpdateFoodNum(0)
        RefreshAddFoodInfo(txtNum, data.num, unitCount)
        AddFood(data)
      end)
    end
  end,
  PetHouse_Group_ChangeName_Btn_Close_Click = function(btn, str)
  end,
  PetHouse_Group_ChangeName_Btn_Confirm_Click = function(btn, str)
    local name = View.Group_ChangeName.InputField_ChangeName:GetText()
    Net:SendProto("furniture.rename", function()
      DataModel.houseName = name
      DataModel.furniture.name = name
      View.Group_CheckPets_List.Group_HouseName.Img_HouseName.Txt_HouseName:SetText(name)
      View.Group_ChangeName:SetActive(false)
    end, DataModel.ufid, name)
  end,
  PetHouse_Group_ChangeName_Btn_Cancel_Click = function(btn, str)
    View.Group_ChangeName:SetActive(false)
  end,
  PetHouse_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  PetHouse_Group_CheckPets_List_StaticGrid_Rooms_Group_Room_Group_Pet_Group_State_Group_Good_Btn__Click = function(btn, str)
    local pet_uid = str
    local data = PlayerData:GetHomeInfo().pet[pet_uid]
    print_r(data)
    Net:SendProto("pet.interact", function()
      PlayerData:GetHomeInfo().pet[pet_uid].interact_num = PlayerData:GetHomeInfo().pet[pet_uid].interact_num + 1
      if PlayerData:GetHomeInfo().pet[pet_uid].interact_num >= DataModel.interactMax then
        btn.transform.parent.gameObject:SetActive(false)
      end
    end, pet_uid, data.u_fid)
  end
}
return ViewFunction
