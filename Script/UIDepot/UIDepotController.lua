local View = require("UIDepot/UIDepotView")
local DataModel = require("UIDepot/UIDepotDataModel")
local Controller = {}

function Controller:RefreshEquipmentNum()
  local space_info = PlayerData.ServerData.user_info.space_info
  UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Equipment")
  local Group_Volume = View.Group_Equipment.Group_EquipmentBagVolume.Group_Volume
  Group_Volume.Txt_Now:SetText(space_info.now_equip_num)
  Group_Volume.Txt_Max:SetText(space_info.max_equip_num)
end

function Controller:SortRefresh()
  local Group_TopRight = View.Group_TopRight
  if PlayerData.DepotSort == EnumDefine.Sort.Quality then
    if DataModel.QualitySort == EnumDefine.QualitySort.QualityDesc then
      Group_TopRight.Btn_Rarity.Img_DeP:SetActive(true)
      Group_TopRight.Btn_Rarity.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Rarity.Img_AP:SetActive(false)
      Group_TopRight.Btn_Rarity.Img_AN:SetActive(false)
    elseif DataModel.QualitySort == EnumDefine.QualitySort.QualityAsc then
      Group_TopRight.Btn_Rarity.Img_DeP:SetActive(false)
      Group_TopRight.Btn_Rarity.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Rarity.Img_AP:SetActive(true)
      Group_TopRight.Btn_Rarity.Img_AN:SetActive(false)
    end
  elseif PlayerData.DepotSort == EnumDefine.Sort.Time then
    if DataModel.TimeSort == EnumDefine.TimeSort.TimeDesc then
      Group_TopRight.Btn_Time.Img_DeP:SetActive(true)
      Group_TopRight.Btn_Time.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Time.Img_AP:SetActive(false)
      Group_TopRight.Btn_Time.Img_AN:SetActive(false)
    elseif DataModel.TimeSort == EnumDefine.TimeSort.TimeAsc then
      Group_TopRight.Btn_Time.Img_DeP:SetActive(false)
      Group_TopRight.Btn_Time.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Time.Img_AP:SetActive(true)
      Group_TopRight.Btn_Time.Img_AN:SetActive(false)
    end
  elseif PlayerData.DepotSort == EnumDefine.Sort.Level then
    if DataModel.LevelSort == EnumDefine.LevelSort.LevelDesc then
      Group_TopRight.Btn_Level.Img_DeP:SetActive(true)
      Group_TopRight.Btn_Level.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Level.Img_AP:SetActive(false)
      Group_TopRight.Btn_Level.Img_AN:SetActive(false)
    elseif DataModel.LevelSort == EnumDefine.LevelSort.LevelAsc then
      Group_TopRight.Btn_Level.Img_DeP:SetActive(false)
      Group_TopRight.Btn_Level.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Level.Img_AP:SetActive(true)
      Group_TopRight.Btn_Level.Img_AN:SetActive(false)
    end
  end
end

