local View = require("UIGachaNew/UIGachaNewView")
local DataModel = require("UIGachaNew/UIGachaNewDataModel")
local Controller = require("UIGachaNew/UIGachaNewController")
local soundTrain, soundMark
local PlaySoundMark = function()
  local tSoundId
  local tBGMConfig = PlayerData:GetFactoryData(99900002, "ConfigFactory")
  if tBGMConfig ~= nil then
    tSoundId = tBGMConfig.gaizhang
    if tSoundId ~= nil then
      soundMark = SoundManager:CreateSound(tSoundId)
      if soundMark ~= nil then
        soundMark:Play()
      end
    end
  end
end
local StopSoundMark = function()
  if soundMark ~= nil and soundMark.audioSource ~= nil then
    soundMark:Stop()
  end
end
local PlaySoundTrain = function()
  local tSoundId
  local tBGMConfig = PlayerData:GetFactoryData(99900002, "ConfigFactory")
  if tBGMConfig ~= nil then
    tSoundId = tBGMConfig.huoche
    if tSoundId ~= nil then
      soundTrain = SoundManager:CreateSound(tSoundId)
      if soundTrain ~= nil then
        soundTrain:Play()
      end
    end
  end
end
local StopSoundTrain = function()
  if soundTrain ~= nil and soundTrain.audioSource ~= nil then
    soundTrain:Stop()
  end
end
local GetCardData = function(json)
  local cards = {}
  for k, v in pairs(json.new_hero) do
    local isNew = false
    if json.reward and json.reward.role and json.reward.role[v] then
      isNew = true
    end
    table.insert(cards, {id = v, isNew = isNew})
  end
  local contain = {}
  for i, v in pairs(cards) do
    if contain[v.id] == 1 then
      v.isNew = false
    else
      contain[v.id] = 1
    end
  end
  print_r(json.reward.role)
  print_r(cards)
  return cards
end
local RecruitFlow = {}
local InitRecruitFlow = function()
  RecruitFlow.resource_cost = nil
  RecruitFlow.star_cnt3 = 0
  RecruitFlow.star_cnt4 = 0
  RecruitFlow.star_cnt5 = 0
  RecruitFlow.recruit_result = nil
  RecruitFlow.event_seq = nil
end
local SetHero = function(params)
  for k, v in pairs(params) do
    local ca = PlayerData:GetFactoryData(v)
    local hero_list = {}
    hero_list.hero_id = ca.id
    hero_list.hero_name = ca.name
    hero_list.event_seq = RecruitFlow.event_seq
    hero_list.get_times = PlayerData:GetSeverTime()
    hero_list.reason = "drawcard"
    ReportTrackEvent.hero_get(hero_list)
    SdkReporter.TrackGetCharacter(hero_list)
    if ca.qualityInt + 1 == 3 then
      RecruitFlow.star_cnt3 = RecruitFlow.star_cnt3 + 1
    end
    if ca.qualityInt + 1 == 4 then
      RecruitFlow.star_cnt4 = RecruitFlow.star_cnt4 + 1
    end
    if ca.qualityInt + 1 == 5 then
      RecruitFlow.star_cnt5 = RecruitFlow.star_cnt5 + 1
    end
  end
  RecruitFlow.recruit_result = "recruit_result:" .. Json.encode(params)
