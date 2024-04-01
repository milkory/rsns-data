local PassData = require("UIBattlePass_Quest/UIBattlePass")
local QuestData = require("UIBattlePass_Quest/UIBattleQuest")
local View = require("UIBattlePass_Quest/UIBattlePass_QuestView")
local DataModel = {
  selectedIndex = nil,
  selectedRightIndex = nil,
  Resources = {},
  OldIndex = nil,
  OldGridIndex = 0
}
DataModel.InfoInitPos = {
  isRecord = true,
  x = 0,
  y = 0,
  scale = 1,
  offsetX = 0,
  offsetY = 1
}
local RefreshBuyTypePage = function()
  local bpPrice = DataModel.CA.bpPrice
  local Group_Price1 = View.Group_Pay.Group_Right.Group_Price1
  local Group_Price2 = View.Group_Pay.Group_Right.Group_Price2
  Group_Price2.Img_OwnedMask.self:SetActive(false)
  Group_Price1.Img_OwnedMask.self:SetActive(false)
  Group_Price2.Btn_Buy.self:SetActive(true)
  Group_Price1.Btn_Buy.self:SetActive(true)
  local price_1 = PlayerData:GetFactoryData(bpPrice[1].id).value
  local price_2 = PlayerData:GetFactoryData(bpPrice[2].id).value
  local price_3 = PlayerData:GetFactoryData(bpPrice[3].id).value
  Group_Price2.Btn_Buy.Txt_Price:SetText(string.format(GetText(80601069), price_2))
  Group_Price1.Btn_Buy.Txt_Price:SetText(string.format(GetText(80601069), price_1))
  local pass_type = PlayerData:GetBattlePass().pass_type
  if pass_type == 2 then
    Group_Price2.Img_OwnedMask.self:SetActive(true)
    Group_Price1.Img_OwnedMask.self:SetActive(true)
    Group_Price2.Btn_Buy.self:SetActive(false)
    Group_Price1.Btn_Buy.self:SetActive(false)
  end
  if pass_type == 1 then
    Group_Price1.Img_OwnedMask.self:SetActive(true)
    Group_Price1.Btn_Buy.self:SetActive(false)
    Group_Price2.Btn_Buy.Txt_Price:SetText(string.format(GetText(80601069), price_3))
  end
end

function DataModel.SwitchTable()
  View.Group_Reward_Quest.self:SetActive(true)
  View.Group_Pay.self:SetActive(false)
  View.Group_Reward_Quest.Group_BattlePass.self:SetActive(false)
  View.Group_Reward_Quest.Group_BattlePassQuest.self:SetActive(false)
  View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Bp.Group_Off.self:SetActive(false)
  View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Bp.Group_On.self:SetActive(false)
  View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Quest.Group_Off.self:SetActive(false)
  View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Quest.Group_On.self:SetActive(false)
  View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Bp.Img_Remind:SetActive(false)
  View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Quest.Img_Remind:SetActive(false)
  local row = PlayerData:GetBattlePassRedState()
  if DataModel.TableOutSideIndex == 1 then
    DOTweenTools.DOLocalMoveXCallback(View.Group_Reward_Quest.Group_Bottom.Img_BG.Img_selected.transform, -174, 0.25, function()
      View.Group_Reward_Quest.Group_BattlePass.self:SetActive(true)
      PassData.isFirst = true
      PassData.Init()
      View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Bp.Group_On.self:SetActive(true)
      View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Quest.Group_Off.self:SetActive(true)
      if row.count_2 == true or row.count_3 == true then
        View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Quest.Img_Remind:SetActive(true)
      end
    end)
  elseif DataModel.TableOutSideIndex == 2 then
    DOTweenTools.DOLocalMoveXCallback(View.Group_Reward_Quest.Group_Bottom.Img_BG.Img_selected.transform, 174, 0.25, function()
      View.Group_Reward_Quest.Group_BattlePassQuest.self:SetActive(true)
      QuestData.Init(DataModel)
      View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Bp.Group_Off.self:SetActive(true)
      View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Quest.Group_On.self:SetActive(true)
      QuestData.TableIndex = DataModel.SerializeList and DataModel.SerializeList.TableIndex or 1
      if row.count_1 == true then
        View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Bp.Img_Remind:SetActive(true)
      end
      QuestData.SwitchQuestTable()
    end)
  end
