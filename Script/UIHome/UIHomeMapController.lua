local View = require("UIMainUI/UIMainUIView")
local DataModel = require("UIHome/UIHomeMapDataModel")
local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
local MainUIDataModel = require("UIMainUI/UIMainUIDataModel")
local Controller = {}

function Controller:CleanPolluteLinesData()
  if DataModel.PolluteLinesList and table.count(DataModel.PolluteLinesList) > 0 then
    for k, v in pairs(DataModel.PolluteLinesList) do
      Object.Destroy(v)
    end
  end
  DataModel.PolluteLinesList = {}
  if DataModel.PolluteEventList and 0 < table.count(DataModel.PolluteEventList) then
    for k, v in pairs(DataModel.PolluteEventList) do
      Object.Destroy(v)
    end
  end
  DataModel.PolluteEventList = {}
  if DataModel.DungeonEventList and 0 < table.count(DataModel.DungeonEventList) then
    for k, v in pairs(DataModel.DungeonEventList) do
      Object.Destroy(v)
    end
  end
  DataModel.DungeonEventList = {}
  if DataModel.ResidentEventList and 0 < table.count(DataModel.ResidentEventList) then
    for k, v in pairs(DataModel.ResidentEventList) do
      Object.Destroy(v)
    end
  end
  DataModel.ResidentEventList = {}
end

