local View = require("UINewHomeLive/UINewHomeLiveView")
local DataModel = require("UINewHomeLive/UINewHomeLiveDataModel")
local Controller = {}
local this = Controller

function Controller.Init()
  DataModel.InitLiveFurData()
  DataModel.RefreshAllFurnitureLiveInfo()
  this.RefreshFurnitureInfo()
  this.RefreshWaste()
  this.RefreshLivePanel()
  this.RefreshLightInfo()
  View.Group_CharacterList:SetActive(false)
end

function Controller.RefreshFurnitureInfo()
  local cfg = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
  View.Group_Details.Txt_Name:SetText(cfg.name .. " LV" .. cfg.Level)
end

function Controller.RefreshWaste()
  local cfg = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
  local totalWaste = 0
  local roles = PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].roles or {}
  for i, v in pairs(roles) do
    if v ~= "" then
      local unitCA = PlayerData:GetFactoryData(v, "UnitFactory")
      totalWaste = totalWaste + unitCA.WasteCoefficient * cfg.wasteoutput
    end
  end
  View.Group_Details.Group_LJ.Group_sum.Txt_Num:SetText(math.floor(totalWaste))
end

function Controller.RefreshLivePanel()
  local canLiveInNum = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory").characterNum
  local count = View.Group_Details.Group_Bed.self.transform.childCount
  for i = 1, count do
    local child = View.Group_Details.Group_Bed["Group_Bed" .. i]
    child:SetActive(i <= canLiveInNum)
    child.Group_Change:SetActive(false)
    child.Group_Checkin:SetActive(true)
  end
  if PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].roles then
    for i, id in pairs(PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].roles) do
      if id ~= "" then
        local ctr = View.Group_Details.Group_Bed["Group_Bed" .. i]
        ctr.Group_Change:SetActive(true)
        ctr.Group_Checkin:SetActive(false)
        local unitCA = PlayerData:GetFactoryData(id, "UnitFactory")
        local unitViewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
        local profilePhotoCA = PlayerData:GetFactoryData(unitViewCA.profilePhotoID, "ProfilePhotoFactory")
        ctr.Group_Change.Txt_Name:SetText(unitCA.name)
        ctr.Group_Change.Group_lv.Txt_LV:SetText(PlayerData.ServerData.roles[id].lv)
        ctr.Group_Change.Group_Member.Btn_Change.Img_member:SetSprite(profilePhotoCA.imagePath)
        this.RefreshSleep(ctr, id)
      end
    end
  end
  local height = 1030 - (2 - canLiveInNum) * 200
  View.Group_Details:SetHeight(height)
end

function Controller.RefreshFrame(roleId, liveIndex, furUfid)
  local state = roleId ~= ""
  local iconPath = ""
  if state then
    local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
    local unitViewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
    local profilePhotoCA = PlayerData:GetFactoryData(unitViewCA.profilePhotoID, "ProfilePhotoFactory")
    iconPath = profilePhotoCA.imagePath
  end
  HomeManager:RefreshFurPhotoFrame(furUfid, liveIndex, state, iconPath)
end

function Controller.RefreshSleep(ctr, roleId)
  if not roleId or roleId == "" then
    return
  end
  local unitCA = PlayerData:GetFactoryData(roleId, "unitFactory")
  local character = HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter))
  local remainTime = PlayerData:GetRoleRemainSleepTime(roleId)
  if 0 < remainTime then
    ctr.Group_Change.Group_sleep.Group_sleeping.Txt_time:SetText("剩余" .. os.date("!%H:%M:%S", remainTime))
  else
    if PlayerData.RoleSleepTime[tostring(roleId)] then
      HomeCharacterManager:StopOp(character)
    end
    PlayerData:SetRoleSleepTime(roleId, 0)
  end
  ctr.Group_Change.Group_sleep.Group_sleeping:SetActive(0 < remainTime and character:CheckSleepRemainTimeShow())
  ctr.Group_Change.Group_sleep.Btn_gotoSleep:SetActive(remainTime <= 0 or not character:CheckSleepRemainTimeShow())
