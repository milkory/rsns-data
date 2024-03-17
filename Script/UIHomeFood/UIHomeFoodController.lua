local View = require("UIHomeFood/UIHomeFoodView")
local DataModel = require("UIHomeFood/UIHomeFoodDataModel")
local HomeController = require("UIHome/UIHomeController")
local MainUIController = require("UIMainUI/UIMainUIController")
local Controller = {}

function Controller:Init()
  self:RefreshMoveEnergy()
  View.ScrollGrid_FoodList.self:SetActive(true)
  View.ScrollGrid_FoodList.grid.self:SetDataCount(DataModel.mealCount)
  View.ScrollGrid_FoodList.grid.self:RefreshAllElement()
  self:ShowFoodDetail(1)
  self:InitRewards()
  if not DataModel.isOutside then
    HomeController.UpdateFoodBoxNum()
  end
end

function Controller:InitRewards()
  local rewards = DataModel.reward or {}
  local hasRewards = false
  local rewardsStr = ""
  for k, v in pairs(rewards) do
    local strFormat
    if not hasRewards then
      strFormat = GetText(80601208)
    else
      strFormat = GetText(80601223)
    end
    rewardsStr = rewardsStr .. string.format(strFormat, v.num, PlayerData:GetFactoryData(k).name)
    hasRewards = true
  end
  local group = View.Group_Dialog
  group.self:SetActive(hasRewards)
  if hasRewards then
    group.Txt_Dialog:SetText(string.format(GetText(80601207), rewardsStr))
  end
end

function Controller:RefreshMoveEnergy()
  local homeCommon = require("Common/HomeCommon")
  local maxHomeEnergy = homeCommon.GetMaxHomeEnergy()
  View.Img_TireBG.Txt_Energy:SetText(string.format(GetText(80600345), DataModel.curHomeEnergy, maxHomeEnergy))
  View.Img_TireBG.Img_TireProgress:SetFilledImgAmount(DataModel.curHomeEnergy / maxHomeEnergy)
end

function Controller:UseFood(idx, freeIdx)
  local info = DataModel.foodList[idx]
  local mealId = info.uid
  if freeIdx ~= -1 then
    mealId = ""
  end
  CommonTips.OnPrompt(string.format(GetText(80600341), info.ca.name), nil, nil, function()
    local curEnergy = PlayerData:GetUserInfo().move_energy
    if curEnergy ~= nil and curEnergy <= 0 then
      CommonTips.OpenTips(80600522)
      return
    end
    Net:SendProto("meal.eat", function(json)
      if freeIdx ~= -1 then
        table.insert(PlayerData.ServerData.user_home_info.meal_info.work_meal, freeIdx)
      else
        PlayerData.ServerData.user_home_info.meal_info.box_meal[info.uid] = nil
        local count = PlayerData.ServerData.user_home_info.meal_info.meal_eaten[info.id]
        if count == nil then
          PlayerData.ServerData.user_home_info.meal_info.meal_eaten[tostring(info.id)] = 1
        else
          PlayerData.ServerData.user_home_info.meal_info.meal_eaten[tostring(info.id)] = count + 1
        end
      end
      local lastHomeEnergy = DataModel.curHomeEnergy
      DataModel.curHomeEnergy = PlayerData:GetUserInfo().move_energy or 0
      DataModel.UseFood(idx)
      Controller:RefreshMoveEnergy()
      View.ScrollGrid_FoodList.grid.self:SetDataCount(DataModel.mealCount)
      if DataModel.foodList[idx] == nil then
        self:ShowFoodDetail(1)
      else
        self:ShowFoodDetail(idx)
      end
      CommonTips.OpenTips(80601105)
      if not DataModel.isOutside then
        HomeController.UpdateFoodBoxNum()
      end
      local specialHid = PlayerData.ServerData.user_home_info.meal_info.meal_hid
      local hid = -1
      if specialHid ~= nil and specialHid ~= "" and info.hid == tonumber(specialHid) then
        local unitCA = PlayerData:GetFactoryData(specialHid, "UnitFactory")
        if unitCA == nil then
          error("单位id:" .. specialHid .. "不存在本地配置表,请检查配置")
        end
        hid = unitCA.homeCharacter
        HomeCharacterManager:StopOp(HomeCharacterManager:GetCharacterById(hid))
        PlayerData.ServerData.user_home_info.meal_info.meal_hid = nil
      end
      self.PlayFoodAnim(hid, info, lastHomeEnergy)
    end, mealId, freeIdx)
  end)
