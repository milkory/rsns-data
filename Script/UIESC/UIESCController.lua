local View = require("UIESC/UIESCView")
local DataModel = require("UIESC/UIESCDataModel")
local Controller = {}

function Controller:Init()
  View.Group_Info.Group_MoreInfo.self:SetActive(false)
  local user_info = PlayerData:GetUserInfo()
  View.Group_Info.Group_License.Group_LV.Txt_Num:SetText(user_info.lv or 1)
  if user_info.avatar ~= nil and user_info.avatar ~= "" then
    DataModel.headSelectId = tonumber(user_info.avatar)
    DataModel.usedHeadId = DataModel.headSelectId
    local photoFactory = PlayerData:GetFactoryData(user_info.avatar, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      View.Group_Info.Btn_ProfilePhoto.Img_Client:SetSprite(photoFactory.imagePath)
    end
  else
    local gender = user_info.gender or 1
    local head = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    if head ~= nil and head.playerHeadList ~= nil then
      View.Group_Info.Btn_ProfilePhoto.Img_Client:SetSprite(head.playerHeadList[gender + 1].playerHeadPath)
    end
  end
  local endExp = PlayerData:GetMaxExp()
  View.Group_Info.Group_License.Img_PB:SetFilledImgAmount(user_info.exp / endExp)
  View.Group_Info.Group_License.Group_Num.Txt_Now:SetText(user_info.exp)
  View.Group_Info.Group_License.Group_Num.Txt_Max:SetText(endExp)
  View.Group_Info.Txt_UID:SetText(string.format(GetText(80600575), user_info.uid))
  View.Group_Info.Txt_Name:SetText(user_info.role_name or "")
  View.Group_Info.Group_Gold.Txt_Num:SetText(user_info.gold)
  View.Group_Info.Group_Diamond.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
  local homeCommon = require("Common/HomeCommon")
  homeCommon.SetEnergyElement(View.Group_Info.Group_Energy)
  homeCommon.SetMoveEnergyElement(View.Group_Info.Group_HomeEnergy)
  homeCommon.SetLoadageElement(View.Group_Info.Group_Loadage)
  homeCommon.SetTradeElement(View.Group_Info.Group_MoreInfo.Group_Trade)
  DataModel.InitStationList()
  local show = DataModel.TotalRep
  if string.len(DataModel.TotalRep) >= 6 then
    show = PlayerData:TransitionNum(DataModel.TotalRep)
  end
  View.Group_Info.Group_MoreInfo.Txt_Rep:SetText(show)
  DataModel.InitFuncShowList()
  View.NewScrollGrid_BtnList.grid.self:StartC(LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    View.NewScrollGrid_BtnList.grid.self:SetDataCount(#DataModel.FuncShowList)
    View.NewScrollGrid_BtnList.grid.self:RefreshAllElement()
  end))
  local funcCommon = require("Common/FuncCommon")
  local isUnlock = funcCommon.FuncActiveCheck(117, false)
  if isUnlock then
    local count, state = PlayerData:GetUnreadMailNum()
    View.Btn_Mail.Img_Remind.self:SetActive(state)
    View.Btn_Mail.Img_Remind.Txt_Num:SetText(count)
  else
    View.Btn_Mail.Img_Remind.self:SetActive(false)
  end
  View.Group_Info.Group_MoreInfo.Txt_DeterrenceNum:SetText(PlayerData:GetUserInfo().deterrence + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddDeterrence) + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AddDeterrence, PlayerData:GetUserInfo().deterrence))
  View.Group_Info.Group_MoreInfo.Txt_ColoudnessNum:SetText(PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddColoudness) + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AddColoudness, 0))
end

function Controller:Exit()
  View.self:SetEnableAnimator(true)
  View.self:PlayAnim("ESCOut", function()
    UIManager:GoBack()
  end)
  View.Group_Info.Btn_LCZspine.SpineAnimation_:SetActive(false)
end

function Controller:ExitTo(uiName, param)
  View.self:SetEnableAnimator(true)
  View.self:PlayAnim("ESCOut", function()
    UIManager:Open(uiName, param)
  end)
  View.Group_Info.Btn_LCZspine.SpineAnimation_:SetActive(false)