end

function DataModel.InitCommonData()
  local Group = View.Group_Reward_Quest.Group_Common
  Group.Group_Top.Txt_BpLevel:SetText(DataModel.Data.lv)
  local maxPoint = DataModel.CA.Points
  QuestData.maxPoint = maxPoint
  PassData.maxPoint = maxPoint
  Group.Group_Top.Img_BarBottom:SetActive(true)
  if DataModel.IsMaxLv then
    Group.Group_Top.Img_BarTop:SetFilledImgAmount(1)
    Group.Group_Top.Txt_Exp:SetText(maxPoint .. "/" .. maxPoint)
  else
    Group.Group_Top.Img_BarTop:SetFilledImgAmount(DataModel.Data.exp / maxPoint)
    Group.Group_Top.Txt_Exp:SetText(DataModel.Data.exp .. "/" .. maxPoint)
  end
  Group.Group_Top.Btn_PayForLevelUp.self:SetActive(true)
  if PlayerData:GetBattlePass().pass_level >= DataModel.CA.LevelLimit then
    Group.Group_Top.Btn_PayForLevelUp.self:SetActive(false)
  end
  Group.Group_Top.Img_LevelBg:SetSprite(DataModel.CA.topicIcon)
end

function DataModel.AddData()
  DataModel.Data = {}
  DataModel.IsMaxLv = false
  local battlePass = PlayerData:GetBattlePass()
  DataModel.Data.lv = battlePass.pass_level
  if battlePass.pass_level >= DataModel.CA.LevelLimit then
    DataModel.IsMaxLv = true
    DataModel.Data.lv = DataModel.CA.LevelLimit
  end
  DataModel.Data.exp = battlePass.points
end

function DataModel.RefreshData()
  DataModel.AddData()
  DataModel.InitCommonData()
  local row = PlayerData:GetBattlePassRedState()
  View.Group_Reward_Quest.Group_BattlePassQuest.Btn_Bp.Group_Off.Img_Off.Img_Remind:SetActive(false)
  View.Group_Reward_Quest.Group_BattlePassQuest.Btn_Quest.Group_Off.Img_Off.Img_Remind:SetActive(false)
  View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Quest.Img_Remind:SetActive(false)
  View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Bp.Img_Remind:SetActive(false)
  if DataModel.TableOutSideIndex == 1 then
    if row.count_2 == true or row.count_3 == true then
      View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Quest.Img_Remind:SetActive(true)
    end
  elseif DataModel.TableOutSideIndex == 2 and row.count_1 == true then
    View.Group_Reward_Quest.Group_Bottom.Img_BG.Btn_Bp.Img_Remind:SetActive(true)
  end
  if QuestData.TableIndex == 1 then
    if row.count_3 == true then
      View.Group_Reward_Quest.Group_BattlePassQuest.Btn_Quest.Group_Off.Img_Off.Img_Remind:SetActive(true)
    end
  elseif QuestData.TableIndex == 2 and row.count_2 == true then
    View.Group_Reward_Quest.Group_BattlePassQuest.Btn_Bp.Group_Off.Img_Off.Img_Remind:SetActive(true)
  end
end

function DataModel.Serialize()
  local status = {}
  status.TableOutSideIndex = DataModel.TableOutSideIndex
  status.TableIndex = QuestData.TableIndex
  status.UI = "BattlePass"
  status.URL = "UI/BP_Quest/BattlePass_Quest"
  status.OtherPage = DataModel.OtherPage
  return status
end

local isSpine2