end

function Controller.RefreshLightInfo()
  local cfg = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
  if cfg.upgrade > 0 then
    local maxInfo = DataModel.GetMaxLvFurnitureInfo(DataModel.curFurId)
    if maxInfo then
      View.Group_Details.Group_Light.Group_Lock:SetActive(true)
      View.Group_Details.Group_Light.Group_Lock.Group_tips.Group_text.Txt_LockLv:SetText("LV" .. maxInfo.Level)
    else
      View.Group_Details.Group_Light.Group_Lock:SetActive(false)
    end
  else
    View.Group_Details.Group_Light.Group_Lock:SetActive(false)
  end
  local colorType = PlayerData:GetPlayerPrefs("string", "FurLightColor" .. DataModel.curFurUfid)
  colorType = colorType ~= "" and colorType or DataModel.defaultLightColorType
  this.SetRotateZAndColor(colorType, false)
end

function Controller.SetRotateZAndColor(colorType, setColor)
  View.Group_Details.Group_Light.Img_colordisc.Btn_red.Img_on:SetActive(colorType == EnumDefine.EFurLightColorType.Red)
  View.Group_Details.Group_Light.Img_colordisc.Btn_yellow.Img_on:SetActive(colorType == EnumDefine.EFurLightColorType.Yellow)
  View.Group_Details.Group_Light.Img_colordisc.Btn_green.Img_on:SetActive(colorType == EnumDefine.EFurLightColorType.Green)
  View.Group_Details.Group_Light.Img_colordisc.Btn_cyan.Img_on:SetActive(colorType == EnumDefine.EFurLightColorType.Cyan)
  View.Group_Details.Group_Light.Img_colordisc.Btn_blue.Img_on:SetActive(colorType == EnumDefine.EFurLightColorType.Blue)
  View.Group_Details.Group_Light.Img_colordisc.Btn_purple.Img_on:SetActive(colorType == EnumDefine.EFurLightColorType.Purple)
  View.Group_Details.Group_Light.Img_knob.transform.localRotation = Quaternion.Euler(0, 0, EnumDefine.EFurLightColorRotate[colorType])
  if setColor then
    local furCA = PlayerData:GetFactoryData(DataModel.curFurId)
    if furCA.characterNum ~= 1 then
      HomeManager:ChangeFurLight(DataModel.curFurUfid, EnumDefine.EFurLightColor[colorType])
    else
      HomeManager:ChangeFurMaterial(DataModel.curFurUfid, EnumDefine.EFurLightMaterialPath[colorType])
    end
    PlayerData:SetPlayerPrefs("string", "FurLightColor" .. DataModel.curFurUfid, colorType)
  end
end

function Controller.RefreshSelectLiveIn(sortType)
  if sortType == DataModel.ESortType.level then
    DataModel.SortByLevel()
  elseif sortType == DataModel.ESortType.quality then
    DataModel.SortByQuality()
  elseif sortType == DataModel.ESortType.time then
    DataModel.SortByTime()
  end
  UIManager:LoadSplitPrefab(View, "UI/Home/NewHomeLive", "Group_CharacterList")
  View.Group_CharacterList:SetActive(true)
  View.Group_CharacterList.Group_TopRight.Btn_Level.Img_Select:SetActive(sortType == DataModel.ESortType.level)
  View.Group_CharacterList.Group_TopRight.Btn_Rarity.Img_Select:SetActive(sortType == DataModel.ESortType.quality)
  View.Group_CharacterList.Group_TopRight.Btn_Time.Img_Select:SetActive(sortType == DataModel.ESortType.time)
  View.Group_CharacterList.ScrollGrid_.grid.self:SetDataCount(table.count(DataModel.allCanLiveInCharacter))
  View.Group_CharacterList.ScrollGrid_.grid.self:RefreshAllElement()