end

function Controller:ShowFoodDetail(idx)
  local group = View.Group_Description
  local info = DataModel.foodList[idx]
  local ca = info.ca
  group.Txt_Name:SetText(info.ca.name)
  local isFree = info.free == true
  local BtnUse = group.Btn_Use
  local imgUse = group.Img_Used
  group.Group_FreeOrder:SetActive(isFree)
  group.Group_LoveBento:SetActive(not isFree)
  local riseBentoEnergy = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseBentoEnergy)
  if isFree then
    local freeGroup = group.Group_FreeOrder
    local used = info.used
    local date
    local curTime = PlayerData:GetSeverTime()
    if not used and curTime < TimeUtil:GetFutureTime(0, 5) then
      date = os.date("*t", curTime - 86400)
    else
      date = os.date("*t", curTime)
    end
    freeGroup.Txt_Date:SetText(string.format(GetText(80601198), date.month, date.day))
    local isArrive = self:IsArrive(idx)
    local imgPath = used and "UI\\HomeFurniture\\BGUsedDes" or "UI\\HomeFurniture\\BGNotUsedDes"
    freeGroup.Img_BG:SetSprite(imgPath)
    freeGroup.Group_Time:SetActive(used or not isArrive)
    freeGroup.Group_Tire:SetActive(not used and isArrive)
    BtnUse:SetActive(not used and isArrive)
    imgUse.self:SetActive(used)
    if used or not isArrive then
      self:UpdateGroupTime(idx)
    else
      freeGroup.Group_Tire.Txt_Energy:SetText(-(ca.energy + riseBentoEnergy))
    end
    freeGroup.Txt_Des:SetText(ca.des)
  else
    local loveGroup = group.Group_LoveBento
    local heroCA = PlayerData:GetFactoryData(info.hid, "UnitFactory")
    loveGroup.Txt_Subtitle:SetText(string.format(GetText(80601217), heroCA.name))
    local isEaten = PlayerData.ServerData.user_home_info.meal_info.meal_eaten[tostring(info.id)] ~= nil
    loveGroup.Group_Tire.Txt_Energy:SetText(isEaten and -(ca.energy + riseBentoEnergy) or "-?")
    local letterBG = loveGroup.Img_LetterBG
    letterBG.Img_PicBg.Img_Avatar:SetSprite(PlayerData:GetFactoryData(heroCA.skinList[1].unitViewId).face)
    letterBG.Txt_Content:SetText(heroCA.FoodList[1].letter)
    letterBG.Txt_Name:SetText(heroCA.name)
    BtnUse:SetActive(true)
    imgUse.self:SetActive(false)
  end
  group.Btn_Use:SetClickParam(idx)
  self.lastDetailIdx = self.curDetailIdx
  self.curDetailIdx = idx
  View.ScrollGrid_FoodList.grid.self:RefreshAllElement()
end

function Controller:UpdateGroupTime(idx)
  local info = DataModel.foodList[idx]
  if info.free and (info.used or not self:IsArrive(idx)) then
    local nextTime = self:GetRefreshStampByIndex(idx)
    local timeTable = TimeUtil:SecondToTable(nextTime - TimeUtil:GetServerTimeStamp())
    print(timeTable.hour)
    print(timeTable.minute)
    View.Group_Description.Group_FreeOrder.Group_Time.Txt_Time:SetText(string.format("%02d:%02d", timeTable.hour, timeTable.minute))
  end
end

function Controller:GetRefreshStampByIndex(idx)
  local info = DataModel.foodList[idx]
  local refreshTime = info.refreshTime
  local h = tonumber(string.sub(refreshTime, 1, 2))
  local m = tonumber(string.sub(refreshTime, 4, 5))
  local s = tonumber(string.sub(refreshTime, 7, 8))
  return TimeUtil:GetNextSpecialTimeStamp(h, m, s)
end

function Controller:IsArrive(idx)
  local info = DataModel.foodList[idx]
  if not info.free then
    return true
  end
  if info.used then
    return true
  end
  local curTime = PlayerData:GetSeverTime()
  if curTime < TimeUtil:GetFutureTime(0, 5) then
    return true
  end
  local refreshTime = info.refreshTime
  local h = tonumber(string.sub(refreshTime, 1, 2))
  local m = tonumber(string.sub(refreshTime, 4, 5))
  local s = tonumber(string.sub(refreshTime, 7, 8))
  return TimeUtil:GetNextSpecialTimeStamp(h, m, s, TimeUtil:GetFutureTime(0, 0)) <= TimeUtil:GetServerTimeStamp()