function Controller:SetPolluteLines()
  Controller:CleanPolluteLinesData()
  PlayerData:GetPolluteTurntable()
  DataModel.PolluteLinesList = {}
  DataModel.PolluteEventList = {}
  DataModel.DungeonEventList = {}
  DataModel.ResidentEventList = {}
  DataModel.PolluteLinesIconConfig = DataModel.PolluteLinesIconConfig ~= nil and DataModel.PolluteLinesIconConfig or PlayerData:GetFactoryData(99900021).polluteIconPath
  if PlayerData.pollute_areas == nil or table.count(PlayerData.pollute_areas) == 0 then
    return
  end
  local Group_Pollte = "UI/MainUI/Group_Pollute"
  local Parent = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Group_Pollte.transform
  local DungeonParent = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Group_Dungeon.transform
  local Group_Dungeon = "UI/MainUI/Group_Dungeon"
  for k, v in pairs(PlayerData.pollute_areas) do
    if v.click_level_events then
      local areaId = tonumber(k)
      local areaCfg = PlayerData:GetFactoryData(areaId)
      for a, b in pairs(v.click_level_events) do
        local currIndex = tonumber(a) + 1
        if areaCfg.ClickEventPosList[currIndex] then
          local eventCfg = PlayerData:GetFactoryData(b, "AFKEventFactory")
          local obj = View.self:GetRes(Group_Dungeon, DungeonParent)
          local x = areaCfg.ClickEventPosList[currIndex].icon_x
          local y = areaCfg.ClickEventPosList[currIndex].icon_y
          obj.transform.localPosition = Vector3(x, y, 0)
          obj:SetActive(true)
          local isOk = true
          local img_Icon = obj.transform:Find("Img_Icon"):GetComponent(typeof(CS.Seven.UIImg))
          if img_Icon == nil or img_Icon:IsNull() then
            print_r("Img_Icon Is Null !!!!!!")
            isOk = false
          else
            img_Icon:SetSprite(eventCfg.MapIconPath)
          end
          if not isOk then
            obj:SetActive(false)
          end
          table.insert(DataModel.PolluteEventList, obj)
        else
          print(string.format("AreaFactory工厂 %d 的ClickEventPosList 的%d报错 ", areaId, currIndex))
        end
      end
    end
    if v.click_dungeon_events then
      local t = {}
      local areaId = tonumber(k)
      local areaCfg = PlayerData:GetFactoryData(areaId)
      for index, id in pairs(v.click_dungeon_events) do
        local num = PlayerData:GetDungeonNum(k, index)
        local eventCfg = PlayerData:GetFactoryData(id, "AFKEventFactory")
        if num < eventCfg.countMax then
          local obj = View.self:GetRes(Group_Dungeon, DungeonParent)
          local currIndex = tonumber(index) + 1
          if areaCfg.ClickDungeonEventPosList[currIndex] == nil then
            print(string.format("AreaFactory工厂 %d 的ClickDungeonEventPosList 的%d报错", areaId, currIndex))
          else
            local x = areaCfg.ClickDungeonEventPosList[currIndex].icon_x
            local y = areaCfg.ClickDungeonEventPosList[currIndex].icon_y
            obj.transform.localPosition = Vector3(x, y, 0)
            obj:SetActive(true)
            local isOk = true
            local img_Icon = obj.transform:Find("Img_Icon"):GetComponent(typeof(CS.Seven.UIImg))
            if img_Icon == nil or img_Icon:IsNull() then
              print_r("Img_Icon Is Null !!!!!!")
              isOk = false
            else
              img_Icon:SetSprite(eventCfg.MapIconPath)
            end
            if not isOk then
              obj:SetActive(false)
            end
            table.insert(DataModel.DungeonEventList, obj)
          end
        end
      end
    end
    if v.click_resident_events then
      local t = {}
      local areaId = tonumber(k)
      local areaCfg = PlayerData:GetFactoryData(areaId)
      for listIdAndIndex, eventId in pairs(v.click_resident_events) do
        local values = string.split(listIdAndIndex, ":")
        local listId = tonumber(values[1])
        local index = tonumber(values[2]) + 1
        local listCfg = PlayerData:GetFactoryData(listId, "ListFactory")
        local detail = listCfg.clickEventList[index]
        if detail and detail.isShowUI then
          local eventCfg = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
          local obj = View.self:GetRes(Group_Dungeon, DungeonParent)
          local x = detail.icon_x
          local y = detail.icon_y
          obj.transform.localPosition = Vector3(x, y, 0)
          obj:SetActive(true)
          local isOk = true
          local img_Icon = obj.transform:Find("Img_Icon"):GetComponent(typeof(CS.Seven.UIImg))
          if img_Icon == nil or img_Icon:IsNull() then
            print_r("Img_Icon Is Null !!!!!!")
            isOk = false
          else
            img_Icon:SetSprite(eventCfg.MapIconPath)
          end
          if not isOk then
            obj:SetActive(false)
          end
          table.insert(DataModel.ResidentEventList, obj)
        else
        end
      end
    end
    if v.po_curIndex ~= nil then
      local homeLineCA = PlayerData:GetFactoryData(k)
      local x = homeLineCA.polluteX
      local y = homeLineCA.polluteY
      local icon
      local po_curIndex = math.ceil(v.po_curIndex)
      if po_curIndex ~= 0 then
        if po_curIndex <= 3 then
          icon = DataModel.PolluteLinesIconConfig[1].path
        elseif po_curIndex <= 6 then
          icon = DataModel.PolluteLinesIconConfig[2].path
        elseif po_curIndex <= 9 then
          icon = DataModel.PolluteLinesIconConfig[3].path
        else
          icon = DataModel.PolluteLinesIconConfig[4].path
        end
        local obj = View.self:GetRes(Group_Pollte, Parent)
        local isOk = true
        obj.transform.localPosition = Vector3(x, y, 0)
        obj:SetActive(true)
        local img_Icon = obj.transform:Find("Img_Icon"):GetComponent(typeof(CS.Seven.UIImg))
        if img_Icon == nil or img_Icon:IsNull() then
          print_r("Img_Icon Is Null !!!!!!")
          isOk = false
        else
          img_Icon:SetSprite(icon)
        end
        local txt_Num = obj.transform:Find("Txt_Num"):GetComponent(typeof(CS.Seven.UITxt))
        if txt_Num == nil or txt_Num:IsNull() then
          print_r("Txt_Num Is Null !!!!!!")
          isOk = false
        else
          txt_Num:SetText(po_curIndex)
        end
        if not isOk then
          obj:SetActive(false)
        end
        table.insert(DataModel.PolluteLinesList, obj)
      end
    end
  end
end

function Controller:RefreshMapNeedleIcon()
  for lineId, v in pairs(PlayerData:GetHomeInfo().home_lines) do
    local lineCA = PlayerData:GetFactoryData(lineId, "ListFactory")
    for _, v in pairs(lineCA.mapNeedleList) do
      local needleCA = PlayerData:GetFactoryData(v.id, "MapNeedleFactory")
      if needleCA.isShowUI then
        local obj = DataModel.NeedleList and DataModel.NeedleList[v.id]
        local show = MapNeedleData.CheckNeedleShow(v.id)
        if obj then
          if not show then
            Object.Destroy(obj)
            DataModel.NeedleList[v.id] = nil
          end
        elseif show then
          obj = Controller:SetSingleNeedleState(v.id, true, tonumber(needleCA.icon_x), tonumber(needleCA.icon_y))
          obj.transform:Find("Img_Icon").transform:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(needleCA.iconPath)
        end
      end
    end
  end
