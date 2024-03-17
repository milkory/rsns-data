local MainController = require("UIHomeSafe/UIHomeSafeController")
local MainDataModel = require("UIHomeSafe/UIHomeSafeDataModel")
local DataModel = require("UIHomeSafe/UIRewardDataModel")
local View = require("UIHomeSafe/UIHomeSafeView")
local Controller = {}

function Controller:ClickShowRewardPanel()
  Net:SendProto("building.level", function(json)
    DataModel.CurSelectIdx = 0
    DataModel.InitRewardLevels(json.special_level.reward_level)
    Controller:ShowRewardPanel()
    MainController:RefreshResource(2)
    MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.enterOfferText)
  end, MainDataModel.BuildingId)
end

function Controller:RefreshEmptyTimeTxt(remainTime)
  local t = TimeUtil:SecondToTable(remainTime)
  View.Group_XS.Group_Empty.Txt_Time:SetText(string.format("%02d:%02d:%02d", t.hour, t.minute, t.second))
end

function Controller:ShowRewardPanel()
  View.Group_Main.self:SetActive(false)
  View.Group_Zhu.self:SetActive(true)
  UIManager:LoadSplitPrefab(View, "UI/Home/HomeSafe/HomeSafe", "Group_Ding")
  View.Group_Ding.self:SetActive(true)
  UIManager:LoadSplitPrefab(View, "UI/Home/HomeSafe/HomeSafe", "Group_XS")
  if not View.Group_XS.self.IsActive then
    View.self:PlayAnim("XSList")
  end
  View.Group_XS.self:SetActive(true)
  View.Group_XS.Group_Tips.self:SetActive(false)
  local count = #DataModel.rewardLevels
  View.Group_XS.Group_Right.self:SetActive(true)
  View.Group_XS.Group_Right.ScrollGrid_Right.grid.self:MoveToTop()
  View.Group_XS.Group_Right.ScrollGrid_Right.grid.self:SetDataCount(count + 1)
  View.Group_XS.Group_Right.ScrollGrid_Right.grid.self:RefreshAllElement()
  Controller:RefreshLeftShow(true)
end

function Controller:RefreshLeftShow(isDefaultSelected)
  local count = #DataModel.rewardLevels
  local ShowEmpty = count == 0
  View.Group_XS.Group_Empty.self:SetActive(ShowEmpty)
  View.Group_XS.Group_Information.self:SetActive(not ShowEmpty)
  if ShowEmpty then
    View.Group_XS.Group_Empty.Txt_Num:SetText(DataModel.CurRepInfo.offerAutoRefreshNum)
  elseif isDefaultSelected then
    Controller:SelectIdx(1)
  end
end

function Controller:RefreshRightElement(element, idx)
  local data = DataModel.rewardLevels[idx]
  local isHave = data ~= nil
  element.Group_Level.self:SetActive(isHave)
  element.Group_Add.self:SetActive(not isHave)
  if isHave then
    element.Group_Level.Btn_:SetClickParam(idx)
    local isSelected = idx == DataModel.CurSelectIdx
    local levelCA = PlayerData:GetFactoryData(data.id, "LevelFactory")
    local isNormal = levelCA.levelBgType == "Normal"
    element.Group_Level.Group_Off.self:SetActive(not isSelected)
    element.Group_Level.Group_On.self:SetActive(isSelected)
    if not isSelected then
      element.Group_Level.Group_Off.Img_Normal:SetActive(isNormal)
      element.Group_Level.Group_Off.Img_Hua:SetActive(not isNormal)
      element.Group_Level.Group_Off.Txt_Name:SetText(levelCA.levelName)
    else
      element.Group_Level.Group_On.Img_Normal:SetActive(isNormal)
      element.Group_Level.Group_On.Img_Hua:SetActive(not isNormal)
      element.Group_Level.Group_On.Txt_Name:SetText(levelCA.levelName)
    end
  else
    element.Group_Add.Btn_:SetClickParam(idx)
  end
end