end
local ViewFunction = {
  GachaNew_NewPage_PoolList_SetPageNew = function(element, elementIndex)
    local data = DataModel.CardPool[elementIndex].data
    print_r(data)
    if data.imageList and #data.imageList > 0 then
      for i = 1, 6 do
        local img = element.Group_Card.Group_Middle.Img_Mask["Group_C" .. i].Img_C
        if i <= #data.imageList then
          img:SetSprite(data.imageList[i].image)
          img:SetLocalPosition(Vector3(data.imageList[i].x, data.imageList[i].y, 0))
          img:SetLocalScale(Vector3(data.imageList[i].scale, data.imageList[i].scale, 1))
        end
        img:SetActive(i <= #data.imageList)
      end
    else
      element.Group_Card.Group_Middle.Img_Mask.Group_C1.Img_C:SetActive(false)
      element.Group_Card.Group_Middle.Img_Mask.Group_C2.Img_C:SetActive(false)
    end
    for i = 1, 6 do
      local btn = element.Group_Card.Group_Middle.Img_Mask["Group_Info" .. i].Btn_Info
      btn.self:SetActive(i <= #data.btnList)
      if i <= #data.btnList then
        local cfg = PlayerData:GetFactoryData(data.btnList[i].id)
        btn.Txt_Name:SetText(cfg.name)
        btn.Txt_Name.Group_Pos.Img_Quality:SetSprite(UIConfig.RoleQuality[cfg.qualityInt])
        btn.self:SetLocalPosition(Vector3(data.btnList[i].x, data.btnList[i].y, 0))
      end
    end
    for i = 1, 6 do
      local btn = element.Group_Card.Group_Front["Group_Try" .. i].Btn_Try
      local isActive = i <= #data.tryList
      btn.self:SetActive(isActive)
      if isActive then
        btn.self:SetLocalPosition(Vector3(data.tryList[i].x, data.tryList[i].y, 0))
        btn.self:SetClickParam(data.tryList[i].levelId)
      end
    end
    local isNewbie = DataModel.CardPool[elementIndex].data.isNewbie
    element.Group_Card.Group_Front.Group_Basic.self:SetActive(isNewbie ~= true)
    element.Group_Card.Group_Front.Group_Newbie.self:SetActive(isNewbie == true)
    local extractCA = PlayerData:GetFactoryData(data.id)
    if extractCA.titlePath then
      element.Group_Card.Group_Front.Group_Name.Img_Name:SetSprite(extractCA.titlePath)
      element.Group_Card.Group_Front.Group_Name.Img_Name:SetAnchoredPosition(Vector2(extractCA.titleX, extractCA.titleY))
    end
    if isNewbie then
      Controller:SetNewbiePage(element, elementIndex)
    else
      Controller:SetBasicPage(element, elementIndex)
    end
  end,
  GachaNew_NewPage_PoolList_PageNewDrag = function(direction, dragPos)
    local pageController = View.NewPage_PoolList.self.pageNewController
    local poolWidth = pageController.CellSize.x
    local curPos = pageController.ScrollRect.content.anchoredPosition.x
    local nextIndex
    local nowIndex = DataModel.BgIndex or DataModel.Index
    if -poolWidth * (nowIndex - 1) - curPos < 0 then
      nextIndex = nowIndex - 1
    else
      nextIndex = nowIndex + 1
    end
    local distance = math.abs(-poolWidth * (nextIndex - 1) - curPos)
    if distance / poolWidth < 0.05 then
      View.Img_BG:SetSprite(DataModel.CardPool[nextIndex].data.imageBg)
      DataModel.BgIndex = nextIndex
    end
  end,
  GachaNew_NewPage_PoolList_PageNewDragComplete = function(index)
    Controller:RefreshTab(index + 1)
  end,
  GachaNew_NewPage_PoolList_PageNewDragBegin = function(dragOffsetPos)
  end,
  GachaNew_Group_Currency_Group_Onepull_Btn_Buy_Click = function(btn, str)
    local a, b = PlayerData:OpenStoreCondition()
    if a == false then
      CommonTips.OpenTips(b[1].txt)
      return
    end
    Net:SendProto("shop.info", function(json)
      UIManager:Open("UI/Store/Store", Json.encode(json))
    end)
  end,
  GachaNew_Group_Currency_Group_Tenpulls_Btn_Buy_Click = function(btn, str)
    local a, b = PlayerData:OpenStoreCondition()
    if a == false then
      CommonTips.OpenTips(b[1].txt)
      return
    end
    Net:SendProto("shop.info", function(json)
      UIManager:Open("UI/Store/Store", Json.encode(json))
    end)
  end,
  GachaNew_Group_Currency_Group_Diamond_Btn_Buy_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  GachaNew_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoBack()
  end,
  GachaNew_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoHome()
  end,
  GachaNew_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  GachaNew_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  GachaNew_Group_BuyItem_Btn_BG_Click = function(btn, str)
    View.Group_BuyItem.self:SetActive(false)
  end,
  GachaNew_Group_BuyItem_Group_Middle_Group_Item1_Btn_Item_Click = function(btn, str)
  end,
  GachaNew_Group_BuyItem_Group_Middle_Group_Item2_Btn_Item_Click = function(btn, str)
  end,
  GachaNew_Group_BuyItem_Btn_Confirm_Click = function(btn, str)
    if not DataModel.IsEnough and DataModel.Price > DataModel.MoneyNum then
      local callback = function()
        CommonTips.OpenStoreBuy()
      end
      CommonTips.OnPrompt(80600147, GetText(80600068), GetText(80600067), callback)
    else
      local cb = function(json)
        View.Group_BuyItem.self:SetActive(false)
        InitRecruitFlow()
        RecruitFlow.resource_cost = "resource_cost:" .. Json.encode({
          [tostring(DataModel.CommodityId)] = 1
        })
        local poolId = DataModel.DataIDPool.id
        local drawNum = DataModel.GachaType == EnumDefine.DrawCard.One and 1 or 10
        Net:SendProto("recruit.do_recruit", function(json)
          local reward = json.reward
          local rewardList = DrawCardHelper.ConvertRewardTableToList(reward)
          local evtArgs = {
            reason = "drawcard",
            amount = DataModel.Price
          }
          GachaGV:SetLastTenPullPollId(poolId)
          SdkReporter.TrackUseDiamond(evtArgs)
          SdkReporter.TrackDrawCard(poolId, nil, drawNum, rewardList)
          PlayerData:RefreshUseItems(DataModel.DataIDPool.item)
          RecruitFlow.event_seq = "recruit.do_recruit"
          SetHero(json.new_hero)
          local cards = GetCardData(json)
          Controller:RefreshMain(DataModel.Index)
          local t
          if json.reward.material and table.count(json.reward.material) > 0 or json.reward.medal and 0 < table.count(json.reward.medal) or json.reward.item and table.count(json.reward.item) > 0 then
            t = {
              type = DataModel.GachaType,
              cards = cards,
              index = 1,
              material = {
                material = json.reward.material,
                medal = json.reward.medal,
                item = json.reward.item
              },
              poolId = DataModel.DataIDPool.id
            }
          else
            t = {
              type = DataModel.GachaType,
              cards = cards,
              index = 1,
              poolId = DataModel.DataIDPool.id
            }
          end
          local maxLv = 1
          for i, v in pairs(cards) do
            local detail = PlayerData:GetFactoryData(v.id, "UnitFactory")
            if maxLv < detail.qualityInt then
              maxLv = detail.qualityInt
            end
          end
          local UIShowCharacterDataModel = require("UIShowCharacter/UIShowCharacterDataModel")
          UIShowCharacterDataModel.isSkip = false
          DataModel.showCharacterData = t
          DataModel.Cards = cards
          View.Video_Gacha.self:SetActive(true)
          View.Video_Gacha.self:Play("Video/Gacha/Gacha0" .. maxLv, false, false, true, function()
            UIManager:Open("UI/ShowCharacter/ShowCharacter", Json.encode(t), nil, nil, false, true)
            StopSoundTrain()
          end)
          PlaySoundTrain()
        end, DataModel.DataIDPool.id, DataModel.GachaType == EnumDefine.DrawCard.One and 1 or 10)
      end
      if DataModel.IsEnough then
        cb()
      else
        Net:SendProto("shop.buy", function(json)
          cb(json)
        end, tostring(40300005), 1, DataModel.NeedNum, DataModel.CommodityId)
      end
    end
  end,
  GachaNew_Group_BuyItem_Btn_Cancel_Click = function(btn, str)
    View.Group_BuyItem.self:SetActive(false)
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Front_Btn_Details_Click = function(btn, str)
    local data = DataModel.CardPool[DataModel.Index].data
    UIManager:Open("UI/Gacha/GachaDetails", Json.encode({
      id = data.id
    }))
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Front_Group_Basic_Group_OnePull_BtnPolygon_OnePull_Click = function(btn, str)
    local index = tonumber(str)
    local cardPool = DataModel.CardPool[index]
    local data = cardPool.data
    local isFree = false
    if data.freeCD ~= 0 and cardPool.server and (not cardPool.server.free_last_countdown or TimeUtil:GetServerTimeStamp() >= tonumber(cardPool.server.free_last_countdown)) then
      isFree = true
    end
    local item = {}
    if isFree then
      InitRecruitFlow()
      RecruitFlow.resource_cost = "resource_cost:" .. Json.encode({
        [tostring(DataModel.CommodityId)] = 1
      })
      Net:SendProto("recruit.do_recruit", function(json)
        RecruitFlow.event_seq = "recruit.do_recruit"
        SetHero(json.new_hero)
        PlayerData.ServerData.cards[tostring(data.id)] = cardPool.server or {}
        PlayerData.ServerData.cards[tostring(data.id)].free_last_countdown = json.free_last_countdown
        local cards = GetCardData(json)
        Controller:RefreshMain(DataModel.Index)
        local t
        if json.reward.material and table.count(json.reward.material) > 0 or json.reward.medal and 0 < table.count(json.reward.medal) or json.reward.item and 0 < table.count(json.reward.item) then
          t = {
            type = EnumDefine.DrawCard.One,
            cards = cards,
            index = 1,
            material = {
              material = json.reward.material,
              medal = json.reward.medal,
              item = json.reward.item
            },
            poolId = data.id
          }
        else
          t = {
            type = EnumDefine.DrawCard.One,
            cards = cards,
            index = 1,
            poolId = data.id
          }
        end
        local maxLv = 1
        for i, v in pairs(cards) do
          local detail = PlayerData:GetFactoryData(v.id, "UnitFactory")
          if maxLv < detail.qualityInt then
            maxLv = detail.qualityInt
          end
        end
        local UIShowCharacterDataModel = require("UIShowCharacter/UIShowCharacterDataModel")
        UIShowCharacterDataModel.isSkip = false
        DataModel.showCharacterData = t
        DataModel.Cards = cards
        View.Video_Gacha.self:SetActive(true)
        View.Video_Gacha.self:Play("Video/Gacha/Gacha0" .. maxLv, false, false, true, function()
          UIManager:Open("UI/ShowCharacter/ShowCharacter", Json.encode(t), nil, nil, false, true)
          StopSoundTrain()
        end)
        PlaySoundTrain()
      end, data.id, 1)
    else
      Controller:ShowBuyItem(EnumDefine.DrawCard.One, data)
      return
    end
    DataModel.GachaType = EnumDefine.DrawCard.One
    DataModel.DataIDPool = {
      id = tostring(data.id),
      item = item
    }
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Front_Group_Basic_Group_TenPulls_BtnPolygon_TenPulls_Click = function(btn, str)
    local data = DataModel.CardPool[tonumber(str)].data
    Controller:ShowBuyItem(EnumDefine.DrawCard.Ten, data)
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Front_Group_Newbie_Btn_TenPulls_Click = function(btn, str)
    local data = DataModel.CardPool[tonumber(str)].data
    Controller:ShowBuyItem(EnumDefine.DrawCard.Ten, data)
  end,
  GachaNew_ScrollGrid_Tab_SetGrid = function(element, elementIndex)
    local data = DataModel.CardPool[elementIndex].data
    local btn = element.Btn_Tab
    btn:SetClickParam(elementIndex)
    btn.Txt_Name:SetText(data.tabName)
    btn.self:SetSprite(data.tabPath)
  end,
  GachaNew_ScrollGrid_Tab_Group_Tab_Btn_Tab_Click = function(btn, str)
    local elementIndex = tonumber(str)
    local isAnime = elementIndex ~= DataModel.Index
    View.NewPage_PoolList.grid.self:LocatElementImmediate(elementIndex - 1)
    if isAnime then
      Controller:PlayAnimeByIndex(elementIndex)
    end
  end,
  GachaNew_Video_Gacha_Btn_Skip_Click = function(btn, str)
    local UIShowCharacterDataModel = require("UIShowCharacter/UIShowCharacterDataModel")
    UIShowCharacterDataModel.isSkip = true
    View.Video_Gacha.self:VideoOver()
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Middle_Img_Mask_Group_Info1_Btn_Info_Click = function(btn, str)
    Controller:OpenSelectRoleTip(1)
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Middle_Img_Mask_Group_Info2_Btn_Info_Click = function(btn, str)
    Controller:OpenSelectRoleTip(2)
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Middle_Img_Mask_Group_Info3_Btn_Info_Click = function(btn, str)
    Controller:OpenSelectRoleTip(3)
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Middle_Img_Mask_Group_Info4_Btn_Info_Click = function(btn, str)
    Controller:OpenSelectRoleTip(4)
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Middle_Img_Mask_Group_Info5_Btn_Info_Click = function(btn, str)
    Controller:OpenSelectRoleTip(5)
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Middle_Img_Mask_Group_Info6_Btn_Info_Click = function(btn, str)
    Controller:OpenSelectRoleTip(6)
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Front_Group_Try1_Btn_Try_Click = function(btn, str)
    Controller:OpenTryLevel(tonumber(str))
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Front_Group_Try2_Btn_Try_Click = function(btn, str)
    Controller:OpenTryLevel(tonumber(str))
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Front_Group_Try3_Btn_Try_Click = function(btn, str)
    Controller:OpenTryLevel(tonumber(str))
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Front_Group_Try4_Btn_Try_Click = function(btn, str)
    Controller:OpenTryLevel(tonumber(str))
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Front_Group_Try5_Btn_Try_Click = function(btn, str)
    Controller:OpenTryLevel(tonumber(str))
  end,
  GachaNew_NewPage_PoolList_Group_CardPoolNew_Group_Card_Group_Front_Group_Try6_Btn_Try_Click = function(btn, str)
    Controller:OpenTryLevel(tonumber(str))
  end
}
return ViewFunction