end

function Controller:UpdateMapNeedleIcon()
  if DataModel.NeedleList then
    for needleId, obj in pairs(DataModel.NeedleList) do
      if not MapNeedleData.CheckNeedleShow(needleId) then
        Object.Destroy(obj)
        DataModel.NeedleList[needleId] = nil
      end
    end
  end
end

function Controller:SetSingleNeedleState(needleId, state, x, y)
  DataModel.NeedleList = DataModel.NeedleList or {}
  local obj = DataModel.NeedleList[needleId]
  if not obj then
    local Parent = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Group_Dungeon.transform
    obj = View.self:GetRes("UI/MainUI/Group_Dungeon", Parent)
    obj.transform.localPosition = Vector3(x, y, 0)
    obj:SetActive(state)
    DataModel.NeedleList[needleId] = obj
  else
    obj.transform.localPosition = Vector3(x, y, 0)
    obj:SetActive(state)
  end
  return obj
end

function Controller:SetNeedleAreaState(needleAreaId, state, x, y, radiusX, radiusY)
  DataModel.NeedleAreaList = DataModel.NeedleAreaList or {}
  local obj = DataModel.NeedleAreaList[needleAreaId]
  if not obj then
    local Parent = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Group_Pollte.transform
    obj = View.self:GetRes("UI/MainUI/Group_Pollute", Parent)
    obj.transform.localPosition = Vector3(x, y, 0)
    obj.transform.localScale = Vector3(radiusX / 100, radiusY / 100, 1)
    obj:SetActive(state)
    DataModel.NeedleAreaList[needleAreaId] = obj
  else
    obj.transform.localPosition = Vector3(x, y, 0)
    obj.transform.localScale = Vector3(radiusX / 100, radiusY / 100, 1)
    obj:SetActive(state)
  end
end

function Controller:ClearMapNeedle()
  if DataModel.NeedleList then
    for i, v in pairs(DataModel.NeedleList) do
      Object.Destroy(v)
    end
    DataModel.NeedleList = nil
  end
  if DataModel.NeedleAreaList then
    for i, v in pairs(DataModel.NeedleAreaList) do
      Object.Destroy(v)
    end
    DataModel.NeedleAreaList = nil
  end
end

function Controller:ReSizeMapToView()
  local size = View.self.transform:GetComponent(typeof(CS.UnityEngine.RectTransform)).rect.size
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.self.Rect.sizeDelta = size
end

