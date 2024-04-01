local View = require("UIPetList/UIPetListView")
local DataModel = require("UIPetList/UIPetListDataModel")
local selectItem
local PetInfoData = require("UIPetInfo/UIPetInfoDataModel")
local UpdatePetInfo = function()
  if next(DataModel.sortData) == nil then
    View.Group_NowSelect:SetActive(false)
    return
  else
    View.Group_NowSelect:SetActive(true)
  end
  local pet_uid = DataModel.sortData[DataModel.selectIndex].pet_uid
  local data = PlayerData:GetHomeInfo().pet[pet_uid]
  local petCfg = PlayerData:GetFactoryData(data.id)
  local favor = data.favor
  local nature = data.personality and PlayerData:GetFactoryData(data.personality).petPersonalityName or ""
  View.Group_NowSelect.Group_CommonInfo.Group_PetLove.Txt_Num:SetText(favor)
  View.Group_NowSelect.Group_CommonInfo.Group_PetFoodInt.Txt_Num:SetText(string.format(GetText(80600997), petCfg.petFoodInt))
  View.Group_NowSelect.Group_CommonInfo.Group_PetGarbage.Txt_Num:SetText(string.format(GetText(80601006), petCfg.wasteoutput))
  View.Group_NowSelect.Group_CommonInfo.Group_Personality.Txt_:SetText(nature)
  View.Group_NowSelect.Group_CommonInfo.Group_PerState.Txt_:SetText(DataModel.GetPetState(data.status_level))
  local feedId = data.role_id
  if feedId ~= "" and feedId then
    local viewId = PlayerData:GetFactoryData(feedId).viewId
    local feedIcon = PlayerData:GetFactoryData(viewId).face
    View.Group_NowSelect.Group_CommonInfo.Group_Feeder.Group_NowFeeder.Img_:SetSprite(feedIcon)
    View.Group_NowSelect.Group_CommonInfo.Group_Feeder:SetActive(true)
    View.Group_NowSelect.Group_CommonInfo.Group_Feeder.Txt_:SetText(PlayerData:GetFactoryData(feedId).name)
  else
    View.Group_NowSelect.Group_CommonInfo.Group_Feeder:SetActive(false)
    View.Group_NowSelect.Group_CommonInfo.Group_Feeder.Txt_:SetText()
  end
  View.Group_NowSelect.Group_CommonInfo.Group_Score.Txt_Num:SetText(ClearFollowZero(PetInfoData.CalPetScores(data)))