end

function Controller:DayRefresh()
  Net:SendProto("meal.info", function(json)
    local oldMealInfo = PlayerData:GetHomeInfo().meal_info
    local newMealInfo = json.meal_info
    if oldMealInfo and newMealInfo then
      local oldBoxMeal = oldMealInfo.box_meal or {}
      local newBoxMeal = newMealInfo.box_meal or {}
      for k, v in pairs(oldBoxMeal) do
        if newBoxMeal[k] == nil then
          PlayerData:ClearLoveBentoClicked(k)
        end
      end
    end
    PlayerData:GetHomeInfo().meal_info = json.meal_info
    DataModel.InitData()
    Controller:Init()
  end)
end

function Controller.PlayFoodAnim(heroId, info, lastHomeEnergy)
  local ca = info.ca
  MainUIController:HideAll(true)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local animList = homeConfig.playerEatAni
  local funcList = {}
  for i = #animList, 1, -1 do
    local cb
    if i == #animList then
      function cb()
        UIManager:ClosePanel(true, "UI/CityStore/StoreSkip")
        
        UIManager:Open("UI/HomeFurniture/HomeFoodSettlement", Json.encode({
          foodEnergy = ca.energy + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseBentoEnergy),
          curEnergy = DataModel.curHomeEnergy,
          lastHomeEnergy = lastHomeEnergy,
          hid = info.hid,
          mealId = info.uid,
          isOutside = DataModel.isOutside
        }))
      end
    elseif i == #animList - 1 then
      function cb()
        HomeManager:ShowEffect(true)
        
        funcList[i + 1]()
      end
    else
      cb = funcList[i + 1]
    end
    if DataModel.isOutside then
      cb()
      return
    end
    funcList[i] = function()
      HomeManager:PlayGenerAnim(animList[i].animation, cb)
    end
  end
  local homeCfg = PlayerData:GetFactoryData(99900014)
  local gender = PlayerData:GetUserInfo().gender == 1 and homeCfg.conductorM or homeCfg.conductorW
  HomeManager:SetFoodPath(homeConfig.eatPrefab)
  HomeManager:SetFastFoodCam(gender, tonumber(heroId))
  HomeManager:PlayGenerAnim(animList[1].animation, funcList[1])
  HomeManager:PlayTempAnim(homeConfig.memberEatAni)
  UIManager:Open("UI/CityStore/StoreSkip")
  local skipDataModel = require("UIStoreSkip/UIStoreSkipDataModel")
  skipDataModel:SetCallBack(function()
    HomeManager:PauseGenerAnim()
    HomeManager:PauseTempAnim()
    UIManager:Open("UI/HomeFurniture/HomeFoodSettlement", Json.encode({
      foodEnergy = ca.energy + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseBentoEnergy),
      curEnergy = DataModel.curHomeEnergy,
      lastHomeEnergy = lastHomeEnergy,
      hid = info.hid,
      mealId = info.uid,
      isOutside = DataModel.isOutside
    }))
  end)
end

function Controller.InitFoodCook()
  if PlayerData:GetHomeInfo().meal_info and PlayerData:GetHomeInfo().meal_info.meal_hid and PlayerData:GetHomeInfo().meal_info.meal_hid ~= "" then
    local newHomeLiveDataModel = require("UINewHomeLive/UINewHomeLiveDataModel")
    if newHomeLiveDataModel.IsInEmergency(PlayerData:GetHomeInfo().meal_info.meal_hid) then
      return
    end
    local isLive = false
    for ufid, v in pairs(PlayerData:GetHomeInfo().furniture) do
      if v.roles then
        for _, id in ipairs(v.roles) do
          if id == PlayerData:GetHomeInfo().meal_info.meal_hid then
            isLive = true
            break
          end
        end
      end
    end
    if isLive then
      return
    end
    local unitCA = PlayerData:GetFactoryData(PlayerData:GetHomeInfo().meal_info.meal_hid, "UnitFactory")
    local homeCharacter = HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter))
    for ufid, v in pairs(PlayerData:GetHomeInfo().furniture) do
      if tonumber(v.id) == 81300014 then
        HomeCharacterManager:InitContinuousOp(homeCharacter, ufid, 0, -1)
        break
      end
    end
  end
end

return Controller