local InnerClickStation = function(id)
  DataModel.CurSelectedId = id
  local stationCA = PlayerData:GetFactoryData(id, "HomeStationFactory")
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Selected:SetActive(true)
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Selected:SetAnchoredPosition(Vector2(stationCA.x, stationCA.y))
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.self:SetActive(false)
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.self:SetActive(true)
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Group_Info.Group_Station.Txt_Name:SetText(stationCA.name)
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Group_Info.Group_Station.Group_Type1.Txt_:SetText(stationCA.nameEN)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Group_Info.Group_Station.Txt_Distance:SetText(string.format(GetText(80600706), math.ceil(DataModel.GetTargetStationDistance(DataModel.CurSelectedId) * homeConfig.disRatio)))
  local serverDevData = PlayerData:GetHomeInfo().dev_degree[tostring(id)]
  local homeCommon = require("Common/HomeCommon")
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Group_Info.Group_City.Group_Development.Txt_Development:SetText(string.format(GetText(80600704), math.floor(serverDevData.dev_degree or 0)))
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Group_Info.Group_City.Group_Reputation.Txt_Reputation:SetText(string.format(GetText(80600705), homeCommon.GetRepLv(id) or 0))
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Group_Info.Group_Desc.ScrollView_Des.Viewport.Txt_Des:SetText(stationCA.des)
  DataModel.CurShowList = {}
  if stationCA.sellList ~= nil then
    for k, v in pairs(stationCA.sellList) do
      local info = PlayerData:GetFactoryData(v.id, "ListFactory")
      if info ~= nil and info.needDevelopNum <= (serverDevData.dev_degree or 0) then
        local t = {}
        t.id = info.goodsId
        t.price = info.price
        local goodsCA = PlayerData:GetFactoryData(info.goodsId, "HomeGoodsFactory")
        t.isSpecial = goodsCA.isSpeciality
        table.insert(DataModel.CurShowList, t)
      end
    end
  end
  table.sort(DataModel.CurShowList, function(a, b)
    return a.price < b.price
  end)
  local showGoodsList = 0 < #DataModel.CurShowList
  if 0 < stationCA.showGoodsQuest and showGoodsList then
    showGoodsList = PlayerData.IsQuestComplete(stationCA.showGoodsQuest)
  end
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Group_Goods.self:SetActive(showGoodsList)
  if showGoodsList then
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Group_Goods.ScrollGrid_GoodsList.grid.self:SetDataCount(#DataModel.CurShowList)
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Group_Goods.ScrollGrid_GoodsList.grid.self:RefreshAllElement()
  end
  local isTravel = PlayerData:GetHomeInfo().station_info.is_arrived == 0
  local isBanStop = stationCA.isBanStop
  local lvCheckOk = true
  local levelCheckOk = true
  local questCheckOk = true
  local isUnlock = not isBanStop
  if not isBanStop then
    lvCheckOk = PlayerData:GetUserInfo().lv >= stationCA.playerLevel
    levelCheckOk = 0 > stationCA.specifiedLevelId or PlayerData:GetLevelPass(stationCA.specifiedLevelId)
    questCheckOk = 0 > stationCA.questId or PlayerData.IsQuestComplete(stationCA.questId)
    isUnlock = lvCheckOk and levelCheckOk and questCheckOk
  end
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Btn_Go.self:SetActive(not isTravel and DataModel.CurSelectedId ~= TradeDataModel.EndCity and isUnlock)
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Btn_Trailer.self:SetActive(not isTravel and DataModel.CurSelectedId ~= TradeDataModel.EndCity and isUnlock)
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Btn_BuyRush.self:SetActive(not isTravel and DataModel.CurSelectedId ~= TradeDataModel.EndCity and isUnlock)
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Btn_DriveSetup.self:SetActive(not isTravel and DataModel.CurSelectedId ~= TradeDataModel.EndCity and isUnlock)
  Controller:RefreshAcceNum()
  Controller:RefreshTrailerNum()
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Img_Ban.self:SetActive(isTravel)
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Img_Lock.self:SetActive(not isTravel and not isUnlock)
  if isBanStop then
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Img_Lock.Txt_Condition:SetText(stationCA.banStopTips)
  elseif not isUnlock then
    if not questCheckOk then
      local questCA = PlayerData:GetFactoryData(stationCA.questId, "QuestFactory")
      View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Img_Lock.Txt_Condition:SetText(string.format(GetText(80601868), questCA.name))
    elseif not lvCheckOk then
      View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Img_Lock.Txt_Condition:SetText(stationCA.banStopTips)
    elseif not levelCheckOk then
      View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Img_Lock.Txt_Condition:SetText(stationCA.banStopTips)
    end
  end
end

function Controller:ClickBtn(btn)
  local name = btn.transform:GetChild(0).name
  local id = string.sub(name, #DataModel.UIStationPreName + 1, #name)
  if DataModel.CurSelectedId == tonumber(id) then
    return
  end
  InnerClickStation(tonumber(id))
end

function Controller:RefreshAcceNum()
  local max = PlayerData.GetMaxFuelNum()
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Btn_BuyRush.Group_Num.Txt_Num:SetText(PlayerData:GetHomeInfo().readiness.fuel.fuel_num .. "/" .. max)
end

function Controller:RefreshTrailerNum()
  local max = PlayerData.GetMaxTrailerNum()
  local currNum = PlayerData:GetHomeInfo().req_back_num
  local currMonthRemainNum = PlayerData:GetHomeInfo().monthly_req_back_num
  currNum = currNum + currMonthRemainNum
  local currTime = TimeUtil:GetServerTimeStamp()
  if next(PlayerData.ServerData.monthly_card) ~= nil then
    for i, v in pairs(PlayerData.ServerData.monthly_card) do
      local deadline = v.deadline
      print_r(deadline)
      if currTime < deadline then
        local maxMonth = PlayerData:GetFactoryData(99900060, "ConfigFactory").trailerMonthCardMax
        max = max + maxMonth
      end
    end
  end
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.Btn_Trailer.Group_Num.Txt_Num:SetText(currNum .. "/" .. max)
end

function Controller:RefreshStationPos()
  local tradeDataModel = require("UIHome/UIHomeTradeDataModel")
  local id = tradeDataModel.EndCity
  local stationCA = PlayerData:GetFactoryData(id, "HomeStationFactory")
  local pos = Vector2(stationCA.x, stationCA.y)
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Train:SetAnchoredPosition(pos)
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Tex:SetAnchoredPosition(pos)
  if tradeDataModel.GetIsTravel() then
    Controller:RefreshStationPosImmediately()
  end
end

function Controller:InitMapPos()
  local pos = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Train.Rect.anchoredPosition
  local maxWidth, maxHeight = 3000, 3000
  local screenWidth, screenHeight = 1920, 1080
  local percentX = pos.x / maxWidth + 0.5
  local percentY = -pos.y / maxHeight + 0.5
  local posX, posY = (screenWidth - maxWidth) * percentX, (maxHeight - screenHeight) * percentY
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.self:SetAnchoredPosition(Vector2(posX, posY))
end

function Controller:RefreshStationPosImmediately()
  Controller:CalcTravelLineWaypoints(TradeDataModel.NextCityPath)
  local remainDis = TradeDataModel.CurRemainDistance
  local curDis = TradeDataModel.TravelTotalDistance - remainDis
  Controller:RefreshTrainPosByCurDis(TradeDataModel.NextCityPath, curDis)
end

function Controller:RefreshTrainPosByCurDis(cityPath, curDis)
  local count = #cityPath
  local findPos = false
  for i = 1, count - 1 do
    if findPos then
      break
    end
    local station01 = cityPath[i]
    local toList = DataModel.AllStationPathRecord[station01]
    for k, v in pairs(toList) do
      if k == cityPath[i + 1] then
        if curDis <= v.distance then
          findPos = true
          do
            local wayPointsInfo = DataModel.TravelLineWayPoints[station01]
            if wayPointsInfo == nil then
              DataModel.TravelLineWayPoints = {}
              return
            end
            for k1, v1 in pairs(wayPointsInfo) do
              if curDis <= v1.distance then
                local pos1 = v1.startMapPos
                local pos2 = v1.endMapPos
                local newPos = (pos2 - pos1) * (curDis / v1.distance) + pos1
                View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Train:SetAnchoredPosition(newPos)
                View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Tex:SetAnchoredPosition(newPos)
                if DataModel.trainDirection == nil or DataModel.trainDirection ~= v1.direction then
                  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Train:SetUpDirection(v1.direction)
                  DataModel.trainDirection = v1.direction
                end
                local lineId = v.id
                local lineCA = PlayerData:GetFactoryData(lineId, "HomeLineFactory")
                local bgmId = lineCA.bgmId
                if station01 == lineCA.station02 and lineCA.bgmId2 > -1 then
                  bgmId = lineCA.bgmId2
                end
                if TradeDataModel.GetIsTravel() and MainUIDataModel.nowSoundId > 0 and MainUIDataModel.nowSoundId ~= bgmId and MainUIDataModel.TrainEventBgmId == nil then
                  Controller.SwitchBGM(MainUIDataModel.nowSoundId, bgmId, 0, 1)
                  MainUIDataModel.nowSoundId = bgmId
                end
                break
              else
                curDis = curDis - v1.distance
              end
            end
          end
          break
        end
        curDis = curDis - v.distance
        break
      end
    end
  end
end

function Controller:CalcTravelLineWaypoints(travelStations)
  if table.count(DataModel.TravelLineWayPoints) > 0 then
    return
  end
  local count = #travelStations
  for i = 1, count - 1 do
    local station01 = travelStations[i]
    local station02 = travelStations[i + 1]
    local distance = DataModel.AllStationPathRecord[station01][station02].distance
    local wayPointList = DataModel.AllStationPathRecord[station01][station02].wayPointList
    local station01CA = PlayerData:GetFactoryData(station01, "HomeStationFactory")
    local station02CA = PlayerData:GetFactoryData(station02, "HomeStationFactory")
    local startPos = Vector2(station01CA.x, station01CA.y)
    local endPos = Vector2(station02CA.x, station02CA.y)
    local totalMapDis = 0
    DataModel.TravelLineWayPoints[station01] = {}
    for k, v in pairs(wayPointList) do
      local t = {}
      local endMapPos = Vector2(v.x, v.y)
      local mapDis = DataModel.CalcVector2Dis(startPos, endMapPos)
      t.startMapPos = startPos
      t.endMapPos = endMapPos
      t.direction = endMapPos - startPos
      t.direction = t.direction / mapDis
      t.direction = Vector3(t.direction.x, t.direction.y, 0)
      t.mapDis = mapDis
      totalMapDis = totalMapDis + mapDis
      table.insert(DataModel.TravelLineWayPoints[station01], t)
      startPos = endMapPos
    end
    local t = {}
    local mapDis = DataModel.CalcVector2Dis(startPos, endPos)
    t.startMapPos = startPos
    t.endMapPos = endPos
    t.direction = endPos - startPos
    t.direction = t.direction / mapDis
    t.direction = Vector3(t.direction.x, t.direction.y, 0)
    t.mapDis = mapDis
    totalMapDis = totalMapDis + mapDis
    table.insert(DataModel.TravelLineWayPoints[station01], t)
    for k, v in pairs(DataModel.TravelLineWayPoints[station01]) do
      v.distance = v.mapDis / totalMapDis * distance
    end
  end
end

function Controller:ShowDetailMap(isShow, isFirst, compleleCb, isActivite)
  local curServerGuideNo = PlayerData:GetUserInfo().newbie_step
  local guideConfig = PlayerData:GetFactoryData(99900035, "ConfigFactory")
  if isShow and curServerGuideNo < 999 and not guideConfig.skipGuide then
    local canOpen = true
    local showTxt = ""
    local station_info = PlayerData:GetHomeInfo().station_info
    if station_info ~= nil then
      local stop_info = station_info.stop_info
      if stop_info ~= nil and stop_info[2] == -1 then
        local stationId = tonumber(stop_info[1])
        local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
        for k, v in pairs(stationCA.lockStationQuestList) do
          if PlayerData:IsHaveQuest(v.id) then
            canOpen = false
            showTxt = stationCA.name
            break
          end
        end
      end
    end
    if not canOpen then
      CommonTips.OpenGuidanceTips(80601199)
      return
    end
  end
  if PlayerData:GetHomeInfo().station_info.is_arrived ~= 0 or isFirst then
    View.Group_Common.Btn_ClickFight.self:SetActive(false)
    if PlayerData.pollute_areas == nil or table.count(PlayerData.pollute_areas) == 0 then
      Net:SendProto("unification.world_pollute", function()
        Controller:SetPolluteLines()
        View.Group_Common.SoftMask_HomeMap.self:MaskAllManaged()
      end)
    else
      Controller:SetPolluteLines()
      View.Group_Common.SoftMask_HomeMap.self:MaskAllManaged()
    end
  end
  if isFirst then
    Controller:RefreshMapNeedleIcon()
  end
  View.Group_Common.SoftMask_HomeMap.self:SetActive(true)
  View.Group_Common.SoftMask_HomeMap.Group_MapActive:SetActive(isShow)
  if DataModel.MapDetailMask == nil then
    DataModel.MapDetailMask = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.self:GetComponent(typeof(UI.Mask))
  end
  if DataModel.MapCanvasGroup == nil then
    DataModel.MapCanvasGroup = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  end
  local isSameState = DataModel.HomeMapType == (isShow and 2 or 1)
  local commonShow = function(isShow)
    DataModel.MapDetailMask.enabled = isShow
    DataModel.MapCanvasGroup.blocksRaycasts = isShow
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.self.Img.enabled = isShow
    View.Group_Common.SoftMask_HomeMap.Btn_Map:SetActive(not isShow)
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_CommonTopLeft.self:SetActive(isShow)
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Water:SetActive(not isShow)
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.RawImg_Map:SetActive(not isShow)
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Group_OnlyShow:SetActive(isShow)
  end
  local scrollView = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.self
  local content = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.self
  local train = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Train
  local pos = train.transform.localPosition
  if isShow then
    DataModel.CurSelectedId = 0
    local homeCommon = require("Common/HomeCommon")
    homeCommon.TimeCheckRefreshStationInfo()
    local refreshCommon = function()
      DataModel.HomeMapType = 2
      commonShow(isShow)
      View.Group_Common.Btn_HideUI:SetActive(false)
      View.Group_Common.Img_Directional:SetActive(false)
      local homeCommon = require("Common/HomeCommon")
      homeCommon.SetMoveEnergyElement(View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_HomeEnergy)
      homeCommon.SetLoadageElement(View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_Loadage)
      View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_PassengerCapacity:SetActive(PlayerData.IsPassageFunOpen())
      if PlayerData.IsPassageFunOpen() then
        homeCommon.SetPassengerElement(View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_PassengerCapacity)
      end
      Controller:RefreshStationPos()
      View.Group_Common.SoftMask_HomeMap.self:SetLocalPosition(Vector3(0, 125, 0))
      scrollView:SetAnchoredPosition(Vector2(0, 0))
      content:SetAnchoredPosition(Vector2(-pos.x, -pos.y))
      View.Group_Common.SoftMask_HomeMap.self:ResetAllManaged()
      Controller:SetPolluteLines()
      Controller:RefreshMapNeedleIcon()
      View.self:PlayAnim("MapIn", function()
        if compleleCb then
          compleleCb()
        end
      end)
    end
    if isActivite then
      refreshCommon()
    else
      View.self:PlayAnim("Out", function()
        refreshCommon()
      end)
    end
  else
    local hideDo = function()
      DataModel.HomeMapType = 1
      commonShow(isShow)
      View.Group_Common.Btn_HideUI:SetActive(true)
      View.Group_Common.Img_Directional:SetActive(true)
      View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.self:SetActive(false)
      Controller:RefreshStationPos()
      content:SetAnchoredPosition(Vector2(0, 0))
      View.Group_Common.SoftMask_HomeMap.self:SetAnchoredPosition(DataModel.HomeMapAnchoredPos)
      Controller:RefreshViewToTrain()
      View.Group_Common.SoftMask_HomeMap.self:MaskAllManaged()
      View.self:PlayAnim(PlayerData.TempCache.EventFinish == false and "BattleStart" or "In", function()
        local MainUIController = require("UIMainUI/UIMainUIController")
        MainUIController.ShowCoachQuickJump(false)
        MainUIController.ShowManagerTool(false)
        if compleleCb then
          compleleCb()
        end
      end)
    end
    if isSameState then
      hideDo()
    else
      View.self:PlayAnim("MapOut", function()
        hideDo()
      end)
    end
  end
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.self:SetActive(false)
  View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Selected:SetActive(false)
end

function Controller:AutoToClickStation(stationId, isActivite)
  local cb = function()
    local scrollViewObj = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.self.gameObject
    local scrollView = scrollViewObj:GetComponent(typeof(CS.Seven.UIScrollView))
    local ca = PlayerData:GetFactoryData(stationId)
    scrollView.ScrollRect.content:GetComponent(typeof(CS.Seven.UIGroup)):SetAnchoredPosition(Vector2(-ca.x, -ca.y))
    InnerClickStation(stationId)
  end
  Controller:ShowDetailMap(true, false, cb, isActivite)
end

function Controller:RefreshViewToTrain()
  local scrollView = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.self
  local train = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Train
  local pos = train.transform.localPosition
  scrollView:SetAnchoredPosition(Vector2(-pos.x, -pos.y))
end

function Controller.SwitchBGM(nowSoundId, targetSoundId, minVolume, duration)
  if nowSoundId ~= targetSoundId then
    local resUrl = PlayerData:GetFactoryData(nowSoundId).resUrl
    local audio = SoundManager:GetBgmSource(resUrl)
    local targetSound = SoundManager:CreateSound(targetSoundId)
    DOTweenTools.DOFadeSound(audio, duration, minVolume, function()
      local newTargetSoundId
      if MainUIDataModel.TrainEventBgmId ~= nil and MainUIDataModel.TrainEventBgmId ~= targetSoundId then
        newTargetSoundId = MainUIDataModel.TrainEventBgmId
      end
      local targetVolume
      if newTargetSoundId then
        targetVolume = PlayerData:GetFactoryData(newTargetSoundId).volume
      else
        targetSound:Play()
        targetVolume = PlayerData:GetFactoryData(targetSoundId).volume
        targetSound:SetVolume(0.1)
      end
      DOTweenTools.DOFadeSound(audio, duration, targetVolume)
    end)
  end
end

function Controller.RefreshSoftMaskPosition()
  View.Group_Common.SoftMask_HomeMap.self:RefreshMaskPosition()
end

return Controller