function Controller:FilterRefresh(currSort)
  local Group_TopRight = View.Group_TopRight
  if DataModel.Sort ~= currSort then
    if DataModel.Sort == EnumDefine.Sort.Quality then
      if DataModel.QualitySort == EnumDefine.QualitySort.QualityDesc then
        Group_TopRight.Btn_Rarity.Img_DeP:SetActive(false)
        Group_TopRight.Btn_Rarity.Img_DeN:SetActive(true)
        Group_TopRight.Btn_Rarity.Img_AP:SetActive(false)
        Group_TopRight.Btn_Rarity.Img_AN:SetActive(false)
        PlayerData.DepotSortState = DataModel.QualitySort
      elseif DataModel.QualitySort == EnumDefine.QualitySort.QualityAsc then
        Group_TopRight.Btn_Rarity.Img_DeP:SetActive(false)
        Group_TopRight.Btn_Rarity.Img_DeN:SetActive(false)
        Group_TopRight.Btn_Rarity.Img_AP:SetActive(false)
        Group_TopRight.Btn_Rarity.Img_AN:SetActive(true)
        PlayerData.DepotSortState = DataModel.QualitySort
      end
    elseif DataModel.Sort == EnumDefine.Sort.Time then
      if DataModel.TimeSort == EnumDefine.TimeSort.TimeDesc then
        Group_TopRight.Btn_Time.Img_DeP:SetActive(false)
        Group_TopRight.Btn_Time.Img_DeN:SetActive(true)
        Group_TopRight.Btn_Time.Img_AP:SetActive(false)
        Group_TopRight.Btn_Time.Img_AN:SetActive(false)
        PlayerData.DepotSortState = DataModel.TimeSort
      elseif DataModel.TimeSort == EnumDefine.TimeSort.TimeAsc then
        Group_TopRight.Btn_Time.Img_DeP:SetActive(false)
        Group_TopRight.Btn_Time.Img_DeN:SetActive(false)
        Group_TopRight.Btn_Time.Img_AP:SetActive(false)
        Group_TopRight.Btn_Time.Img_AN:SetActive(true)
        PlayerData.DepotSortState = DataModel.TimeSort
      end
    elseif DataModel.Sort == EnumDefine.Sort.Level then
      if DataModel.LevelSort == EnumDefine.LevelSort.LevelDesc then
        Group_TopRight.Btn_Level.Img_DeP:SetActive(false)
        Group_TopRight.Btn_Level.Img_DeN:SetActive(true)
        Group_TopRight.Btn_Level.Img_AP:SetActive(false)
        Group_TopRight.Btn_Level.Img_AN:SetActive(false)
        PlayerData.DepotSortState = DataModel.LevelSort
      elseif DataModel.LevelSort == EnumDefine.LevelSort.LevelAsc then
        Group_TopRight.Btn_Level.Img_DeP:SetActive(false)
        Group_TopRight.Btn_Level.Img_DeN:SetActive(false)
        Group_TopRight.Btn_Level.Img_AP:SetActive(false)
        Group_TopRight.Btn_Level.Img_AN:SetActive(true)
        PlayerData.DepotSortState = DataModel.LevelSort
      end
    end
    if currSort == EnumDefine.Sort.Quality then
      if DataModel.QualitySort == EnumDefine.QualitySort.QualityDesc then
        Group_TopRight.Btn_Rarity.Img_DeP:SetActive(true)
        Group_TopRight.Btn_Rarity.Img_DeN:SetActive(false)
        Group_TopRight.Btn_Rarity.Img_AP:SetActive(false)
        Group_TopRight.Btn_Rarity.Img_AN:SetActive(false)
        PlayerData.DepotSortState = DataModel.QualitySort
      elseif DataModel.QualitySort == EnumDefine.QualitySort.QualityAsc then
        Group_TopRight.Btn_Rarity.Img_DeP:SetActive(false)
        Group_TopRight.Btn_Rarity.Img_DeN:SetActive(false)
        Group_TopRight.Btn_Rarity.Img_AP:SetActive(true)
        Group_TopRight.Btn_Rarity.Img_AN:SetActive(false)
        PlayerData.DepotSortState = DataModel.QualitySort
      end
    elseif currSort == EnumDefine.Sort.Time then
      if DataModel.TimeSort == EnumDefine.TimeSort.TimeDesc then
        Group_TopRight.Btn_Time.Img_DeP:SetActive(true)
        Group_TopRight.Btn_Time.Img_DeN:SetActive(false)
        Group_TopRight.Btn_Time.Img_AP:SetActive(false)
        Group_TopRight.Btn_Time.Img_AN:SetActive(false)
        PlayerData.DepotSortState = DataModel.TimeSort
      elseif DataModel.TimeSort == EnumDefine.TimeSort.TimeAsc then
        Group_TopRight.Btn_Time.Img_DeP:SetActive(false)
        Group_TopRight.Btn_Time.Img_DeN:SetActive(false)
        Group_TopRight.Btn_Time.Img_AP:SetActive(true)
        Group_TopRight.Btn_Time.Img_AN:SetActive(false)
        PlayerData.DepotSortState = DataModel.TimeSort
      end
    elseif currSort == EnumDefine.Sort.Level then
      if DataModel.LevelSort == EnumDefine.LevelSort.LevelDesc then
        Group_TopRight.Btn_Level.Img_DeP:SetActive(true)
        Group_TopRight.Btn_Level.Img_DeN:SetActive(false)
        Group_TopRight.Btn_Level.Img_AP:SetActive(false)
        Group_TopRight.Btn_Level.Img_AN:SetActive(false)
        PlayerData.DepotSortState = DataModel.LevelSort
      elseif DataModel.LevelSort == EnumDefine.LevelSort.LevelAsc then
        Group_TopRight.Btn_Level.Img_DeP:SetActive(false)
        Group_TopRight.Btn_Level.Img_DeN:SetActive(false)
        Group_TopRight.Btn_Level.Img_AP:SetActive(true)
        Group_TopRight.Btn_Level.Img_AN:SetActive(false)
        PlayerData.DepotSortState = DataModel.LevelSort
      end
    end
  elseif currSort == EnumDefine.Sort.Quality then
    if DataModel.QualitySort == EnumDefine.QualitySort.QualityDesc then
      DataModel.QualitySort = EnumDefine.QualitySort.QualityAsc
    elseif DataModel.QualitySort == EnumDefine.QualitySort.QualityAsc then
      DataModel.QualitySort = EnumDefine.QualitySort.QualityDesc
    end
    PlayerData.DepotSortState = DataModel.QualitySort
    if DataModel.QualitySort == EnumDefine.QualitySort.QualityDesc then
      Group_TopRight.Btn_Rarity.Img_DeP:SetActive(true)
      Group_TopRight.Btn_Rarity.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Rarity.Img_AP:SetActive(false)
      Group_TopRight.Btn_Rarity.Img_AN:SetActive(false)
    elseif DataModel.QualitySort == EnumDefine.QualitySort.QualityAsc then
      Group_TopRight.Btn_Rarity.Img_DeP:SetActive(false)
      Group_TopRight.Btn_Rarity.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Rarity.Img_AP:SetActive(true)
      Group_TopRight.Btn_Rarity.Img_AN:SetActive(false)
    end
  elseif currSort == EnumDefine.Sort.Time then
    if DataModel.TimeSort == EnumDefine.TimeSort.TimeDesc then
      DataModel.TimeSort = EnumDefine.TimeSort.TimeAsc
    elseif DataModel.TimeSort == EnumDefine.TimeSort.TimeAsc then
      DataModel.TimeSort = EnumDefine.TimeSort.TimeDesc
    end
    PlayerData.DepotSortState = DataModel.TimeSort
    if DataModel.TimeSort == EnumDefine.TimeSort.TimeDesc then
      Group_TopRight.Btn_Time.Img_DeP:SetActive(true)
      Group_TopRight.Btn_Time.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Time.Img_AP:SetActive(false)
      Group_TopRight.Btn_Time.Img_AN:SetActive(false)
    elseif DataModel.TimeSort == EnumDefine.TimeSort.TimeAsc then
      Group_TopRight.Btn_Time.Img_DeP:SetActive(false)
      Group_TopRight.Btn_Time.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Time.Img_AP:SetActive(true)
      Group_TopRight.Btn_Time.Img_AN:SetActive(false)
    end
  elseif currSort == EnumDefine.Sort.Level then
    if DataModel.LevelSort == EnumDefine.LevelSort.LevelDesc then
      DataModel.LevelSort = EnumDefine.LevelSort.LevelAsc
    elseif DataModel.LevelSort == EnumDefine.LevelSort.LevelAsc then
      DataModel.LevelSort = EnumDefine.LevelSort.LevelDesc
    end
    PlayerData.DepotSortState = DataModel.LevelSort
    if DataModel.LevelSort == EnumDefine.LevelSort.LevelDesc then
      Group_TopRight.Btn_Level.Img_DeP:SetActive(true)
      Group_TopRight.Btn_Level.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Level.Img_AP:SetActive(false)
      Group_TopRight.Btn_Level.Img_AN:SetActive(false)
    elseif DataModel.LevelSort == EnumDefine.LevelSort.LevelAsc then
      Group_TopRight.Btn_Level.Img_DeP:SetActive(false)
      Group_TopRight.Btn_Level.Img_DeN:SetActive(false)
      Group_TopRight.Btn_Level.Img_AP:SetActive(true)
      Group_TopRight.Btn_Level.Img_AN:SetActive(false)
    end
  end
  DataModel.Sort = currSort
  PlayerData.DepotSort = currSort
