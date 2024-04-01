local View = require("UIHomeKeepFastFood/UIHomeKeepFastFoodView")
local DataModel = require("UIHomeKeepFastFood/UIHomeKeepFastFoodDataModel")
local GroupNodeList = {}
local RefreshFriedChicken = function(data)
  local gridController = View.ScrollGrid_MealList.grid.self
  gridController:SetDataCount(#data)
  gridController:RefreshAllElement()
  gridController.ScrollRect.verticalNormalizedPosition = 1
end
local SetFirstMilkTeaPicked = function(isPicked)
  local node = View.Group_MilkTea.Group_Single.Img_MilkTeaBig
  node.Img_Unpicked:SetActive(not isPicked)
  node.Img_Picked:SetActive(isPicked)
end
local RefreshMilkTea = function(data)
  local mealType = DataModel.mealType
  local groupMilkTea = View.Group_MilkTea
  local groupSingle = groupMilkTea.Group_Single
  local groupTeam = groupMilkTea.Group_Team
  groupSingle.self:SetActive(mealType == 1)
  groupTeam.self:SetActive(mealType == 2)
  if mealType == 1 then
    local nodeBig = groupSingle.Img_MilkTeaBig
    local ca = PlayerData:GetFactoryData(data[1].id)
    local bigFoodName = ca.name
    nodeBig.Txt_Name:SetText(bigFoodName)
    nodeBig.Txt_FoodName:SetText(bigFoodName)
    nodeBig.Group_Price.Txt_Num:SetText(ca.cost[1].num)
    SetFirstMilkTeaPicked(DataModel.selectIndex == 1)
    local staticGridSingle = groupSingle.StaticGrid_MilkTea2.grid.self
    staticGridSingle:SetDataCount(#data - 1)
    staticGridSingle:RefreshAllElement()
  elseif mealType == 2 then
    local staticGridTeam = groupTeam.StaticGrid_MilkTeaTeam.grid.self
    staticGridTeam:SetDataCount(#data)
    staticGridTeam:RefreshAllElement()
  end
end
local SetBarSingleBigPicked = function(isPicked)
  View.Group_Bar.Group_BarSingle.Group_BarSingle1.Img_Picked:SetActive(isPicked)
end
local SetBarTeamBigPicked = function(isPicked)
  View.Group_Bar.Group_BarTeam.Group_BarTeam1.Img_Picked:SetActive(isPicked)
end
local RefreshBar = function(data)
  local mealType = DataModel.mealType
  local groupBar = View.Group_Bar
  local groupSingle = groupBar.Group_BarSingle
  local groupTeam = groupBar.Group_BarTeam
  groupSingle.self:SetActive(mealType == 1)
  groupTeam.self:SetActive(mealType == 2)
  if mealType == 1 then
    local nodeBig = groupSingle.Group_BarSingle1
    local ca = PlayerData:GetFactoryData(data[1].id)
    local bigFoodName = ca.name
    nodeBig.Txt_Name:SetText(bigFoodName)
    nodeBig.Group_Price.Txt_Num:SetText(ca.cost[1].num)
    nodeBig.Txt_Des:SetText(ca.des)
    SetBarSingleBigPicked(DataModel.selectIndex == 1)
    local staticGridSingle = groupSingle.StaticGrid_.grid.self
    staticGridSingle:SetDataCount(#data - 1)
    staticGridSingle:RefreshAllElement()
  elseif mealType == 2 then
    local nodeBig = groupTeam.Group_BarTeam1
    local ca = PlayerData:GetFactoryData(data[1].id)
    local bigFoodName = ca.name
    nodeBig.Txt_Name:SetText(bigFoodName)
    nodeBig.Group_Price.Txt_Num:SetText(ca.cost[1].num)
    nodeBig.Txt_Des:SetText(ca.des)
    SetBarTeamBigPicked(DataModel.selectIndex == 1)
    local staticGridTeam = groupTeam.StaticGrid_.grid.self
    staticGridTeam:SetDataCount(#data - 1)
    staticGridTeam:RefreshAllElement()
  end
end
local RefreshRamen = function(data)
  local gridController = View.ScrollGrid_Ramen.grid.self
  gridController:SetDataCount(#data)
  gridController:RefreshAllElement()
  gridController.ScrollRect.verticalNormalizedPosition = 1
end
local RefreshGroupDes = function()
  local data, gridController
  if DataModel.mealType == 1 then
    data = DataModel.singeList
    gridController = View.Group_Single.ScrollGrid_MemberList.grid.self
  else
    data = DataModel.teamList
    gridController = View.Group_Team.ScrollGrid_MemberListTeam.grid.self
  end
  local ca = PlayerData:GetFactoryData(data[DataModel.selectIndex].id)
  local group = View.Group_Des
  group.Group_LCZ.Group_Des.Txt_Num:SetText(GetText(ca.numBuffDesLCZ))
  group.Group_Member.Group_Des.Txt_Num:SetText(GetText(ca.numBuffDesMember))
  local memberTrustList = ca.memberTrust
  local memberTrustDic = {}
  for i = 1, #memberTrustList do
    local memberTrust = {
      tagId = memberTrustList[i].like,
      buffId = memberTrustList[i].buff
    }
    memberTrustDic[memberTrustList[i].id] = memberTrust
  end
  DataModel.memberTrustDic = memberTrustDic
  gridController:SetDataCount(DataModel.roleList.count)
  gridController:RefreshAllElement()
  if not View.Group_Des.IsActive then
    View.Group_Des:SetActive(true)
  end
end
local SwitchMealPanel = function(mealType)
  local data
  if mealType == 1 then
    View.Group_PickMeal.Btn_team.Group_Off:SetActive(true)
    View.Group_PickMeal.Btn_team.Group_On:SetActive(false)
    View.Group_PickMeal.Btn_single.Group_Off:SetActive(false)
    View.Group_PickMeal.Btn_single.Group_On:SetActive(true)
    data = DataModel.singeList
  else
    View.Group_PickMeal.Btn_team.Group_Off:SetActive(false)
    View.Group_PickMeal.Btn_team.Group_On:SetActive(true)
    View.Group_PickMeal.Btn_single.Group_Off:SetActive(true)
    View.Group_PickMeal.Btn_single.Group_On:SetActive(false)
    data = DataModel.teamList
  end
  DataModel.mealType = mealType
  if DataModel.selectIndex then
    DataModel.selectIndex = 1
  end
  local stationPlaceId = DataModel.stationPlaceId
  if stationPlaceId == 81500002 then
    RefreshFriedChicken(data)
  elseif stationPlaceId == 81500003 or stationPlaceId == 81500006 then
    RefreshMilkTea(data)
  elseif stationPlaceId == 81500004 then
    RefreshBar(data)
  elseif DataModel.listPrefab == "ScrollGrid_Ramen" then
    RefreshRamen(data)
  end
end
local InitStationPlace = function()
  local stationPlaceId = DataModel.stationPlaceId
  local ca = PlayerData:GetFactoryData(stationPlaceId, "HomeStationPlaceFactory")
  View.Img_BGtop:SetSprite(ca.bgTop)
  View.Img_BGMemberList:SetSprite(ca.bgRight)
  local tipsUnpicked = View.Img_TipsUnpicked
  tipsUnpicked.self:SetSprite(ca.picRightTip)
  tipsUnpicked.Txt_:SetText(GetText(ca.textRightTip))
  local nodePickMeal = View.Group_PickMeal
  local nodeTeam = nodePickMeal.Btn_team
  local teamGroupOn = nodeTeam.Group_On
  teamGroupOn.Txt_Des:SetText(ca.nameTeam)
  teamGroupOn.Img_Icon:SetSprite(ca.iconTeamOn)
  local teamGroupOff = nodeTeam.Group_Off
  teamGroupOff.Txt_Des:SetText(ca.nameTeam)
  teamGroupOff.Img_Icon:SetSprite(ca.iconTeamOff)
  local nodeSingle = nodePickMeal.Btn_single
  local singleGroupOn = nodeSingle.Group_On
  singleGroupOn.Txt_Des:SetText(ca.nameSingle)
  singleGroupOn.Img_Icon:SetSprite(ca.iconSingleOn)
  local singleGroupOff = nodeSingle.Group_Off
  singleGroupOff.Txt_Des:SetText(ca.nameSingle)
  singleGroupOff.Img_Icon:SetSprite(ca.iconSingleOff)
  local groupDes = View.Group_Des
  local desGender = groupDes.Group_LCZ
  desGender.Img_bg:SetSprite(ca.bgBuffDesLCZ)
  desGender.Txt_LCZ:SetText(GetText(ca.titleBuffDesLCZ))
  local memberDes = groupDes.Group_Member
  memberDes.Img_bg:SetSprite(ca.bgBuffDesMember)
  memberDes.Txt_Member:SetText(GetText(ca.titleBuffDesMember))
  if GroupNodeList[stationPlaceId] == nil then
    GroupNodeList[stationPlaceId] = ca.listPrefab
  end
  for k, v in pairs(GroupNodeList) do
    if k == stationPlaceId then
      View[v].self:SetActive(true)
    else
      View[v].self:SetActive(false)
    end
  end
  SwitchMealPanel(1)
end
local RefreshRolePanel = function()
  View.Group_Single:SetActive(DataModel.mealType == 1)
  View.Group_Team:SetActive(DataModel.mealType ~= 1)
  local gridController
  if DataModel.mealType == 1 then
    gridController = View.Group_Single.ScrollGrid_MemberList.grid.self
  else
    gridController = View.Group_Team.ScrollGrid_MemberListTeam.grid.self
  end
  gridController:SetDataCount(DataModel.roleList.count)
  gridController:RefreshAllElement()
  gridController.ScrollRect.verticalNormalizedPosition = 1
end
local RefreshTab = function(selectTab, squadId)
  if selectTab ~= DataModel.nowTab then
    local count = 0
    local noBuffCount = 0
    if 0 < squadId then
      local roleList = PlayerData.ServerData.squad[squadId].role_list
      for k, v in pairs(roleList) do
        if v.id then
          local isBuffOwned = PlayerData:GetCurStationStoreBuff(tostring(v.id), EnumDefine.HomeSkillEnum.AddTrust) ~= nil
          if not isBuffOwned then
            noBuffCount = noBuffCount + 1
          end
          count = count + 1
        end
      end
      if noBuffCount ~= 0 or count == 0 then
        local posx = View.Group_Team.Img_PickTeam[selectTab].CachedTransform.localPosition.x
        DOTweenTools.DOLocalMoveXCallback(View.Group_Team.Img_PickTeam.Img_Picked.transform, posx, 0.25, nil)
        DataModel.RoleSort(squadId)
      else
        CommonTips.OpenTips(GetText(80601820))
        return
      end
    else
      local posx = View.Group_Team.Img_PickTeam[selectTab].CachedTransform.localPosition.x
      DOTweenTools.DOLocalMoveXCallback(View.Group_Team.Img_PickTeam.Img_Picked.transform, posx, 0.25, nil)
      DataModel.RoleSort(squadId)
    end
    View.Group_Team.Img_PickTeam[selectTab].Group_Off:SetActive(false)
    View.Group_Team.Img_PickTeam[selectTab].Group_On:SetActive(true)
    if DataModel.nowTab then
      View.Group_Team.Img_PickTeam[DataModel.nowTab].Group_Off:SetActive(true)
      View.Group_Team.Img_PickTeam[DataModel.nowTab].Group_On:SetActive(false)
    end
    RefreshRolePanel()
  end
  DataModel.nowTab = selectTab
end
local InitRoleTab = function()
  View.Group_Team.Img_PickTeam.Btn_Free.Group_Off:SetActive(false)
  View.Group_Team.Img_PickTeam.Btn_Free.Group_On:SetActive(true)
  if DataModel.nowTab and DataModel.nowTab ~= "Btn_Free" then
    View.Group_Team.Img_PickTeam[DataModel.nowTab].Group_Off:SetActive(true)
    View.Group_Team.Img_PickTeam[DataModel.nowTab].Group_On:SetActive(false)
  end
  DataModel.nowTab = "Btn_Free"
  local posx = View.Group_Team.Img_PickTeam.Btn_Free.CachedTransform.localPosition.x
  View.Group_Team.Img_PickTeam.Img_Picked:SetLocalPositionX(posx)
end
local ViewFunction = {
  HomeKeepFastFood_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  HomeKeepFastFood_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
    HomeStationStoreManager:QuitStationStore()
    local sDataModel = require("UIMainUI/UIMainUIDataModel")
    if MainManager.bgSceneName == sDataModel.SceneNameEnum.Home then
      local HomeController = require("UIHome/UIHomeController")
      local HomeCoachDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
      local HomeCoachController = require("UIHomeCoach/UIHomeCoachController")
      HomeController:RefreshTrains()
      HomeCoachController:InitEnvironment()
      HomeCharacterManager:CreateAll(HomeCoachDataModel.characterData, HomeCoachDataModel.petData)
      HomeCharacterManager:ReShowAll()
    end
  end,
  HomeKeepFastFood_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeKeepFastFood_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomeKeepFastFood_Group_Top_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  HomeKeepFastFood_Group_PickMeal_Btn_team_Click = function(btn, str)
    if View.Group_PickMeal.Btn_team.Group_Off.gameObject.activeInHierarchy then
      local posx = View.Group_PickMeal.Btn_team.CachedTransform.localPosition.x
      DOTweenTools.DOLocalMoveXCallback(View.Group_PickMeal.Img_Picked.transform, posx, 0.25, nil)
      SwitchMealPanel(2)
      DataModel.RoleSort(0)
      if DataModel.selectIndex then
        DataModel.teamRoleList = {count = 0}
        InitRoleTab()
        local aniName = View.Group_Single.IsActive and "FrameSingleToTeam" or "InFrameTeam"
        RefreshRolePanel()
        View.self:SelectPlayAnim(View.Group_Team.self, "InPickTeam")
        View.self:SelectPlayAnim(View.Img_FrameMemberList, aniName)
        RefreshGroupDes()
      end
      View.self:PlayAnimOnce("InMeal")
    end
  end,
  HomeKeepFastFood_Group_PickMeal_Btn_single_Click = function(btn, str)
    if View.Group_PickMeal.Btn_single.Group_Off.gameObject.activeInHierarchy then
      local posx = View.Group_PickMeal.Btn_single.CachedTransform.localPosition.x
      DOTweenTools.DOLocalMoveXCallback(View.Group_PickMeal.Img_Picked.transform, posx, 0.25, nil)
      SwitchMealPanel(1)
      DataModel.RoleSort(0)
      if DataModel.selectIndex then
        DataModel.singleRoleId = nil
        local aniName = View.Group_Team.IsActive and "FrameTeamToSingle" or "InFrameSingle"
        RefreshRolePanel()
        View.self:SelectPlayAnim(View.Group_Single.self, "InPickSingle")
        View.self:SelectPlayAnim(View.Img_FrameMemberList, aniName)
        RefreshGroupDes()
      end
      View.self:PlayAnimOnce("InMeal")
    end
  end,
  HomeKeepFastFood_ScrollGrid_MealList_SetGrid = function(element, elementIndex)
    local data
    if DataModel.mealType == 1 then
      data = DataModel.singeList
    else
      data = DataModel.teamList
    end
    local cfg = PlayerData:GetFactoryData(data[elementIndex].id)
    element.Img_Food:SetSprite(cfg.foodImagePath)
    element.Txt_Title:SetText(cfg.name)
    element.Txt_Title:SetText(cfg.name)
    element.Img_BGPicked.Txt_Des:SetText(cfg.des)
    element.Img_BGUnpicked.Txt_Des:SetText(cfg.des)
    element.Group_Price.Txt_Num:SetText(cfg.cost[1].num)
    element.Btn_:SetClickParam(elementIndex)
    element.Img_BGPicked:SetActive(DataModel.selectIndex == elementIndex)
  end,
  HomeKeepFastFood_ScrollGrid_MealList_Group_Item_Btn__Click = function(btn, str)
    if DataModel.selectIndex == nil then
      InitRoleTab()
      RefreshRolePanel()
      View.Btn_Confirm:SetActive(true)
      View.Img_TipsUnpicked:SetActive(false)
      View.Img_FrameMemberList:SetActive(true)
      local aniName = View.Group_Single.IsActive and "InFrameSingle" or "InFrameTeam"
      View.self:SelectPlayAnim(View.Img_FrameMemberList, aniName)
    end
    DataModel.selectIndex = tonumber(str)
    View.ScrollGrid_MealList.grid.self:RefreshAllElement()
    RefreshGroupDes()
  end,
  HomeKeepFastFood_Group_Single_ScrollGrid_MemberList_SetGrid = function(element, elementIndex)
    local data = DataModel.roleList[elementIndex]
    element.Btn_ProfilePhoto:SetSprite(data.face)
    element.Txt_Name:SetText(data.name)
    element.Btn_ProfilePhoto:SetClickParam(elementIndex)
    local roleInfo = PlayerData:GetRoleById(DataModel.roleList[elementIndex].id)
    local roleTrustLv = roleInfo.trust_lv or 1
    local roleTrustLvExp = roleInfo.trust_exp or 0
    element.Group_TrustLevel.Group_Level.Txt_Num:SetText(roleTrustLv)
    if 10 <= roleTrustLv then
      element.Group_ProgressBar.Img_Progress:SetFilledImgAmount(1)
    else
      local exp = DataModel.trustExpList[roleTrustLv].exp
      element.Group_ProgressBar.Img_Progress:SetFilledImgAmount(roleTrustLvExp / exp)
    end
    if DataModel.roleList[elementIndex].id == DataModel.singleRoleId then
      element.Img_Selected:SetActive(true)
    else
      element.Img_Selected:SetActive(false)
    end
    if DataModel.memberTrustDic then
      local memberTrust = DataModel.memberTrustDic[tonumber(data.id)]
      if memberTrust ~= nil then
        local tagCA = PlayerData:GetFactoryData(memberTrust.tagId, "TagFactory")
        element.Img_Like:SetSprite(tagCA.icon)
      end
    end
    local isBuffOwned = PlayerData:GetCurStationStoreBuff(tostring(DataModel.roleList[elementIndex].id), EnumDefine.HomeSkillEnum.AddTrust) ~= nil
    element.Img_buffOwned:SetActive(isBuffOwned)
  end,
  HomeKeepFastFood_Group_Single_ScrollGrid_MemberList_Group_Item_Btn_ProfilePhoto_Click = function(btn, str)
    local isBuffOwned = PlayerData:GetCurStationStoreBuff(tostring(DataModel.roleList[tonumber(str)].id), EnumDefine.HomeSkillEnum.AddTrust) ~= nil
    if isBuffOwned then
      CommonTips.OpenTips(GetText(80601821))
      return
    end
    if DataModel.roleList[tonumber(str)].id == DataModel.singleRoleId then
      DataModel.singleRoleId = nil
    else
      DataModel.singleRoleId = DataModel.roleList[tonumber(str)].id
    end
    View.Group_Single.ScrollGrid_MemberList.grid.self:RefreshAllElement()
  end,
  HomeKeepFastFood_Group_Team_ScrollGrid_MemberListTeam_SetGrid = function(element, elementIndex)
    local data = DataModel.roleList[elementIndex]
    element.Btn_ProfilePhoto:SetSprite(data.face)
    element.Txt_Name:SetText(data.name)
    element.Btn_ProfilePhoto:SetClickParam(elementIndex)
    local roleInfo = PlayerData:GetRoleById(DataModel.roleList[elementIndex].id)
    local roleTrustLv = roleInfo.trust_lv or 1
    local roleTrustLvExp = roleInfo.trust_exp or 0
    element.Group_TrustLevel.Group_Level.Txt_Num:SetText(roleTrustLv)
    if 10 <= roleTrustLv then
      element.Group_ProgressBar.Img_Progress:SetFilledImgAmount(1)
    else
      local exp = DataModel.trustExpList[roleTrustLv].exp
      element.Group_ProgressBar.Img_Progress:SetFilledImgAmount(roleTrustLvExp / exp)
    end
    if DataModel.teamRoleList[DataModel.roleList[elementIndex].id] then
      element.Img_Selected:SetActive(true)
    else
      element.Img_Selected:SetActive(false)
    end
    element.Img_Like:SetActive(false)
    if DataModel.memberTrustDic then
      local memberTrust = DataModel.memberTrustDic[tonumber(data.id)]
      if memberTrust ~= nil then
        local tagCA = PlayerData:GetFactoryData(memberTrust.tagId, "TagFactory")
        element.Img_Like:SetActive(true)
        element.Img_Like:SetSprite(tagCA.icon)
      end
    end
    local isBuffOwned = PlayerData:GetCurStationStoreBuff(tostring(DataModel.roleList[elementIndex].id), EnumDefine.HomeSkillEnum.AddTrust) ~= nil
    element.Img_buffOwned:SetActive(isBuffOwned)
  end,
  HomeKeepFastFood_Group_Team_ScrollGrid_MemberListTeam_Group_Item_Btn_ProfilePhoto_Click = function(btn, str)
    local isBuffOwned = PlayerData:GetCurStationStoreBuff(tostring(DataModel.roleList[tonumber(str)].id), EnumDefine.HomeSkillEnum.AddTrust) ~= nil
    if isBuffOwned then
      CommonTips.OpenTips(GetText(80601821))
      return
    end
    local id = DataModel.roleList[tonumber(str)].id
    if DataModel.teamRoleList[id] then
      DataModel.teamRoleList[id] = nil
      DataModel.teamRoleList.count = DataModel.teamRoleList.count - 1
      if DataModel.nowTab ~= "Btn_Free" then
        RefreshTab("Btn_Free", -1)
      end
    else
      if DataModel.teamRoleList.count == 5 then
        CommonTips.OpenTips(GetText(80601094))
        return
      end
      DataModel.teamRoleList[id] = 1
      DataModel.teamRoleList.count = DataModel.teamRoleList.count + 1
      if DataModel.nowTab ~= "Btn_Free" then
        RefreshTab("Btn_Free", -1)
      end
    end
    View.Group_Team.ScrollGrid_MemberListTeam.grid.self:RefreshAllElement()
  end,
  HomeKeepFastFood_Btn_Confirm_Click = function(btn, str)
    local data = DataModel.mealType == 1 and DataModel.singeList or DataModel.teamList
    local mealId = data[DataModel.selectIndex].id
    local mealCA = PlayerData:GetFactoryData(mealId)
    if PlayerData:GetUserInfo().gold - mealCA.cost[1].num < 0 then
      local item_id = mealCA.cost[1].id
      local name = PlayerData:GetFactoryData(item_id).name
      CommonTips.OpenTips(string.format(GetText(80601083), name))
      return
    end
    local roleParams = ""
    local selectRoleList = {}
    if DataModel.mealType == 1 then
      roleParams = DataModel.singleRoleId or ""
      table.insert(selectRoleList, DataModel.singleRoleId)
    else
      local count = DataModel.teamRoleList.count
      if count <= 0 or 5 < count then
        CommonTips.OpenTips(GetText(80601082))
        return
      end
      for k, v in pairs(DataModel.teamRoleList) do
        if k ~= "count" then
          roleParams = roleParams == "" and k or roleParams .. "|" .. k
          table.insert(selectRoleList, k)
        end
      end
      table.sort(selectRoleList, function(e1, e2)
        return DataModel:GetRoleIndex(e1) < DataModel:GetRoleIndex(e2)
      end)
    end
    if roleParams ~= "" then
      Net:SendProto("meal.fried_chicken", function(json)
        local buffDic = json.home_skills
        local curTrainBuffType = PlayerData:GetCurTrainBuffType()
        if #mealCA.speed > 0 and curTrainBuffType then
          PlayerData.ServerData.home_skills[curTrainBuffType] = nil
          PlayerData:SetStationStoreBuff(nil, curTrainBuffType)
        end
        if 0 < #mealCA.battleBuffList then
          PlayerData.ServerData.home_skills[EnumDefine.HomeSkillEnum.HomeBattleBuff] = nil
          PlayerData:SetStationStoreBuff(nil, EnumDefine.HomeSkillEnum.HomeBattleBuff)
        end
        for k, v in pairs(buffDic) do
          PlayerData.ServerData.home_skills[k] = v
          PlayerData:SetStationStoreBuff(v, k)
        end
        UIManager:GoBack()
        DataModel.RefreshRoleInfo(mealId, selectRoleList)
      end, mealId, roleParams)
    else
      CommonTips.OpenTips(GetText(80601082))
    end
  end,
  HomeKeepFastFood_Group_Team_Img_PickTeam_Btn_Free_Click = function(btn, str)
    RefreshTab("Btn_Free", 0)
  end,
  HomeKeepFastFood_Group_Team_Img_PickTeam_Btn_Team1_Click = function(btn, str)
    RefreshTab("Btn_Team1", 1)
  end,
  HomeKeepFastFood_Group_Team_Img_PickTeam_Btn_Team2_Click = function(btn, str)
    RefreshTab("Btn_Team2", 2)
  end,
  HomeKeepFastFood_Group_Team_Img_PickTeam_Btn_Team3_Click = function(btn, str)
    RefreshTab("Btn_Team3", 3)
  end,
  HomeKeepFastFood_Group_Team_Img_PickTeam_Btn_Team4_Click = function(btn, str)
    RefreshTab("Btn_Team4", 4)
  end,
  HomeKeepFastFood_Group_MilkTea_Group_MilkTea2_Btn__Click = function(btn, str)
  end,
  HomeKeepFastFood_Group_MilkTea_Group_Single_Img_MilkTeaBig_Btn__Click = function(btn, str)
    if DataModel.selectIndex == nil then
      InitRoleTab()
      RefreshRolePanel()
      View.Btn_Confirm:SetActive(true)
      View.Img_TipsUnpicked:SetActive(false)
      View.Img_FrameMemberList:SetActive(true)
      local aniName = "InFrameSingle"
      View.self:SelectPlayAnim(View.Img_FrameMemberList, aniName)
    end
    DataModel.selectIndex = 1
    SetFirstMilkTeaPicked(true)
    View.Group_MilkTea.Group_Single.StaticGrid_MilkTea2.grid.self:RefreshAllElement()
    RefreshGroupDes()
  end,
  HomeKeepFastFood_Group_MilkTea_Group_Single_StaticGrid_MilkTea2_SetGrid = function(element, elementIndex)
    local data = DataModel.singeList
    local ca = PlayerData:GetFactoryData(data[elementIndex + 1].id)
    local node = element.Img_MilkTea2
    node.Img_Picked:SetActive(DataModel.selectIndex == elementIndex + 1)
    local name = ca.name
    node.Txt_Name:SetText(name)
    node.Txt_FoodName:SetText(name)
    node.Txt_Des:SetText(ca.des)
    node.Img_Pic:SetSprite(ca.foodImagePath)
    node.Group_Price.Txt_Num:SetText(ca.cost[1].num)
    element.Btn_:SetClickParam(elementIndex + 1)
  end,
  HomeKeepFastFood_Group_MilkTea_Group_Single_StaticGrid_MilkTea2_Group_MilkTea2_Btn__Click = function(btn, str)
    if DataModel.selectIndex == nil then
      InitRoleTab()
      RefreshRolePanel()
      View.Btn_Confirm:SetActive(true)
      View.Img_TipsUnpicked:SetActive(false)
      View.Img_FrameMemberList:SetActive(true)
      local aniName = "InFrameSingle"
      View.self:SelectPlayAnim(View.Img_FrameMemberList, aniName)
    end
    DataModel.selectIndex = tonumber(str)
    SetFirstMilkTeaPicked(false)
    View.Group_MilkTea.Group_Single.StaticGrid_MilkTea2.grid.self:RefreshAllElement()
    RefreshGroupDes()
  end,
  HomeKeepFastFood_Group_MilkTea_Group_Team_StaticGrid_MilkTeaTeam_SetGrid = function(element, elementIndex)
    local data = DataModel.teamList
    local ca = PlayerData:GetFactoryData(data[elementIndex].id)
    local node = element.Img_MilkTea2
    node.Img_Picked:SetActive(DataModel.selectIndex == elementIndex)
    local name = ca.name
    node.Txt_Name:SetText(name)
    node.Txt_FoodName:SetText(name)
    node.Txt_Des:SetText(ca.des)
    node.Img_Pic:SetSprite(ca.foodImagePath)
    node.Group_Price.Txt_Num:SetText(ca.cost[1].num)
    element.Btn_:SetClickParam(elementIndex)
  end,
  HomeKeepFastFood_Group_MilkTea_Group_Team_StaticGrid_MilkTeaTeam_Group_MilkTea2_Btn__Click = function(btn, str)
    if DataModel.selectIndex == nil then
      InitRoleTab()
      RefreshRolePanel()
      View.Btn_Confirm:SetActive(true)
      View.Img_TipsUnpicked:SetActive(false)
      View.Img_FrameMemberList:SetActive(true)
      local aniName = "InFrameTeam"
      View.self:SelectPlayAnim(View.Img_FrameMemberList, aniName)
    end
    DataModel.selectIndex = tonumber(str)
    View.Group_MilkTea.Group_Team.StaticGrid_MilkTeaTeam.grid.self:RefreshAllElement()
    RefreshGroupDes()
  end,
  SwitchMealPanel = SwitchMealPanel,
  InitStationPlace = InitStationPlace,
  HomeKeepFastFood_Group_Bar_Group_BarSingle2_Btn__Click = function(btn, str)
  end,
  HomeKeepFastFood_Group_Bar_Group_BarTeam2_Btn__Click = function(btn, str)
  end,
  HomeKeepFastFood_Group_Bar_Group_BarSingle_Group_BarSingle1_Btn__Click = function(btn, str)
    if DataModel.selectIndex == nil then
      InitRoleTab()
      RefreshRolePanel()
      View.Btn_Confirm:SetActive(true)
      View.Img_TipsUnpicked:SetActive(false)
      View.Img_FrameMemberList:SetActive(true)
      local aniName = "InFrameSingle"
      View.self:SelectPlayAnim(View.Img_FrameMemberList, aniName)
    end
    DataModel.selectIndex = 1
    SetBarSingleBigPicked(true)
    View.Group_Bar.Group_BarSingle.StaticGrid_.grid.self:RefreshAllElement()
    RefreshGroupDes()
  end,
  HomeKeepFastFood_Group_Bar_Group_BarSingle_StaticGrid__SetGrid = function(element, elementIndex)
    local data = DataModel.singeList
    local ca = PlayerData:GetFactoryData(data[elementIndex + 1].id)
    element.Img_Picked:SetActive(DataModel.selectIndex == elementIndex + 1)
    local name = ca.name
    element.Txt_Name:SetText(name)
    element.Txt_Des:SetText(ca.des)
    element.Img_Pic:SetSprite(ca.foodImagePath)
    element.Group_Price.Txt_Num:SetText(ca.cost[1].num)
    element.Btn_:SetClickParam(elementIndex + 1)
  end,
  HomeKeepFastFood_Group_Bar_Group_BarSingle_StaticGrid__Group_BarSingle2_Btn__Click = function(btn, str)
    if DataModel.selectIndex == nil then
      InitRoleTab()
      RefreshRolePanel()
      View.Btn_Confirm:SetActive(true)
      View.Img_TipsUnpicked:SetActive(false)
      View.Img_FrameMemberList:SetActive(true)
      local aniName = "InFrameSingle"
      View.self:SelectPlayAnim(View.Img_FrameMemberList, aniName)
    end
    DataModel.selectIndex = tonumber(str)
    SetBarSingleBigPicked(false)
    View.Group_Bar.Group_BarSingle.StaticGrid_.grid.self:RefreshAllElement()
    RefreshGroupDes()
  end,
  HomeKeepFastFood_Group_Bar_Group_BarTeam_Group_BarTeam1_Btn__Click = function(btn, str)
    if DataModel.selectIndex == nil then
      InitRoleTab()
      RefreshRolePanel()
      View.Btn_Confirm:SetActive(true)
      View.Img_TipsUnpicked:SetActive(false)
      View.Img_FrameMemberList:SetActive(true)
      local aniName = "InFrameTeam"
      View.self:SelectPlayAnim(View.Img_FrameMemberList, aniName)
    end
    DataModel.selectIndex = 1
    SetBarTeamBigPicked(true)
    View.Group_Bar.Group_BarTeam.StaticGrid_.grid.self:RefreshAllElement()
    RefreshGroupDes()
  end,
  HomeKeepFastFood_Group_Bar_Group_BarTeam_StaticGrid__SetGrid = function(element, elementIndex)
    local data = DataModel.teamList
    local ca = PlayerData:GetFactoryData(data[elementIndex + 1].id)
    element.Img_Picked:SetActive(DataModel.selectIndex == elementIndex + 1)
    element.Img_Pic:SetSprite(ca.foodImagePath)
    element.Group_Price.Txt_Num:SetText(ca.cost[1].num)
    element.Txt_Des:SetText(ca.des)
    element.Btn_:SetClickParam(elementIndex + 1)
  end,
  HomeKeepFastFood_Group_Bar_Group_BarTeam_StaticGrid__Group_BarTeam2_Btn__Click = function(btn, str)
    if DataModel.selectIndex == nil then
      InitRoleTab()
      RefreshRolePanel()
      View.Btn_Confirm:SetActive(true)
      View.Img_TipsUnpicked:SetActive(false)
      View.Img_FrameMemberList:SetActive(true)
      local aniName = "InFrameTeam"
      View.self:SelectPlayAnim(View.Img_FrameMemberList, aniName)
    end
    DataModel.selectIndex = tonumber(str)
    SetBarTeamBigPicked(false)
    View.Group_Bar.Group_BarTeam.StaticGrid_.grid.self:RefreshAllElement()
    RefreshGroupDes()
  end,
  HomeKeepFastFood_Group_Des_Group_LCZ_Btn_IconTip_Click = function(btn, str)
    local imgTip = View.Group_Des.Img_Tip
    if imgTip.self.IsActive then
      imgTip.self:SetActive(false)
      View.Btn_TipMask:SetActive(false)
      return
    end
    imgTip:SetActive(true)
    View.Btn_TipMask:SetActive(true)
    local stationPlaceId = DataModel.stationPlaceId
    local ca = PlayerData:GetFactoryData(stationPlaceId, "HomeStationPlaceFactory")
    imgTip.Img_Line:SetSprite(ca.decBuffDesLCZ)
    local data
    if DataModel.mealType == 1 then
      data = DataModel.singeList
    else
      data = DataModel.teamList
    end
    ca = PlayerData:GetFactoryData(data[DataModel.selectIndex].id)
    imgTip.Txt_Des:SetText(GetText(ca.tipBuffDesLCZ))
  end,
  HomeKeepFastFood_Group_Des_Group_Member_Btn_IconTip_Click = function(btn, str)
    local imgTip = View.Group_Des.Img_Tip
    if imgTip.self.IsActive then
      imgTip.self:SetActive(false)
      View.Btn_TipMask:SetActive(false)
      return
    end
    imgTip:SetActive(true)
    View.Btn_TipMask:SetActive(true)
    local stationPlaceId = DataModel.stationPlaceId
    local ca = PlayerData:GetFactoryData(stationPlaceId, "HomeStationPlaceFactory")
    imgTip.Img_Line:SetSprite(ca.decBuffDesMember)
    local data
    if DataModel.mealType == 1 then
      data = DataModel.singeList
    else
      data = DataModel.teamList
    end
    ca = PlayerData:GetFactoryData(data[DataModel.selectIndex].id)
    imgTip.Txt_Des:SetText(GetText(ca.tipBuffDesMember))
  end,
  HomeKeepFastFood_Btn_TipMask_Click = function(btn, str)
    View.Group_Des.Img_Tip.self:SetActive(false)
    View.Btn_TipMask:SetActive(false)
  end,
  HomeKeepFastFood_ScrollGrid_Ramen_SetGrid = function(element, elementIndex)
    local data
    if DataModel.mealType == 1 then
      data = DataModel.singeList
    else
      data = DataModel.teamList
    end
    local cfg = PlayerData:GetFactoryData(data[elementIndex].id)
    element.Img_Food:SetSprite(cfg.foodImagePath)
    element.Txt_Title:SetText(cfg.name)
    element.Img_Picked.Group_Price.Txt_Num:SetText(cfg.cost[1].num)
    element.Group_Price.Txt_Num:SetText(cfg.cost[1].num)
    element.Btn_:SetClickParam(elementIndex)
    element.Img_Picked:SetActive(DataModel.selectIndex == elementIndex)
    element.Img_Type:SetSprite(cfg.battleBuffImagePath)
  end,
  HomeKeepFastFood_ScrollGrid_Ramen_Group_Item_Btn__Click = function(btn, str)
    if DataModel.selectIndex == nil then
      InitRoleTab()
      RefreshRolePanel()
      View.Btn_Confirm:SetActive(true)
      View.Img_TipsUnpicked:SetActive(false)
      View.Img_FrameMemberList:SetActive(true)
      local aniName = View.Group_Single.IsActive and "InFrameSingle" or "InFrameTeam"
      View.self:SelectPlayAnim(View.Img_FrameMemberList, aniName)
    end
    DataModel.selectIndex = tonumber(str)
    View.ScrollGrid_Ramen.grid.self:RefreshAllElement()
    RefreshGroupDes()
  end
}
return ViewFunction