function DataModel.CharacterLoad(isSkin2)
  if isSpine2 ~= nil and isSkin2 ~= nil and isSpine2 == isSkin2 then
    return
  end
  local Group_CharacterSkin = View.Group_CharacterSkin
  local receptionistData = PlayerData:GetFactoryData(DataModel.CA.skinThisSeason, "UnitViewFactory")
  isSpine2 = false
  if isSkin2 and isSkin2 == true then
    if receptionistData.spine2Url == nil or receptionistData.spine2Url == "" then
      DataModel.isSpine2 = not DataModel.isSpine2
      CommonTips.OpenTips("暂时没有精二例会  ^_^ ")
      return
    end
    isSpine2 = true
  end
  Group_CharacterSkin.SpineSecondMode_Character:SetActive(false)
  Group_CharacterSkin.SpineAnimation_Character:SetActive(false)
  Group_CharacterSkin.Img_BG:SetSprite(DataModel.CA.background)
  local spineUrl = receptionistData.spineUrl
  if spineUrl ~= nil and spineUrl ~= "" then
    Group_CharacterSkin.SpineAnimation_Character:SetActive(true)
    Group_CharacterSkin.SpineAnimation_Fade:SetActive(true)
    Group_CharacterSkin.SpineAnimation_Character:SetActive(not isSpine2)
    Group_CharacterSkin.SpineSecondMode_Character:SetActive(isSpine2)
    if isSpine2 then
      spineUrl = receptionistData.spine2Url
      Group_CharacterSkin.SpineSecondMode_Character:SetPrefab(spineUrl)
      Group_CharacterSkin.SpineAnimation_Character:SetData("")
    else
      View.Group_BuyLevel.self:SetActive(false)
      Group_CharacterSkin.SpineSecondMode_Character:SetActive(false)
      Group_CharacterSkin.SpineSecondMode_Character:SetPrefab("")
      Group_CharacterSkin.SpineAnimation_Character:SetActive(true)
      Group_CharacterSkin.SpineAnimation_Character:SetData(spineUrl)
      local CA = DataModel.CA
      Group_CharacterSkin.SpineAnimation_Character:SetLocalScale(Vector3(CA.SpineScale, CA.SpineScale, 1))
      Group_CharacterSkin.SpineAnimation_Character.Img_BG:SetActive(false)
      if CA.SpineBackground ~= "" then
        Group_CharacterSkin.SpineAnimation_Character.Img_BG:SetActive(true)
        Group_CharacterSkin.SpineAnimation_Character.Img_BG:SetSprite(CA.SpineBackground)
        Group_CharacterSkin.SpineAnimation_Character.Img_BG.transform.localPosition = Vector3(CA.SpineBGX, CA.SpineBGY, 0)
      end
      Group_CharacterSkin.SpineAnimation_Character.transform.localPosition = Vector3(CA.SpineX, CA.SpineY, 0)
    end
  end
end

function DataModel.Init()
  View.self:PlayAnim("BP")
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  DataModel.CA = PlayerData:GetFactoryData(initConfig.BattlePassId, "BattlePassFactory")
  DataModel.BuyCAList = {
    [0] = "82100009",
    [1] = "82100018",
    [2] = "82100019"
  }
  DataModel.OtherPage = nil
  DataModel.CharacterLoad()
  View.Group_Reward_Quest.Group_Common.Group_Left.Txt_Title2:SetText(DataModel.CA.topicName)
  DataModel.RefreshData()
  PassData.PassRewardList = DataModel.CA.PassRewardList
  DataModel.WeekQuest = DataModel.CA.weekQuest
  DataModel.TableOutSideIndex = DataModel.SerializeList and DataModel.SerializeList.TableOutSideIndex or 1
  DataModel.SwitchTable()
  if DataModel.SerializeList and DataModel.SerializeList.OtherPage ~= nil and DataModel.SerializeList.OtherPage == 1 then
    DataModel.ClickPayPage()
    View.self:PlayAnim("buyBpIn")
  end
end