end

function Controller.CharacterLiveIn(roleId)
  local roles = PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].roles or {}
  local curRoleId = roles and roles[DataModel.curLiveInPos] or ""
  if curRoleId == roleId then
    PlayerData:SetRoleSleepTime(roleId, 0)
    PlayerData.ServerData.roles[tostring(roleId)].isAutoSleep = false
    if not DataModel.IsInEmergency(roleId) then
      local curLiveInfo = DataModel.characterLiveInfo[roleId]
      HomeCharacterManager:StopOp(HomeCharacterManager:GetCharacterById(curLiveInfo.characterId))
    end
    this.RefreshFrame("", DataModel.curLiveInPos, DataModel.curFurUfid)
    roles[DataModel.curLiveInPos] = ""
    PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].roles = roles
    if PlayerData:GetHomeInfo().meal_info and PlayerData:GetHomeInfo().meal_info.meal_hid and PlayerData:GetHomeInfo().meal_info.meal_hid == tostring(roleId) then
      local homeFoodController = require("UIHomeFood/UIHomeFoodController")
      homeFoodController.InitFoodCook()
    end
  else
    roles[DataModel.curLiveInPos] = roleId
    local selectLiveInfo = DataModel.characterLiveInfo[roleId]
    if selectLiveInfo then
      if selectLiveInfo.ufid == DataModel.curFurUfid then
        roles[selectLiveInfo.pos] = curRoleId
      else
        local furnitureData = PlayerData:GetHomeInfo().furniture[selectLiveInfo.ufid]
        furnitureData.roles[selectLiveInfo.pos] = curRoleId
      end
      if curRoleId ~= "" and not DataModel.IsInEmergency(curRoleId) then
        local unitCA = PlayerData:GetFactoryData(curRoleId, "UnitFactory")
        HomeCharacterManager:ChangeOpFurniture(tonumber(unitCA.homeCharacter), selectLiveInfo.ufid, selectLiveInfo.pos - 1)
      end
      if not DataModel.IsInEmergency(roleId) then
        local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
        HomeCharacterManager:ChangeOpFurniture(tonumber(unitCA.homeCharacter), DataModel.curFurUfid, DataModel.curLiveInPos - 1)
      end
      if curRoleId ~= "" and selectLiveInfo.ufid ~= DataModel.curFurUfid then
        local unitCA = PlayerData:GetFactoryData(curRoleId, "UnitFactory")
        local character = HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter))
        character.view:SetActive(false)
      end
      this.RefreshFrame(curRoleId, selectLiveInfo.pos, selectLiveInfo.ufid)
      this.RefreshFrame(roleId, DataModel.curLiveInPos, DataModel.curFurUfid)
    else
      if curRoleId ~= "" and not DataModel.IsInEmergency(curRoleId) then
        local unitCA = PlayerData:GetFactoryData(curRoleId, "UnitFactory")
        PlayerData:SetRoleSleepTime(curRoleId, 0)
        PlayerData.ServerData.roles[tostring(curRoleId)].isAutoSleep = false
        HomeCharacterManager:StopOp(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)))
      end
      this.RefreshFrame(roleId, DataModel.curLiveInPos, DataModel.curFurUfid)
      if PlayerData:GetHomeInfo().meal_info and PlayerData:GetHomeInfo().meal_info.meal_hid and PlayerData:GetHomeInfo().meal_info.meal_hid == tostring(roleId) then
        local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
        HomeCharacterManager:StopOp(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)))
      end
    end
    PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].roles = roles
  end
  View.Group_CharacterList:SetActive(false)
  this.RefreshWaste()
  this.RefreshLivePanel()
  local liveRoleData = {}
  local furnitureData = PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid]
  local canLiveInNum = PlayerData:GetFactoryData(furnitureData.id, "HomeFurnitureFactory").characterNum
  for i = 1, canLiveInNum do
    liveRoleData[i] = furnitureData.roles and furnitureData.roles[i] and tostring(furnitureData.roles[i]) or ""
  end
  local str = table.concat(liveRoleData, ",")
  Net:SendProto("hero.check_in", function(json)
  end, DataModel.curFurUfid, str, function(json)
    CommonTips.OnPromptConfirmOnly(GetText(json.msg), nil, function()
      UIManager:GoBack()
    end)
  end)
  local selectLiveInfo = DataModel.characterLiveInfo[roleId]
  if selectLiveInfo and selectLiveInfo.ufid ~= DataModel.curFurUfid then
    furnitureData = PlayerData:GetHomeInfo().furniture[selectLiveInfo.ufid]
    canLiveInNum = PlayerData:GetFactoryData(furnitureData.id, "HomeFurnitureFactory").characterNum
    liveRoleData = {}
    for i = 1, canLiveInNum do
      liveRoleData[i] = furnitureData.roles and furnitureData.roles[i] and tostring(furnitureData.roles[i]) or ""
    end
    str = table.concat(liveRoleData, ",")
    Net:SendProto("hero.check_in", function(json)
    end, selectLiveInfo.ufid, str, function(json)
      CommonTips.OnPromptConfirmOnly(GetText(json.msg), nil, function()
        UIManager:GoBack()
      end)
    end)
  end
  DataModel.InitLiveFurData()
  DataModel.RefreshAllFurnitureLiveInfo()