function Controller:SelectIdx(idx, force)
  if not force and DataModel.CurSelectIdx == idx then
    return
  end
  local data = DataModel.rewardLevels[idx]
  if data ~= nil then
    DataModel.CurSelectIdx = idx
    local levelCA = PlayerData:GetFactoryData(data.id, "LevelFactory")
    local starInt = levelCA.levelStarInt + 1
    View.Group_XS.Group_Information.Img_Bg:SetSprite(string.format(DataModel.StarBgPath, levelCA.levelStar))
    View.Group_XS.Group_Information.Group_Enemy.Img_EnemyBg:SetSprite(string.format(DataModel.EnemyBgPath, levelCA.levelStar))
    local element = View.Group_XS.Group_Information.Group_Top.Group_1.Group_Star
    for i = 1, 5 do
      element["Img_Star" .. i]:SetActive(starInt >= i)
    end
    View.Group_XS.Group_Information.ScrollView_Describe.Viewport.Txt_Describe:SetText(levelCA.description)
    local unitCA = PlayerData:GetFactoryData(data.bossId, "UnitFactory")
    local unitViewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
    element = View.Group_XS.Group_Information.Group_Enemy
    element.Img_Mask.Img_EnemyIcon:SetSprite(unitViewCA.face)
    element.Txt_Name:SetText(unitCA.name)
    element.ScrollView_Describe.Viewport.Txt_Describe:SetText(unitCA.safeInformation)
    DataModel.CurShowDrop = PlayerData:GetLevelDropList(levelCA)
    local count = #DataModel.CurShowDrop
    if count <= 6 then
      View.Group_XS.Group_Information.Group_Reward.ScrollGrid_Reward.self:SetEnable(false)
      View.Group_XS.Group_Information.Group_Reward.ScrollGrid_Reward.grid.self:SetStartCorner("Center")
    else
      View.Group_XS.Group_Information.Group_Reward.ScrollGrid_Reward.self:SetEnable(true)
      View.Group_XS.Group_Information.Group_Reward.ScrollGrid_Reward.grid.self:SetStartCorner("Left")
    end
    View.Group_XS.Group_Information.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(#DataModel.CurShowDrop)
    View.Group_XS.Group_Information.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
    local level = PlayerData:GetPlayerLevel()
    if not levelCA.isEnemyLvEquilsPlayer then
      level = levelCA.recomGrade
    end
    View.Group_XS.Group_Information.Img_Tuijian.Txt_Grade:SetText(level)
    View.Group_XS.Group_Information.Group_TZ.Txt_Cost:SetText(levelCA.energyEnd)
    View.Group_XS.Group_Information.Group_TZ.Btn_QW.self:SetClickParam(data.id)
    View.Group_XS.Group_Right.ScrollGrid_Right.grid.self:RefreshAllElement()
  elseif 0 < idx then
    Controller:AddRewardLevel()
  end
end

function Controller:AddRewardLevel()
  local buildingCA = PlayerData:GetFactoryData(MainDataModel.BuildingId, "BuildingFactory")
  if #buildingCA.offerQuestList == 0 then
    CommonTips.OpenTips(80601097)
    return
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if #DataModel.rewardLevels >= homeConfig.offerQuestMax then
    CommonTips.OpenTips(80601098)
    return
  end
  local info = homeConfig.moneyList[1]
  local itemCA = PlayerData:GetFactoryData(info.id, "ItemFactory")
  local param = {}
  param.itemId = info.id
  param.itemNum = PlayerData:GetGoodsById(param.itemId).num or 0
  param.useNum = info.num
  CommonTips.OnItemPrompt(string.format(GetText(80601014), itemCA.name), param, function()
    if param.itemNum < info.num then
      CommonTips.OpenTips(80600488)
      return
    end
    local t = {}
    t[param.itemId] = param.useNum
    Net:SendProto("building.reward_level", function(json)
      PlayerData:RefreshUseItems(t)
      DataModel.CurSelectIdx = 0
      DataModel.InitRewardLevels(json.reward_level)
      MainController:RefreshResource(2)
      Controller:ShowRewardPanel()
    end, MainDataModel.BuildingId)
  end)
end

return Controller