function DataModel.ClickPayPage()
  DataModel.OtherPage = 1
  DataModel.isSpine2 = false
  UIManager:LoadSplitPrefab(View, "UI/BP_Quest/BattlePass_Quest", "Group_Pay", true)
  View.Group_Pay.self:SetActive(true)
  View.Group_Reward_Quest.self:SetActive(false)
  local CA = DataModel.CA
  local Group_Pay = View.Group_Pay
  local Group_LeftBottom = Group_Pay.Group_LeftBottom
  Group_LeftBottom.Img_BpIcon:SetSprite(CA.skinIcon)
  Group_LeftBottom.Img_Name:SetSprite(CA.skinNameIcon)
  Group_LeftBottom.Btn_State2.Txt_:SetText(GetText(80601192))
  Group_LeftBottom.Txt_Desc:SetText(GetText(80601193))
  local Group_Right = Group_Pay.Group_Right
  Group_Right.Group_Name.Img_NameIcon:SetSprite(CA.topicNameEN)
  Group_Right.Group_Name.Txt_Name:SetText(CA.topicName)
  local Group_TimeLeft = Group_Right.Group_TimeLeft
  Group_TimeLeft.Txt_TimeLeft:SetText(GetText(80601194))
  if PlayerData:GetUserInfo().gender == 1 then
    Group_Pay.Img_PlayerSkin:SetSprite(DataModel.CA.PlayerSkinM)
  else
    Group_Pay.Img_PlayerSkin:SetSprite(DataModel.CA.PlayerSkinF)
  end
  local bpPrice = CA.bpPrice
  local Group_Price1 = Group_Right.Group_Price1
  Group_Price1.Txt_Price1Name:SetText(bpPrice[1].bpName)
  Group_Price1.Txt_Price1Desc:SetText(GetText(80601189))
  Group_Price1.ScrollGrid_RewardShow.grid.self:SetDataCount(table.count(CA.rewardShow))
  Group_Price1.ScrollGrid_RewardShow.grid.self:RefreshAllElement()
  Group_Price1.Img_OwnedMask.self:SetActive(false)
  local Group_Price2 = Group_Right.Group_Price2
  Group_Price2.Txt_Price2Name:SetText(bpPrice[2].bpName)
  Group_Price2.Txt_Price2Desc1:SetText(GetText(80601190))
  Group_Price2.Txt_Price2Desc2:SetText(GetText(80601191))
  DataModel.ExtraReward = {}
  DataModel.ExtraReward.Item = {}
  for k, v in pairs(CA.extraReward) do
    DataModel.ExtraReward.Item[tostring(v.id)] = {}
    DataModel.ExtraReward.Item[tostring(v.id)].num = v.num
  end
  Group_Price2.ScrollGrid_RewardShow.grid.self:SetDataCount(table.count(CA.extraReward))
  Group_Price2.ScrollGrid_RewardShow.grid.self:RefreshAllElement()
  RefreshBuyTypePage()
end