end

function Controller:CheckModifyIsPunish(view, timestamp, tipId)
  if timestamp == 0 then
    UIManager:Open(view)
  else
    local time = os.date("*t", timestamp)
    local min = tostring(time.min)
    if time.min < 10 then
      min = "0" .. min
    end
    local text = " " .. tostring(time.year) .. "-" .. tostring(time.month) .. "-" .. tostring(time.day) .. " " .. tostring(time.hour) .. ":" .. min .. " "
    CommonTips.OnPromptConfirmOnly(GetText(tipId) .. text .. GetText(80600174), GetText(80600068), function()
    end, true)
  end
end

function Controller:OpenStoreBuyDiamond()
  local a, b = PlayerData:OpenStoreCondition()
  if a == false then
    CommonTips.OpenTips(b[1].txt)
    return
  end
  Net:SendProto("shop.info", function(json)
    PlayerData.ServerData.shops = json.shops
    json.index = 1
    Controller:ExitTo("UI/Store/Store", Json.encode(json))
  end)
end

function Controller:ClickHead()
  DataModel.InitHeadInfo()
  DataModel.headSelectId = DataModel.usedHeadId
  UIManager:LoadSplitPrefab(View, "UI/MainUI/ESC", "Group_ChangeProfilePhoto")
  View.Group_ChangeProfilePhoto.self:SetActive(true)
  View.Group_ChangeProfilePhoto.ScrollGrid_ProfilePhoto.grid.self:SetDataCount(#DataModel.headInfo)
  View.Group_ChangeProfilePhoto.ScrollGrid_ProfilePhoto.grid.self:RefreshAllElement()
  View.Group_ChangeProfilePhoto.Txt_Des:SetActive(DataModel.usedHeadId ~= 0)
  if DataModel.usedHeadId ~= 0 then
    local photoFactory = PlayerData:GetFactoryData(DataModel.usedHeadId, "ProfilePhotoFactory")
    View.Group_ChangeProfilePhoto.Txt_Des:SetText(photoFactory.des)
  end
end

function Controller:RefreshHeadElement(element, elementIndex)
  local info = DataModel.headInfo[elementIndex]
  element.Btn_ProfilePhoto:SetSprite(info.headPath)
  element.Txt_Name:SetText(info.headName)
  local isSelect = DataModel.headSelectId == info.headId
  element.Img_Selected.self:SetActive(isSelect)
  element.Btn_ProfilePhoto:SetClickParam(elementIndex)
end

function Controller:ClickHeadElement(str)
  local idx = tonumber(str)
  local info = DataModel.headInfo[idx]
  DataModel.headSelectId = info.headId
  View.Group_Info.Btn_ProfilePhoto.Img_Client:SetSprite(info.headPath)
  View.Group_ChangeProfilePhoto.ScrollGrid_ProfilePhoto.grid.self:RefreshAllElement()
  local photoFactory = PlayerData:GetFactoryData(info.headId, "ProfilePhotoFactory")
  View.Group_ChangeProfilePhoto.Txt_Des:SetText(photoFactory.des)
  View.Group_ChangeProfilePhoto.Txt_Des:SetActive(true)
end

function Controller:CloseChangeHeadPanel(isSave)
  local userInfo = PlayerData:GetUserInfo()
  if isSave then
    if tonumber(userInfo.avatar) == DataModel.headSelectId then
      View.Group_ChangeProfilePhoto.self:SetActive(false)
      return
    end
    Net:SendProto("main.set_avatar", function()
      local photoFactory = PlayerData:GetFactoryData(DataModel.headSelectId, "ProfilePhotoFactory")
      if photoFactory ~= nil then
        View.Group_Info.Btn_ProfilePhoto.Img_Client:SetSprite(photoFactory.imagePath)
      end
      DataModel.usedHeadId = DataModel.headSelectId
      PlayerData:GetUserInfo().avatar = DataModel.usedHeadId
      CommonTips.OpenTips(80600411)
    end, DataModel.headSelectId)
  elseif DataModel.usedHeadId > 0 then
    local photoFactory = PlayerData:GetFactoryData(DataModel.usedHeadId, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      View.Group_Info.Btn_ProfilePhoto.Img_Client:SetSprite(photoFactory.imagePath)
    end
  else
    local gender = PlayerData:GetUserInfo().gender or 1
    local head = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    if head ~= nil and head.playerHeadList ~= nil then
      View.Group_Info.Btn_ProfilePhoto.Img_Client:SetSprite(head.playerHeadList[gender + 1].playerHeadPath)
    end
  end
  View.Group_ChangeProfilePhoto.self:SetActive(false)
end

function Controller:ShowAllRep()
  UIManager:LoadSplitPrefab(View, "UI/MainUI/ESC", "Group_AllRep")
  View.Group_AllRep.self:SetActive(true)
  DataModel.InitStationList()
  View.Group_AllRep.ScrollGrid_CityList.grid.self:SetDataCount(#DataModel.showStationLst)
  View.Group_AllRep.ScrollGrid_CityList.grid.self:MoveToTop()
  View.Group_AllRep.ScrollGrid_CityList.grid.self:RefreshAllElement()
end

function Controller:RefreshRepElement(element, elementIndex)
  local info = DataModel.showStationLst[elementIndex]
  element.Txt_Name:SetText(info.name)
  element.Txt_Num:SetText(info.rep)
end

function Controller.RefreshLvInfo()
  if View.Group_LevelReward.self == nil or not View.Group_LevelReward.self.IsActive then
    return
  end
  View.Group_LevelReward.Img_BG.Group_Tab.ScrollGrid_Tab.grid.self:SetDataCount(#DataModel.lv_cfg)
  View.Group_LevelReward.Img_BG.Group_Tab.ScrollGrid_Tab.grid.self:RefreshAllElement()
  local data = PlayerData:GetFactoryData(DataModel.lv_cfg[DataModel.lv_selectIdx].id)
  View.Group_LevelReward.Img_BG.Group_TopRight.Img_Medal:SetSprite(data.icon)
  View.Group_LevelReward.Img_BG.Group_TopRight.Img_Medal.Txt_Level:SetText(data.Rankname)
  View.Group_LevelReward.Img_BG.Group_BotRight.Img_RewardBg.ScrollGrid_Reward.grid.self.ScrollRect.verticalNormalizedPosition = 1
  View.Group_LevelReward.Img_BG.Group_BotRight.Img_RewardBg.ScrollGrid_Reward.grid.self:SetDataCount(#data.reward)
  View.Group_LevelReward.Img_BG.Group_BotRight.Img_RewardBg.ScrollGrid_Reward.grid.self:RefreshAllElement()
  View.Group_LevelReward.Img_BG.Group_TopRight.Group_Unlock.StaticGrid_UnlockRight.grid.self:RefreshAllElement()
  View.Group_LevelReward.Img_BG.Group_TakeBtn.Img_Lock:SetActive(DataModel.lv_selectIdx > DataModel.max_lvidx)
  local id = tostring(DataModel.lv_cfg[DataModel.lv_selectIdx].id)
  View.Group_LevelReward.Img_BG.Group_TakeBtn.Img_Taken:SetActive(DataModel.rec_list[DataModel.lv_cfg[DataModel.lv_selectIdx].level])
  View.Group_LevelReward.Img_BG.Group_TakeBtn.Btn_Take:SetActive(not DataModel.rec_list[DataModel.lv_cfg[DataModel.lv_selectIdx].level] and DataModel.lv_selectIdx <= DataModel.max_lvidx)
end

function Controller.RefreshSkin()
  local gender = PlayerData:GetUserInfo().gender or 1
  local characterId = gender == 1 and 70000067 or 70000063
  local characterCA = PlayerData:GetFactoryData(characterId, "HomeCharacterFactory")
  local spinePath = characterCA.resStatePath[2] and characterCA.resStatePath[2].path or characterCA.resDir
  View.Group_Info.Btn_LCZspine.SpineAnimation_:SetSpineInit(spinePath, "dorm_stand")
  local takeOnJson = PlayerData.GetCharacterSkinJson(characterId)
  View.Group_Info.Btn_LCZspine.SpineAnimation_:SetActive(true)
  View.Group_Info.Btn_LCZspine.SpineAnimation_:ChangeSkin(takeOnJson)
end

return Controller