end

function Controller.InitSleep()
  local liveFurData = {}
  for k, v in pairs(PlayerData:GetHomeInfo().furniture) do
    local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furCA.functionType == 12600199 and furCA.characterNum > 0 and v.roles then
      for _, roleId in pairs(v.roles) do
        if roleId ~= "" then
          liveFurData[k] = v
          break
        end
      end
    end
  end
  for ufid, furnitureInfo in pairs(liveFurData) do
    for index, roleId in pairs(furnitureInfo.roles) do
      if roleId ~= "" and not DataModel.IsInEmergency(roleId) then
        local remainTime = PlayerData:GetRoleRemainSleepTime(roleId)
        if 0 < remainTime then
          local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
          HomeCharacterManager:InitContinuousOp(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)), ufid, index - 1, remainTime)
        end
      end
    end
  end
end

function Controller.RefreshAutoSleep()
  for ufid, furnitureInfo in pairs(DataModel.liveFurData) do
    for index, roleId in pairs(furnitureInfo.roles) do
      if roleId ~= "" then
        local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
        local autoSleepTime = DataModel.GetLiveSleepTime(roleId)
        local remainTime = PlayerData:GetRoleRemainSleepTime(roleId)
        if 0 < autoSleepTime and autoSleepTime ~= remainTime then
          PlayerData:SetRoleSleepTime(roleId, autoSleepTime, true)
          if 0 < remainTime then
            HomeCharacterManager:ChangeOpTime(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)), autoSleepTime)
          else
            HomeCharacterManager:StartOp(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)), ufid, index - 1, autoSleepTime)
          end
        end
      end
    end
  end
end

function Controller.RefreshCurFurAutoSleep()
  local furnitureInfo = DataModel.liveFurData[DataModel.curFurUfid]
  if not furnitureInfo then
    return
  end
  for index, roleId in ipairs(furnitureInfo.roles) do
    if roleId ~= "" then
      local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
      local autoSleepTime = DataModel.GetLiveSleepTime(roleId)
      local remainTime = PlayerData:GetRoleRemainSleepTime(roleId)
      if 0 < autoSleepTime and autoSleepTime ~= remainTime then
        PlayerData:SetRoleSleepTime(roleId, autoSleepTime, true)
        if 0 < remainTime then
          HomeCharacterManager:ChangeOpTime(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)), autoSleepTime)
        else
          HomeCharacterManager:StartOp(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)), DataModel.curFurUfid, index - 1, autoSleepTime)
        end
      end
    end
  end
end

return Controller