function DataModel.OpenBuyLevel()
  DataModel.OtherPage = 2
  UIManager:LoadSplitPrefab(View, "UI/BP_Quest/BattlePass_Quest", "Group_BuyLevel", true)
  View.Group_BuyLevel.self:SetActive(true)
  local Group_BuyLevel = View.Group_BuyLevel
  Group_BuyLevel.Txt_title:SetText(GetText(80601203))
  Group_BuyLevel.Group_Left.Txt_UpToLv:SetText(string.format(GetText(80601204), 34))
  Group_BuyLevel.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
  Group_BuyLevel.Img_TipsBg.Img_LeftBot.Txt_CurrentLvNum:SetText(DataModel.Data.lv)
  DataModel.EndLv = PlayerData:GetBattlePass().pass_level + 1
  DataModel.isPay = false
  DataModel.ConsumeNum = DataModel.CA.purchaseBPLevel[1].num
  DataModel.LevelList = {}
  for i = DataModel.CA.LevelLimit, DataModel.EndLv, -1 do
    table.insert(DataModel.LevelList, {txt = i})
  end
  DataModel.RefreshLeftInfo()
  Group_BuyLevel.Group_Right.Img_LvBg.Page_Level.grid.self:SetDataCount(#DataModel.LevelList)
  Group_BuyLevel.Group_Right.Img_LvBg.Page_Level.grid.self:RefreshAllElement()
  if #DataModel.LevelList > 0 then
    Group_BuyLevel.Group_Right.Img_LvBg.Page_Level.grid.self:LocatElementImmediate(#DataModel.LevelList - 1)
  end
end

function DataModel.RefreshLeftInfo()
  DataModel.Price = 0
  local Group_BuyLevel = View.Group_BuyLevel
  DataModel.PassRewardList = {}
  local list = {}
  local count = 0
  for i = PlayerData:GetBattlePass().pass_level + 1, DataModel.EndLv do
    if DataModel.CA.PassRewardList[i] then
      local row = DataModel.CA.PassRewardList[i]
      count = count + 1
      local id, id_2, num, num_2
      id = row.freeID
      num = row.freeNum
      if list[id] == nil then
        list[id] = {}
        list[id] = num
      else
        list[id] = list[id] + num
      end
      if PlayerData:GetBattlePass().pass_type ~= 0 then
        id_2 = row.upgradeID
        num_2 = row.upgradeNum
        if list[id_2] == nil then
          list[id_2] = {}
          list[id_2] = num_2
        else
          list[id_2] = list[id_2] + num_2
        end
      end
    end
  end
  for k, v in pairs(list) do
    table.insert(DataModel.PassRewardList, {id = k, num = v})
  end
  Group_BuyLevel.Group_Left.Img_Bg.ScrollGrid_Reward.grid.self:SetDataCount(table.count(DataModel.PassRewardList))
  Group_BuyLevel.Group_Left.Img_Bg.ScrollGrid_Reward.grid.self:RefreshAllElement()
  DataModel.Price = DataModel.ConsumeNum * count
  Group_BuyLevel.Group_Left.Txt_CostNum:SetText(DataModel.Price)
  Group_BuyLevel.Group_Left.Txt_CostNum:SetColor("#FFFFFF")
  if PlayerData:GetGoodsById(11400005).num < DataModel.Price then
    Group_BuyLevel.Group_Left.Txt_CostNum:SetColor("#FF0808")
  end
  Group_BuyLevel.Group_Left.Txt_UpToLv:SetText(string.format(GetText(80601204), DataModel.EndLv))
end

function DataModel.GetShopID(index)
  local shopID
  if index == 1 then
    if PlayerData:GetBattlePass().pass_type == 0 then
      shopID = DataModel.BuyCAList[2]
    else
      shopID = DataModel.BuyCAList[0]
    end
  else
    shopID = DataModel.BuyCAList[1]
  end
  return shopID
end

function DataModel.BuyBp(index)
  local typeIndex = index
  local shopID = DataModel.GetShopID(typeIndex)
  local metaId = shopID
  local factoryData = PlayerData:GetFactoryData(metaId)
  local name = factoryData.name
  local payAmount = factoryData.value
  local priceStr = string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(factoryData.value, 2))
  local uiParams = Json.encode({
    name = name,
    price = priceStr,
    itemId = metaId,
    shopId = metaId,
    payAmount = payAmount
  })
  if typeIndex == 1 and PlayerData:GetBattlePass().pass_type == 1 then
    typeIndex = 2
  end
  local callback = function(json)
    CommonTips.OpenTips(80601249)
    PlayerData:GetBattlePass().pass_type = index + 1
    if typeIndex == 1 and PlayerData:GetBattlePass().pass_level > DataModel.CA.LevelLimit then
      PlayerData:GetBattlePass().pass_level = DataModel.CA.LevelLimit
    end
    CommonTips.OpenShowItem(json.reward)
    RefreshBuyTypePage()
  end
  if not PayHelper.IsPayPlatformDefault() then
    PayHelper.Buy(metaId, function(json)
      pcall(callback, json)
    end, uiParams)
    return
  end
  Net:SendProto("battle_pass.buy", function(json)
    pcall(callback, json)
  end, typeIndex)
end

function DataModel.Clear()
  PassData.Clear()
  QuestData.Clear()
end

return DataModel
