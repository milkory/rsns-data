local View = require("UIGacha/UIGachaView")
local DataModel = require("UIGacha/UIGachaDataModel")
local Controller = require("UIGacha/UIGachaController")
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
  for k, v in pairs(json.new_hero.role) do
    local isNew = false
    if json.reward and json.reward.role and json.reward.role[k] then
      isNew = true
    end
    for i = 1, v.num do
      table.insert(cards, {id = k, isNew = isNew})
    end
  end
  for i = #cards, 1, -1 do
    local index = math.random(1, #cards)
    cards[i], cards[index] = cards[index], cards[i]
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
    local ca = PlayerData:GetFactoryData(k)
    local hero_list = {}
    hero_list.hero_id = ca.id
    hero_list.hero_name = ca.name
    hero_list.event_seq = RecruitFlow.event_seq
    hero_list.get_times = PlayerData:GetSeverTime()
    ReportTrackEvent.hero_get(hero_list)
    if ca.qualityInt + 1 == 3 then
      RecruitFlow.star_cnt3 = RecruitFlow.star_cnt3 + v.num
    end
    if ca.qualityInt + 1 == 4 then
      RecruitFlow.star_cnt4 = RecruitFlow.star_cnt4 + v.num
    end
    if ca.qualityInt + 1 == 5 then
      RecruitFlow.star_cnt5 = RecruitFlow.star_cnt5 + v.num
    end
  end
  RecruitFlow.recruit_result = "recruit_result:" .. Json.encode(params)
end
local TimeFree = function(timeTable)
  if timeTable.hour > 0 then
    return string.format(GetText(80600002), timeTable.hour, timeTable.minute)
  end
  if 0 < timeTable.minute then
    return string.format(GetText(80600003), timeTable.minute)
  end
  if 0 < timeTable.second then
    return string.format(GetText(80600004), timeTable.second)
  end
  return "0"
end
local ViewFunction = {
  Gacha_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoBack()
  end,
  Gacha_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoHome()
  end,
  Gacha_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Gacha_Group_Currency_Group_Tenpulls_Btn_Buy_Click = function(btn, str)
    local a, b = PlayerData:OpenStoreCondition()
    if a == false then
      CommonTips.OpenTips(b[1].txt)
      return
    end
    Net:SendProto("shop.info", function(json)
      UIManager:Open("UI/Store/Store", Json.encode(json))
    end)
  end,
  Gacha_Group_Currency_Group_Onepull_Btn_Buy_Click = function(btn, str)
    local a, b = PlayerData:OpenStoreCondition()
    if a == false then
      CommonTips.OpenTips(b[1].txt)
      return
    end
    Net:SendProto("shop.info", function(json)
      UIManager:Open("UI/Store/Store", Json.encode(json))
    end)
  end,
  Gacha_Group_Currency_Group_Diamond_Btn_Buy_Click = function(btn, str)
    local a, b = PlayerData:OpenStoreCondition()
    if a == false then
      CommonTips.OpenTips(b[1].txt)
      return
    end
    Net:SendProto("shop.info", function(json)
      UIManager:Open("UI/Store/Store", Json.encode(json))
    end)
  end,
  Gacha_Group_Tab_StaticGrid_Tab_SetGrid = function(element, elementIndex)
  end,
  Gacha_Btn_Previous_Click = function(btn, str)
    local currIndex = DataModel.Index - 1
    local realIndex = currIndex <= 0 and 1 or currIndex
    View.Page_PoolList.grid.self:LocatElementImmediate(realIndex - 1)
  end,
  Gacha_Btn_Next_Click = function(btn, str)
    local currIndex = DataModel.Index + 1
    local totalIndex = #DataModel.CardPool
    local realIndex = currIndex >= totalIndex and totalIndex or currIndex
    View.Page_PoolList.grid.self:LocatElementImmediate(realIndex - 1)
  end,
  Gacha_Group_Sign_Group_Change_Btn_Change_Click = function(btn, str)
    View.self:PlayAnim("Seal", function()
      if DataModel.GachaType == EnumDefine.DrawCard.One then
        Net:SendProto("recruit.do_recruit", function(json)
          PlayerData:RefreshUseItems(DataModel.DataIDPool.item)
          RecruitFlow.event_seq = "recruit.do_recruit"
          SetHero(json.new_hero.role)
          local cards = GetCardData(json)
          Controller:RefreshMain(DataModel.Index)
          local t
          if table.count(json.reward.material) > 0 then
            t = {
              type = EnumDefine.DrawCard.One,
              cards = cards,
              index = 1,
              material = {
                material = json.reward.material
              }
            }
          else
            t = {
              type = EnumDefine.DrawCard.One,
              cards = cards,
              index = 1
            }
          end
          local maxLv = 1
          for i, v in pairs(cards) do
            local detail = PlayerData:GetFactoryData(v.id, "UnitFactory")
            if maxLv < detail.qualityInt then
              maxLv = detail.qualityInt
            end
          end
          local DataModel = require("UIShowCharacter/UIShowCharacterDataModel")
          DataModel.isSkip = false
          View.Video_Gacha.self:SetActive(true)
          View.Video_Gacha.self:Play("Video/Gacha/Gacha0" .. maxLv, false, false, true, function()
            UIManager:Open("UI/ShowCharacter/ShowCharacter", Json.encode(t), nil, nil, false, true)
            View.Group_Sign:SetActive(false)
            StopSoundTrain()
          end)
          PlaySoundTrain()
        end, DataModel.DataIDPool.id, 1, function(json)
          View.Group_Sign:SetActive(false)
        end)
      else
        Net:SendProto("recruit.do_recruit", function(json)
          RecruitFlow.event_seq = "recruit.do_recruit"
          PlayerData:RefreshUseItems(DataModel.DataIDPool.item)
          SetHero(json.new_hero.role)
          local cards = GetCardData(json)
          for i = #cards, 1, -1 do
            local index = math.random(1, #cards)
            cards[i], cards[index] = cards[index], cards[i]
          end
          Controller:RefreshMain(DataModel.Index)
          local t
          if table.count(json.reward.material) > 0 then
            t = {
              type = EnumDefine.DrawCard.Ten,
              cards = cards,
              index = 1,
              material = {
                material = json.reward.material
              }
            }
          else
            t = {
              type = EnumDefine.DrawCard.Ten,
              cards = cards,
              index = 1
            }
          end
          local maxLv = 1
          for i, v in pairs(cards) do
            local detail = PlayerData:GetFactoryData(v.id, "UnitFactory")
            if maxLv < detail.qualityInt then
              maxLv = detail.qualityInt
            end
          end
          local DataModel = require("UIShowCharacter/UIShowCharacterDataModel")
          DataModel.isSkip = false
          View.Video_Gacha.self:SetActive(true)
          View.Video_Gacha.self:Play("Video/Gacha/Gacha0" .. maxLv, false, false, true, function()
            View.Group_Sign:SetActive(false)
            UIManager:Open("UI/ShowCharacter/ShowCharacter", Json.encode(t), nil, nil, false, true)
            View.Video_Gacha.self:SetActive(false)
            StopSoundTrain()
          end)
          PlaySoundTrain()
        end, DataModel.DataIDPool.id, 10, function(json)
          View.Group_Sign:SetActive(false)
        end)
      end
    end)
  end,
  Gacha_Page_PoolList_SetPage = function(element, elementIndex)
    local cardPool = DataModel.CardPool[elementIndex]
    local data = cardPool.data
    print_r(data)
    if data.imageList and #data.imageList > 0 then
      for i = 1, 6 do
        local img = element.Group_Card.Img_Mask["Img_C" .. i]
        if i <= #data.imageList then
          img:SetSprite(data.imageList[i].image)
          img:SetLocalPosition(Vector3(data.imageList[i].x, data.imageList[i].y, 0))
          img:SetLocalScale(Vector3(data.imageList[i].scale, data.imageList[i].scale, 1))
        end
        img:SetActive(i <= #data.imageList)
      end
    else
      element.Group_Card.Img_Mask.Img_C1:SetActive(false)
      element.Group_Card.Img_Mask.Img_C2:SetActive(false)
    end
    element.Group_Card.Img_Mask.Btn_Info1.self:SetClickParam(elementIndex)
    element.Group_Card.Img_Mask.Btn_Info2.self:SetClickParam(elementIndex)
    element.Group_Card.Img_Mask.Btn_Info3.self:SetClickParam(elementIndex)
    element.Group_Card.Img_Mask.Btn_Info4.self:SetClickParam(elementIndex)
    element.Group_Card.Img_Mask.Btn_Info5.self:SetClickParam(elementIndex)
    element.Group_Card.Img_Mask.Btn_Info6.self:SetClickParam(elementIndex)
    element.Group_Card.Group_TenPulls.BtnPolygon_TenPulls.self:SetClickParam(elementIndex)
    element.Group_Card.Group_OnePull.BtnPolygon_OnePull.self:SetClickParam(elementIndex)
    for i = 1, 6 do
      local btn = element.Group_Card.Img_Mask["Btn_Info" .. i]
      btn.self:SetActive(i <= #data.btnList)
      if i <= #data.btnList then
        local cfg = PlayerData:GetFactoryData(data.btnList[i].id)
        btn.Txt_Name:SetText(cfg.name)
        btn.self:SetLocalPosition(Vector3(data.btnList[i].x, data.btnList[i].y, 0))
      end
    end
    local Ten_Img_Cost = element.Group_Card.Group_TenPulls.Img_Cost
    local len = #data.costTenList
    for i, v in ipairs(data.costTenList) do
      if 0 < PlayerData:GetGoodsById(v.id).num or i == len then
        local item = PlayerData:GetFactoryData(v.id, "ItemFactory")
        local itemView = PlayerData:GetFactoryData(item.viewId, "ItemViewFactory")
        Ten_Img_Cost.Img_Icon:SetSprite(item.iconPath)
        Ten_Img_Cost.Txt_Item:SetText("x" .. v.num)
        break
      end
    end
    local Group_OnePull = element.Group_Card.Group_OnePull
    if data.freeCD ~= 0 then
      if cardPool.server and (not cardPool.server.free_last_countdown or TimeUtil:GetServerTimeStamp() >= tonumber(cardPool.server.free_last_countdown)) then
        Group_OnePull.Img_Cost.self:SetActive(false)
        Group_OnePull.Img_Free.self:SetActive(true)
        if cardPool.detail.timeFunc1 ~= nil then
          EventManager:RemoveOnSecondEvent(cardPool.detail.timeFunc1)
          cardPool.detail.timeFunc1 = nil
        end
      else
        Group_OnePull.Img_Cost.self:SetActive(true)
        Group_OnePull.Img_Free.self:SetActive(false)
        if tonumber(cardPool.server.free_last_countdown) > TimeUtil:GetServerTimeStamp() then
          local testFunc = function()
            if tonumber(cardPool.server.free_last_countdown) <= TimeUtil:GetServerTimeStamp() then
              Group_OnePull.Img_Cost.self:SetActive(false)
              Group_OnePull.Img_Free.self:SetActive(true)
              if cardPool.detail.timeFunc1 ~= nil then
                EventManager:RemoveOnSecondEvent(cardPool.detail.timeFunc1)
                cardPool.detail.timeFunc1 = nil
              end
              return
            end
            local time = TimeUtil:SecondToTable(tonumber(cardPool.server.free_last_countdown) - TimeUtil:GetServerTimeStamp())
            Group_OnePull.Img_Cost.Txt_Free:SetText(TimeFree(time))
          end
          if cardPool.detail.timeFunc1 == nil then
            cardPool.detail.timeFunc1 = testFunc
            EventManager:AddOnSecondEvent(cardPool.detail.timeFunc1)
          end
          Group_OnePull.Img_Cost.Txt_Free:SetActive(true)
        end
        local len = #data.costList
        for i, v in ipairs(data.costList) do
          if 0 < PlayerData:GetGoodsById(v.id).num or i == len then
            local item = PlayerData:GetFactoryData(v.id, "ItemFactory")
            local itemView = PlayerData:GetFactoryData(item.viewId, "ItemViewFactory")
            Group_OnePull.Img_Cost.Img_Icon:SetSprite(item.iconPath)
            Group_OnePull.Img_Cost.Txt_Item:SetText("x" .. v.num)
            break
          end
        end
      end
    else
      Group_OnePull.Img_Cost.self:SetActive(true)
      Group_OnePull.Img_Free.self:SetActive(false)
      local len = #data.costList
      for i, v in ipairs(data.costList) do
        if PlayerData:GetGoodsById(v.id).num > v.num or i == len then
          local item = PlayerData:GetFactoryData(v.id, "ItemFactory")
          local itemView = PlayerData:GetFactoryData(item.viewId, "ItemViewFactory")
          Group_OnePull.Img_Cost.Img_Icon:SetSprite(item.iconPath)
          Group_OnePull.Img_Cost.Txt_Item:SetText("x" .. v.num)
          break
        end
      end
    end
    if data.endTime ~= "" then
      local startTime = TimeUtil:GetTimeTable(data.startTime)
      local endTime = TimeUtil:GetTimeTable(data.endTime)
      local str = string.format(GetText(80600005), startTime.year, startTime.month, startTime.day, startTime.hour .. ":" .. startTime.minute, endTime.year, endTime.month, endTime.day, endTime.hour .. ":" .. endTime.minute)
      element.Group_Card.Group_TimeLimit.Txt_CutOffTime:SetText(str)
    end
    element.Group_Card.Group_TimeLimit.self:SetActive(data.endTime ~= "")
    element.Group_Card.Group_Normal.self:SetActive(data.endTime == "")
    if cardPool.detail.timeFunc == nil and data.endTime ~= "" then
      local testFunc1 = function(isFirst)
        local lastTime = TimeUtil:LastTime(data.endTime)
        local time = TimeUtil:SecondToTable(lastTime)
        if DataModel.Index == elementIndex or isFirst then
          element.Group_Card.Group_TimeLimit.Txt_RemainingTime:SetText(TimeUtil:GetGachaDesc(time))
        end
        if lastTime == 0 then
          EventManager:RemoveOnSecondEvent(cardPool.detail.timeFunc)
          cardPool.detail.timeFunc = nil
          if DataModel.Index == elementIndex then
            Controller:RefreshMain(1)
          else
            Controller:RefreshMain(Controller:GetIndex(data.id))
          end
        end
      end
      testFunc1(true)
      cardPool.detail.timeFunc = testFunc1
      EventManager:AddOnSecondEvent(cardPool.detail.timeFunc)
    end
    element.Group_Card.Img_BG:SetSprite(data.imageBg)
    element.Group_Card.Txt_Name:SetText(data.name)
  end,
  Gacha_Page_PoolList_PageDrag = function(dragOffsetPos)
  end,
  Gacha_Page_PoolList_PageDragComplete = function(index)
    Controller:RefreshTab(index + 1)
  end,
  Gacha_Page_PoolList_PageDragBegin = function(dragOffsetPos)
  end,
  Gacha_Group_Details_Btn_Close_Click = function(btn, str)
    View.Group_Details.self:SetActive(false)
  end,
  Gacha_Page_PoolList_Group_CardPool_Group_Card_Img_Mask_Btn_Info1_Click = function(btn, str)
    Controller:OpenSelectRoleTip(tonumber(str))
  end,
  Gacha_Page_PoolList_Group_CardPool_Group_Card_Img_Mask_Btn_Info2_Click = function(btn, str)
    Controller:OpenSelectRoleTip(tonumber(str))
  end,
  Gacha_Page_PoolList_Group_CardPool_Group_Card_Img_Mask_Btn_Info3_Click = function(btn, str)
    Controller:OpenSelectRoleTip(tonumber(str))
  end,
  Gacha_Page_PoolList_Group_CardPool_Group_Card_Img_Mask_Btn_Info4_Click = function(btn, str)
    Controller:OpenSelectRoleTip(tonumber(str))
  end,
  Gacha_Page_PoolList_Group_CardPool_Group_Card_Img_Mask_Btn_Info5_Click = function(btn, str)
    Controller:OpenSelectRoleTip(tonumber(str))
  end,
  Gacha_Page_PoolList_Group_CardPool_Group_Card_Group_OnePull_BtnPolygon_OnePull_Click = function(btn, str)
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
        SetHero(json.new_hero.role)
        PlayerData.ServerData.cards[tostring(data.id)] = cardPool.server or {}
        PlayerData.ServerData.cards[tostring(data.id)].free_last_countdown = json.free_last_countdown
        local cards = GetCardData(json)
        Controller:RefreshMain(DataModel.Index)
        local t
        if json.reward.material and table.count(json.reward.material) > 0 then
          t = {
            type = EnumDefine.DrawCard.One,
            cards = cards,
            index = 1,
            material = {
              material = json.reward.material
            }
          }
        else
          t = {
            type = EnumDefine.DrawCard.One,
            cards = cards,
            index = 1
          }
        end
        local maxLv = 1
        for i, v in pairs(cards) do
          local detail = PlayerData:GetFactoryData(v.id, "UnitFactory")
          if maxLv < detail.qualityInt then
            maxLv = detail.qualityInt
          end
        end
        local DataModel = require("UIShowCharacter/UIShowCharacterDataModel")
        DataModel.isSkip = false
        View.R_Particle.self:SetActive(false)
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
  Gacha_Page_PoolList_Group_CardPool_Group_Card_Group_TenPulls_BtnPolygon_TenPulls_Click = function(btn, str)
    local data = DataModel.CardPool[tonumber(str)].data
    Controller:ShowBuyItem(EnumDefine.DrawCard.Ten, data)
  end,
  Gacha_Video_Gacha_Skip_Click = function(btn, str)
  end,
  Gacha_Group_BuyItem_Btn_BG_Click = function(btn, str)
    View.Group_BuyItem.self:SetActive(false)
  end,
  Gacha_Group_BuyItem_Group_Middle_Group_Item1_Btn_Item_Click = function(btn, str)
  end,
  Gacha_Group_BuyItem_Group_Middle_Group_Item2_Btn_Item_Click = function(btn, str)
  end,
  Gacha_Group_BuyItem_Btn_Confirm_Click = function(btn, str)
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
        Net:SendProto("recruit.do_recruit", function(json)
          PlayerData:RefreshUseItems(DataModel.DataIDPool.item)
          RecruitFlow.event_seq = "recruit.do_recruit"
          SetHero(json.new_hero.role)
          local cards = GetCardData(json)
          Controller:RefreshMain(DataModel.Index)
          local t
          if json.reward.material and table.count(json.reward.material) then
            t = {
              type = DataModel.GachaType,
              cards = cards,
              index = 1,
              material = {
                material = json.reward.material
              }
            }
          else
            t = {
              type = DataModel.GachaType,
              cards = cards,
              index = 1
            }
          end
          local maxLv = 1
          for i, v in pairs(cards) do
            local detail = PlayerData:GetFactoryData(v.id, "UnitFactory")
            if maxLv < detail.qualityInt then
              maxLv = detail.qualityInt
            end
          end
          local DataModel = require("UIShowCharacter/UIShowCharacterDataModel")
          DataModel.isSkip = false
          View.R_Particle.self:SetActive(false)
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
  Gacha_Group_BuyItem_Btn_Cancel_Click = function(btn, str)
    View.Group_BuyItem.self:SetActive(false)
  end,
  Gacha_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Gacha_Page_PoolList_Group_CardPool_Group_Card_Img_Mask_Btn_Info6_Click = function(btn, str)
  end,
  Gacha_Page_PoolList_Group_CardPool_Group_Card_Btn_Details_Click = function(btn, str)
    View.Group_Details.self:SetActive(true)
    local data = DataModel.CardPool[DataModel.Index].data
    local extract = PlayerData:GetFactoryData(data.id, "ExtractFactory").details
    View.Group_Details.Txt_Details:SetText(extract)
  end
}
return ViewFunction