end
local RefreshPetList = function()
  View.ScrollGrid_Pet_List.grid.self:SetDataCount(#DataModel.sortData)
  View.ScrollGrid_Pet_List.grid.self:RefreshAllElement()
  UpdatePetInfo()
end
local ViewFunction = {
  PetList_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  PetList_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
    if HomeManager.cam.isLock then
      local mainUIView = require("UIMainUI/UIMainUIView")
      mainUIView.self:SetRaycastBlock(false)
      HomeManager:CamFocusEnd(function()
        mainUIView.self:SetRaycastBlock(true)
      end)
    end
  end,
  PetList_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  PetList_Group_TopRight_Btn_Love_Click = function(btn, str)
    if View.Group_TopRight.Btn_Love.Img_Select.IsActive then
      DataModel.favorUp = not DataModel.favorUp
      local angel = DataModel.favorUp and 0 or 180
      View.Group_TopRight.Btn_Love.Img_Select.Img_:SetLocalEulerAngles(angel)
      View.Group_TopRight.Btn_Love.Img_Normal.Img_:SetLocalEulerAngles(angel)
    else
      DataModel.Img_Select:SetActive(false)
      View.Group_TopRight.Btn_Love.Img_Select:SetActive(true)
      DataModel.Img_Select = View.Group_TopRight.Btn_Love.Img_Select
    end
    DataModel.SortData(DataModel.favorFirst)
    RefreshPetList()
  end,
  PetList_Group_TopRight_Btn_Time_Click = function(btn, str)
    if View.Group_TopRight.Btn_Time.Img_Select.IsActive then
      DataModel.timeUp = not DataModel.timeUp
      local angel = DataModel.timeUp and 0 or 180
      View.Group_TopRight.Btn_Time.Img_Select.Img_:SetLocalEulerAngles(angel)
      View.Group_TopRight.Btn_Time.Img_Normal.Img_:SetLocalEulerAngles(angel)
    else
      DataModel.Img_Select:SetActive(false)
      View.Group_TopRight.Btn_Time.Img_Select:SetActive(true)
      DataModel.Img_Select = View.Group_TopRight.Btn_Time.Img_Select
    end
    DataModel.SortData(DataModel.timeFirst)
    RefreshPetList()
  end,
  PetList_Group_TopRight_Btn_Screen_Click = function(btn, str)
    View.Screen_Filter:SetActive(true)
    View.Screen_Filter.ScrollGrid_PetVarity.grid.self:SetDataCount(DataModel.petKindsCount)
    View.Screen_Filter.ScrollGrid_PetVarity.grid.self:RefreshAllElement()
    DataModel.now_kinds = Clone(DataModel.selectKindList)
  end,
  PetList_ScrollGrid_Pet_List_SetGrid = function(element, elementIndex)
    local data = DataModel.sortData[elementIndex]
    local petCfg = PlayerData:GetFactoryData(data.id)
    local name = data.name ~= "" and data.name or petCfg.petName
    element.Group_Name.Txt_Name:SetText(name)
    element.Group_Love.Txt_Love:SetText(data.lv)
    local icon = petCfg.petIconPath
    element.Img_Pet:SetSprite(icon)
    element.Group_OtherHouse:SetActive(false)
    element.Group_Selected:SetActive(true)
    if DataModel.furPets[data.pet_uid] then
      element.Group_Selected.Group_Num.Txt_:SetText(DataModel.furPets[data.pet_uid])
      element.Group_Selected.Group_Num:SetActive(true)
    else
      element.Group_Selected.Group_Num:SetActive(false)
      if data.u_fid ~= "" and data.u_fid ~= DataModel.ufid then
        element.Group_OtherHouse:SetActive(true)
      end
    end
    element.Btn_PetUnit:SetClickParam(elementIndex)
    if elementIndex == DataModel.selectIndex then
      element.Group_Selected.Group_Fx_NowSelect:SetActive(true)
      selectItem = element.Group_Selected.Group_Fx_NowSelect
    else
      element.Group_Selected.Group_Fx_NowSelect:SetActive(false)
    end
  end,
  PetList_ScrollGrid_Pet_List_Group_PetUnit_Btn_PetUnit_Click = function(btn, str)
    local index = tonumber(str)
    if index ~= DataModel.selectIndex then
      selectItem:SetActive(false)
      selectItem = btn.transform.parent:Find("Group_Selected/Group_Fx_NowSelect").gameObject
      DataModel.selectIndex = index
      selectItem:SetActive(true)
      UpdatePetInfo()
    end
    local group_Num = selectItem.transform.parent:Find("Group_Num").gameObject
    local pet_uid = DataModel.petList[index].pet_uid
    local furIndex = DataModel.furPets[pet_uid]
    if DataModel.furPets[furIndex] then
      DataModel.furPets[furIndex] = ""
      DataModel.furPets[pet_uid] = nil
      DataModel.furPets.count = DataModel.furPets.count - 1
      group_Num:SetActive(false)
    else
      DataModel.furPets.count = DataModel.furPets.count + 1
      if DataModel.maxPetNum < DataModel.furPets.count then
        CommonTips.OpenTips(GetText(80601047))
        DataModel.furPets.count = DataModel.furPets.count - 1
      else
        for i = 1, DataModel.maxPetNum do
          if DataModel.furPets[i] == "" then
            DataModel.furPets[pet_uid] = i
            DataModel.furPets[i] = pet_uid
            break
          end
        end
        group_Num:SetActive(true)
        group_Num.transform:Find("Txt_"):GetComponent(typeof(CS.Seven.UITxt)):SetText(DataModel.furPets[pet_uid])
      end
    end
  end,
  PetList_Group_NowSelect_Btn_PetInfo_Click = function(btn, str)
    local petList = {}
    for i, v in ipairs(DataModel.sortData) do
      table.insert(petList, v.pet_uid)
    end
    UIManager:Open("UI/HomePet/PetInfo", Json.encode({
      petList = petList,
      selectIndex = DataModel.selectIndex
    }))
  end,
  PetList_Group_NowSelect_Btn_Decide_Click = function(btn, str)
    local changeData = {
      DataModel.furPets[1]
    }
    local pet_uid = tostring(DataModel.furPets[1])
    local isChange = DataModel.furPets[1] ~= PlayerData.ServerData.user_home_info.furniture[DataModel.ufid].house.pets[1]
    for i = 2, DataModel.maxPetNum do
      changeData[i] = DataModel.furPets[i]
      pet_uid = pet_uid .. "," .. DataModel.furPets[i]
      isChange = isChange or DataModel.furPets[i] ~= PlayerData.ServerData.user_home_info.furniture[DataModel.ufid].house.pets[i]
    end
    local addordel_list = {}
    for i, v in ipairs(PlayerData.ServerData.user_home_info.furniture[DataModel.ufid].house.pets) do
      if v ~= "" then
        addordel_list[PlayerData.ServerData.user_home_info.furniture[DataModel.ufid].house.pets[i]] = false
      end
    end
    for i = 1, DataModel.maxPetNum do
      if PlayerData:GetHomeInfo().pet[DataModel.furPets[i]] then
        addordel_list[DataModel.furPets[i]] = true
      end
    end
    if isChange then
      Net:SendProto("pet.check_in", function()
        for k, v in pairs(addordel_list) do
          local data = PlayerData:GetHomeInfo().pet[k]
          local id = PlayerData:GetFactoryData(data.id).homeCharacter
          if v == false then
            HomeCharacterManager:RecyclePet(tostring(k))
          else
            local roomId = DataModel.GetRoomId(DataModel.ufid)
            if roomId then
              HomeCharacterManager:CreatePet(tostring(k), id, roomId, true)
            end
          end
        end
        local pets = PlayerData.ServerData.user_home_info.furniture[DataModel.ufid].house.pets
        for i = 1, DataModel.maxPetNum do
          if PlayerData:GetHomeInfo().pet[pets[i]] then
            PlayerData:GetHomeInfo().pet[pets[i]].u_fid = ""
          end
        end
        PlayerData.ServerData.user_home_info.furniture[DataModel.ufid].house.pets = changeData
        for k, v in pairs(changeData) do
          if PlayerData:GetHomeInfo().pet[v] then
            if DataModel.ufid ~= PlayerData:GetHomeInfo().pet[v].u_fid and PlayerData:GetHomeInfo().pet[v].u_fid ~= "" then
              local furture = PlayerData.ServerData.user_home_info.furniture[PlayerData:GetHomeInfo().pet[v].u_fid]
              local pets = furture.house.pets
              local count = PlayerData:GetFactoryData(furture.id).PetNum
              for i = 1, count do
                if pets[i] == v then
                  pets[i] = ""
                end
              end
            end
            PlayerData:GetHomeInfo().pet[v].u_fid = DataModel.ufid
          end
        end
        UIManager:GoBack()
      end, pet_uid, DataModel.ufid)
    else
      UIManager:GoBack()
    end
  end,
  PetList_Screen_Filter_Btn_BG_Click = function(btn, str)
    View.Screen_Filter:SetActive(false)
    DataModel.selectKindList = DataModel.now_kinds
  end,
  PetList_Screen_Filter_ScrollGrid_PetVarity_SetGrid = function(element, elementIndex)
    local id = DataModel.petKindsList[elementIndex].id
    local data = PlayerData:GetFactoryData(id)
    element.Btn_Varity.Img_Select:SetActive(DataModel.selectKindList[id])
    element.Btn_Varity.Txt_:SetText(data.petVarity)
    element.Btn_Varity:SetClickParam(id)
  end,
  PetList_Screen_Filter_Btn_OK_Click = function(btn, str)
    View.Screen_Filter:SetActive(false)
    DataModel.SelectSortData()
    local conditionList = DataModel.favorUp and DataModel.favorFirst or DataModel.timeFirst
    DataModel.SortData(conditionList)
    View.ScrollGrid_Pet_List.grid.self:SetDataCount(#DataModel.sortData)
    View.ScrollGrid_Pet_List.grid.self:RefreshAllElement()
    UpdatePetInfo()
    local count = DataModel.selectKindList.count
    if count == 0 or count == DataModel.petKindsCount then
      View.Group_TopRight.Btn_Screen.Img_Select:SetActive(false)
    else
      View.Group_TopRight.Btn_Screen.Img_Select:SetActive(true)
    end
  end,
  PetList_Screen_Filter_Btn_Cancel_Click = function(btn, str)
    View.Screen_Filter:SetActive(false)
    DataModel.selectKindList = DataModel.now_kinds
  end,
  PetList_Screen_Filter_ScrollGrid_PetVarity_Group_Varity_Btn_Varity_Click = function(btn, str)
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
  UpdatePetInfo = UpdatePetInfo,
  PetList_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end
}
return ViewFunction