end

function Controller:ChangeTab(index, refresh)
  if refresh or DataModel.Index ~= index then
    DataModel.Now_List = {}
    local old = Controller.TabEnum[DataModel.Index]
    if old then
      old.view.self:SetActive(false)
      old.btn.Group_On:SetActive(false)
      old.btn.Group_Off:SetActive(true)
    end
    DataModel.Index = index
    if index == EnumDefine.Depot.Equipment then
      UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Equipment")
    end
    if index == EnumDefine.Depot.Equipment then
      UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_TopRight")
    end
    UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Other")
    View.Group_Equipment.self:SetActive(index == EnumDefine.Depot.Equipment)
    View.Group_Other.self:SetActive(index ~= EnumDefine.Depot.Equipment)
    View.Group_TopRight.self:SetActive(index == EnumDefine.Depot.Equipment)
    local new = Controller.TabEnum[DataModel.Index]
    local data = DataModel:GetDataByType(new.enum, DataModel.Sort, refresh)
    DataModel.Now_List = data
    local aniName = ""
    if index == 1 or index == 2 or index == 5 then
      aniName = "Item_In"
    end
    if index == 3 then
      aniName = "Equip_In"
    end
    if index == 4 then
      aniName = "Goods_In"
    end
    if DataModel.isBack then
      new.view.grid.self:SetEnableAnimator(false)
    end
    if index == 1 then
      UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Item")
    end
    if index == 2 then
      UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Material")
    end
    if index == 3 then
      UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Equipments")
    end
    if index == 4 then
      UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Goods")
    end
    if index == 5 then
      UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Food")
    end
    new.view.self:SetActive(true)
    DataModel.goods = 0
    new.view.grid.self:SetDataCount(#data)
    if not DataModel.isBack then
      new.view.grid.self:SelectPlayAnim(aniName, function()
        new.view.grid.self:SetEnableAnimator(false)
      end)
      new.view.grid.self:MoveToTop()
    else
      DataModel.isBack = false
    end
    new.view.grid.self:RefreshAllElement()
    new.btn.Group_On:SetActive(true)
    new.btn.Group_Off:SetActive(false)
    self:RefreshEquipmentNum()
    View.Group_Limit.self:SetActive(false)
    if index == EnumDefine.Depot.Warehouse or index == EnumDefine.Depot.FridgeItem then
      UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Limit")
      View.Group_Limit.Group_Goods:SetActive(index == EnumDefine.Depot.Warehouse)
      View.Group_Limit.Group_Food:SetActive(index == EnumDefine.Depot.FridgeItem)
    end
    if index == EnumDefine.Depot.Warehouse then
      UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Limit")
      View.Group_Limit.self:SetActive(true)
      View.Group_Limit.Group_Goods.Group_Num.Txt_Now:SetText(PlayerData:GetUserInfo().space_info.now_train_goods_num or 0)
      local maxTrainGoodsNum = PlayerData.GetMaxTrainGoodsNum()
      View.Group_Limit.Group_Goods.Group_Num.Txt_Total:SetText(maxTrainGoodsNum)
      View.Group_Limit.Group_Goods.Img_PBNow:SetFilledImgAmount(PlayerData:GetUserInfo().space_info.now_train_goods_num / maxTrainGoodsNum)
    end
    if index == EnumDefine.Depot.FridgeItem then
      UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Limit")
      View.Group_Limit.self:SetActive(true)
      View.Group_Limit.Group_Food.Group_num.Txt_Now:SetText(PlayerData:GetUserInfo().space_info.now_food_material_num or 0)
      View.Group_Limit.Group_Food.Group_num.Txt_Total:SetText(PlayerData:GetUserInfo().space_info.max_food_material_num or 0)
    end
    if index == EnumDefine.Depot.TrainWeapon then
      View.Group_TrainWeapon:SetActive(true)
    end
    if #data == 0 then
      View.Img_DialogBox:SetActive(true)
      View.Img_DialogBox.Txt_Dialog:SetText(GetText(80601323))
      do
        local txtHeight = View.Img_DialogBox.Txt_Dialog:GetHeight()
        View.Img_DialogBox:SetHeight(txtHeight + 80)
        View.Img_DialogBox.Txt_Dialog:SetHeight(txtHeight)
        View.Img_DialogBox.Txt_Dialog:SetTweenContent(GetText(80601323))
        if View.coroutineSound then
          View.self:StopC(View.coroutineSound)
          View.coroutineSound = nil
        end
        View.coroutineSound = View.self:StartC(LuaUtil.cs_generator(function()
          local soundTime = 5
          coroutine.yield(CS.UnityEngine.WaitForSeconds(soundTime))
          View.Img_DialogBox:SetActive(false)
          View.sound = nil
          if View.coroutineSound then
            View.self:StopC(View.coroutineSound)
            View.coroutineSound = nil
          end
        end))
      end
    end
  end
end

function Controller:FilterButtonType()
  UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_TopRight")
  local Img_P = View.Group_TopRight.Btn_Screen.Img_P
  if DataModel.FilterRarity[0] and DataModel.FilterState[0] and DataModel.FilterType[0] then
    Img_P:SetActive(false)
  else
    Img_P:SetActive(true)
  end
end

function Controller:Refresh(refresh)
  self:ChangeTab(EnumDefine.Depot.Equipment, refresh)
  self.OpenSale(false)
end

function Controller.OpenSale(isOpen, Type)
  View.Group_Other.Btn_Sale:SetActive(isOpen)
  View.Group_Equipment.Group_EquipmentBagVolume:SetActive(not isOpen)
  if isOpen then
    DataModel.Select = Type
  end
end

function DataModel:InitRoleTrustData()
  self.soundEndTime = 0
  self.roleAudioList = {}
  self.roleAudioCount = 0
  local roleId = 10000027
  local roleConfig = PlayerData:GetFactoryData(roleId)
  local file_id = roleConfig.fileList[1].file
  local file_cfg = PlayerData:GetFactoryData(file_id)
  local tempList = {}
  local has_gender_sound = file_cfg.AudioM and next(file_cfg.AudioM)
  if has_gender_sound then
    local gender = PlayerData:GetUserInfo().gender or 1
    local gender_list = gender == 1 and file_cfg.AudioM or file_cfg.AudioF
    local normal_list = file_cfg.TrustAudio
    local normal_indx = 1
    local gender_indx = 1
    while normal_list[normal_indx] or gender_list[gender_indx] do
      if gender_list[gender_indx] == nil then
        table.insert(tempList, normal_list[normal_indx])
        normal_indx = normal_indx + 1
      elseif normal_list[normal_indx] == nil then
        table.insert(tempList, gender_list[gender_indx])
        gender_indx = gender_indx + 1
      elseif normal_list[normal_indx].UnlockLevel <= gender_list[gender_indx].UnlockLevel then
        table.insert(tempList, normal_list[normal_indx])
        normal_indx = normal_indx + 1
      else
        table.insert(tempList, gender_list[gender_indx])
        gender_indx = gender_indx + 1
      end
    end
  else
    tempList = file_cfg.TrustAudio
  end
  if roleId then
    local trust_lv = PlayerData:GetRoleById(roleId).trust_lv or 1
    for k, v in pairs(tempList) do
      if trust_lv >= v.UnlockLevel then
        self.roleAudioList[k] = v
        self.roleAudioCount = self.roleAudioCount + 1
      end
    end
  end
end

function Controller:RandomPlayRoleSound()
  DataModel.nextPlaySoundTime = DataModel.nextPlaySoundTime or 0
  local time = os.time()
  if time > DataModel.soundEndTime then
    local count = DataModel.roleAudioCount
    if count == 0 then
      return
    end
    math.randomseed(time)
    local roleAudio = DataModel.roleAudioList[math.random(1, count)]
    local nowId = roleAudio.Audio2
    DataModel.lastRoleSoundId = nowId
    local sound = SoundManager:CreateSound(DataModel.lastRoleSoundId)
    if sound ~= nil or nowId == -1 then
      if nowId ~= -1 then
        sound:Play()
      end
      local soundLength = nowId ~= -1 and sound.audioSource.clip.length or 3
      DataModel.soundEndTime = soundLength + time + 1
      View.sound = sound
      DataModel:GetNextSoundTime()
      View.Img_DialogBox:SetActive(true)
      View.Img_DialogBox.Txt_Dialog:SetText(roleAudio.StoryText)
      local txtHeight = View.Img_DialogBox.Txt_Dialog:GetHeight()
      View.Img_DialogBox:SetHeight(txtHeight + 80)
      View.Img_DialogBox.Txt_Dialog:SetHeight(txtHeight)
      View.Img_DialogBox.Txt_Dialog:SetTweenContent(roleAudio.StoryText)
      if View.coroutineSound then
        View.self:StopC(View.coroutineSound)
        View.coroutineSound = nil
      end
      View.coroutineSound = View.self:StartC(LuaUtil.cs_generator(function()
        local soundTime = soundLength
        coroutine.yield(CS.UnityEngine.WaitForSeconds(soundTime))
        View.Img_DialogBox:SetActive(false)
        View.sound = nil
        if View.coroutineSound then
          View.self:StopC(View.coroutineSound)
          View.coroutineSound = nil
        end
      end))
    end
  end
end

function Controller.Init()
  UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Item")
  UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Material")
  UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Equipments")
  UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Goods")
  UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Food")
  UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_TrainWeapon")
  Controller.TabEnum = {
    {
      view = View.Group_Item.ScrollGrid_Item,
      btn = View.Group_Tab.Btn_TabItem,
      enum = EnumDefine.Depot.Item
    },
    {
      view = View.Group_Material.ScrollGrid_Material,
      btn = View.Group_Tab.Btn_TabMaterial,
      enum = EnumDefine.Depot.Material
    },
    {
      view = View.Group_Equipments.ScrollGrid_Equipment,
      btn = View.Group_Tab.Btn_TabEquipment,
      enum = EnumDefine.Depot.Equipment
    },
    {
      view = View.Group_Goods.ScrollGrid_Goods,
      btn = View.Group_Tab.Btn_Goods,
      enum = EnumDefine.Depot.Warehouse
    },
    {
      view = View.Group_Food.ScrollGrid_Food,
      btn = View.Group_Tab.Btn_Food,
      enum = EnumDefine.Depot.FridgeItem
    },
    {
      view = View.Group_TrainWeapon.ScrollGrid_TrainWeapon,
      btn = View.Group_Tab.Btn_TrainWeapon,
      enum = EnumDefine.Depot.TrainWeapon
    }
  }
  for k, v in pairs(Controller.TabEnum) do
    v.view.self:SetActive(false)
    v.btn.Group_On:SetActive(false)
    v.btn.Group_Off:SetActive(true)
  end
  DataModel.Warehouse_Space = 0
  for k, v in pairs(PlayerData:GetHomeInfo().coach) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    DataModel.Warehouse_Space = DataModel.Warehouse_Space + coachCA.space
  end
end

return Controller
