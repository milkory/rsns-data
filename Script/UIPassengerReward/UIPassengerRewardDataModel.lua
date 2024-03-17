local View = require("UIPassengerReward/UIPassengerRewardView")
local DataModel = {}
local this = DataModel
DataModel.outPsgDataList = {}
DataModel.psgConsume = {}
DataModel.ticketNum = 0
DataModel.psgConsumeTotalNum = 0
DataModel.destination = nil
DataModel.curFrame = 0
DataModel.profitFrameStart = 20
DataModel.profitFrameEnd = 60
DataModel.circleAnimFrame = {
  {frameStart = 20, frameEnd = 40},
  {frameStart = 40, frameEnd = 60},
  {frameStart = 60, frameEnd = 80},
  {frameStart = 80, frameEnd = 100}
}
DataModel.circleAnim = {}
DataModel.firstNum = 0
DataModel.secondNum = 0
DataModel.thirdNum = 0
DataModel.otherNum = 0
local scoresType = {}

function DataModel.Init()
  local configCA = PlayerData:GetFactoryData(99900061, "ConfigFactory")
  scoresType.arm = {
    name = "武装",
    resPath = configCA.arm
  }
  scoresType.clean = {
    name = "清洁",
    resPath = configCA.clean
  }
  scoresType.comfort = {
    name = "舒适度",
    resPath = configCA.comfort
  }
  scoresType.fishScores = {
    name = "水族",
    resPath = configCA.fishScores
  }
  scoresType.foodScores = {
    name = "美味",
    resPath = configCA.foodScores
  }
  scoresType.medicalScores = {
    name = "医疗",
    resPath = configCA.medicalScores
  }
  scoresType.petScores = {
    name = "宠物",
    resPath = configCA.petScores
  }
  scoresType.plantScores = {
    name = "绿植",
    resPath = configCA.plantScores
  }
  scoresType.playScores = {
    name = "娱乐",
    resPath = configCA.playScores
  }
end

local totalSitNum = 16

function DataModel.RefreshSitNum()
  View.Group_center.Group_upper.Group_num.Txt_:SetText(string.format("%d/%d", PlayerData:GetCurPassengerNum() - table.count(this.outPsgDataList), PlayerData:GetMaxPassengerNum()))
  local fullRatio = (PlayerData:GetCurPassengerNum() - table.count(this.outPsgDataList)) / PlayerData:GetMaxPassengerNum()
  local fullNum = math.ceil(totalSitNum * fullRatio)
  for i = 1, totalSitNum do
    View.Group_center.Group_upper.Group_seat["Img_seat" .. i]:SetActive(i <= fullNum)
  end
end

function DataModel.RefreshConsume()
  local consumeList = {}
  this.psgConsumeTotalNum = 0
  this.ticketNum = 0
  for i, consumes in pairs(this.psgConsume) do
    for type, consume in pairs(consumes) do
      if type == "ticket" then
        this.ticketNum = this.ticketNum + consume
      elseif not consumeList[type] then
        consumeList[type] = consume
      else
        consumeList[type] = consumeList[type] + consume
      end
    end
  end
  for i, v in pairs(consumeList) do
    this.psgConsumeTotalNum = this.psgConsumeTotalNum + v
  end
  local sortConsumeList = {}
  for i, v in pairs(consumeList) do
    local t = {}
    t.type = i
    t.num = v
    table.insert(sortConsumeList, t)
  end
  table.sort(sortConsumeList, function(a, b)
    return a.num > b.num
  end)
  DataModel.firstNum = sortConsumeList[1] and sortConsumeList[1].num or 0
  DataModel.secondNum = sortConsumeList[2] and sortConsumeList[2].num or 0
  DataModel.thirdNum = sortConsumeList[3] and sortConsumeList[3].num or 0
  DataModel.otherNum = 0
  if 3 < #sortConsumeList then
    for i = 4, #sortConsumeList do
      DataModel.otherNum = DataModel.otherNum + sortConsumeList[i].num
    end
  end
  View.Group_R.Group_icon.Group_fristIcon:SetActive(0 < DataModel.firstNum)
  if 0 < DataModel.firstNum then
    View.Group_R.Group_icon.Group_fristIcon.Img_type:SetSprite(scoresType[sortConsumeList[1].type].resPath)
    View.Group_R.Group_sortList.Group_frist.Txt_type:SetText(scoresType[sortConsumeList[1].type].name)
    View.Group_R.Group_sortList.Group_frist.Group_num.Txt_:SetText(DataModel.firstNum)
  else
    View.Group_R.Group_sortList.Group_frist.Txt_type:SetText("--")
    View.Group_R.Group_sortList.Group_frist.Group_num.Txt_:SetText(0)
  end
  View.Group_R.Group_icon.Group_secondIcon:SetActive(0 < DataModel.secondNum)
  if 0 < DataModel.secondNum then
    View.Group_R.Group_icon.Group_secondIcon.Img_type:SetSprite(scoresType[sortConsumeList[2].type].resPath)
    View.Group_R.Group_sortList.Group_scend.Txt_type:SetText(scoresType[sortConsumeList[2].type].name)
    View.Group_R.Group_sortList.Group_scend.Group_num.Txt_:SetText(DataModel.secondNum)
  else
    View.Group_R.Group_sortList.Group_scend.Txt_type:SetText("--")
    View.Group_R.Group_sortList.Group_scend.Group_num.Txt_:SetText(0)
  end
  View.Group_R.Group_icon.Group_thirdIcon:SetActive(0 < DataModel.thirdNum)
  if 0 < DataModel.thirdNum then
    View.Group_R.Group_icon.Group_thirdIcon.Img_type:SetSprite(scoresType[sortConsumeList[3].type].resPath)
    View.Group_R.Group_sortList.Group_third.Txt_type:SetText(scoresType[sortConsumeList[3].type].name)
    View.Group_R.Group_sortList.Group_third.Group_num.Txt_:SetText(DataModel.thirdNum)
  else
    View.Group_R.Group_sortList.Group_third.Txt_type:SetText("--")
    View.Group_R.Group_sortList.Group_third.Group_num.Txt_:SetText(0)
  end
  View.Group_R.Group_sortList.Group_other.Group_num.Txt_:SetText(DataModel.otherNum)
  View.Group_R.Group_circle.Img_first:SetActive(0 < DataModel.firstNum)
  View.Group_R.Group_circle.Img_scend:SetActive(0 < DataModel.secondNum)
  View.Group_R.Group_circle.Img_third:SetActive(0 < DataModel.thirdNum)
  View.Group_R.Group_circle.Img_other:SetActive(0 < DataModel.otherNum)
  View.Group_R.Group_circle.Img_first:SetFilledImgAmount(0)
  View.Group_R.Group_circle.Img_scend:SetFilledImgAmount(0)
  View.Group_R.Group_circle.Img_third:SetFilledImgAmount(0)
  View.Group_R.Group_circle.Img_other:SetFilledImgAmount(0)
  local index = 0
  DataModel.circleAnim = {}
  if 0 < DataModel.firstNum then
    index = index + 1
    table.insert(DataModel.circleAnim, {
      num = DataModel.firstNum,
      ctrl = View.Group_R.Group_circle.Img_first,
      frame = DataModel.circleAnimFrame[index]
    })
  end
  if 0 < DataModel.secondNum then
    index = index + 1
    table.insert(DataModel.circleAnim, {
      num = DataModel.secondNum,
      ctrl = View.Group_R.Group_circle.Img_scend,
      frame = DataModel.circleAnimFrame[index]
    })
  end
  if 0 < DataModel.thirdNum then
    index = index + 1
    table.insert(DataModel.circleAnim, {
      num = DataModel.thirdNum,
      ctrl = View.Group_R.Group_circle.Img_third,
      frame = DataModel.circleAnimFrame[index]
    })
  end
  if 0 < DataModel.otherNum then
    index = index + 1
    table.insert(DataModel.circleAnim, {
      num = DataModel.otherNum,
      ctrl = View.Group_R.Group_circle.Img_other,
      frame = DataModel.circleAnimFrame[index]
    })
  end
end

function DataModel.RefreshDetail(state)
  View.Group_details:SetActive(state)
  if not state then
    return
  end
  this.SetDetailByType(1)
end

function DataModel.SetDetailByType(type)
  this.SetDetailByAge(type == 1)
  View.Group_details.Group_age:SetActive(type == 1)
  View.Group_details.Group_tad.Group_age.Img_on:SetActive(type == 1)
  this.SetDetailByGender(type == 2)
  View.Group_details.Group_gender:SetActive(type == 2)
  View.Group_details.Group_tad.Group_gender.Img_on:SetActive(type == 2)
  this.SetDetailByPassenger(type == 3)
  View.Group_details.Group_details:SetActive(type == 3)
  View.Group_details.Group_tad.Group_details.Img_on:SetActive(type == 3)
end

local ageTypeList = {
  [12600686] = {
    sort = 1,
    psgList = {},
    consume = 0
  },
  [12600645] = {
    sort = 2,
    psgList = {},
    consume = 0
  },
  [12600676] = {
    sort = 3,
    psgList = {},
    consume = 0
  },
  [12600652] = {
    sort = 4,
    psgList = {},
    consume = 0
  }
}

function DataModel.SetDetailByAge(state)
  if not state then
    return
  end
  for i, v in pairs(ageTypeList) do
    v.psgList = {}
    v.consume = 0
  end
  local psgCA
  for psgUid, psgData in pairs(this.outPsgDataList) do
    psgCA = PlayerData:GetFactoryData(psgData.id, "PassageFactory")
    table.insert(ageTypeList[psgCA.age].psgList, psgData)
    if this.psgConsume[psgUid] then
      for i, consume in pairs(this.psgConsume[psgUid]) do
        ageTypeList[psgCA.age].consume = ageTypeList[psgCA.age].consume + consume
      end
    end
  end
  local sortList = {}
  for i, v in pairs(ageTypeList) do
    table.insert(sortList, v)
  end
  table.sort(sortList, function(a, b)
    return a.sort < b.sort
  end)
  local outPsgNum = table.count(this.outPsgDataList)
  local firstRatio = table.count(sortList[1].psgList) / outPsgNum
  local secondRatio = table.count(sortList[2].psgList) / outPsgNum
  local thirdRatio = table.count(sortList[3].psgList) / outPsgNum
  local otherRatio = table.count(sortList[4].psgList) / outPsgNum
  View.Group_details.Group_age.Group_left.Group_circle.Img_first:SetActive(0 < firstRatio)
  if 0 < firstRatio then
    View.Group_details.Group_age.Group_left.Group_circle.Img_first:SetFilledImgAmount(firstRatio)
  end
  View.Group_details.Group_age.Group_left.Group_circle.Img_scend:SetActive(0 < secondRatio)
  if 0 < secondRatio then
    View.Group_details.Group_age.Group_left.Group_circle.Img_scend:SetFilledImgAmount(secondRatio + firstRatio)
  end
  View.Group_details.Group_age.Group_left.Group_circle.Img_third:SetActive(0 < thirdRatio)
  if 0 < thirdRatio then
    View.Group_details.Group_age.Group_left.Group_circle.Img_third:SetFilledImgAmount(thirdRatio + secondRatio + firstRatio)
  end
  View.Group_details.Group_age.Group_left.Group_circle.Img_other:SetActive(0 < otherRatio)
  if 0 < otherRatio then
    View.Group_details.Group_age.Group_left.Group_circle.Img_other:SetFilledImgAmount(1)
  end
  local num = 0 < table.count(sortList[1].psgList) and table.count(sortList[1].psgList) or "--"
  local consume = 0 < sortList[1].consume and string.format("%.2f%%", sortList[1].consume / (this.psgConsumeTotalNum + this.ticketNum) * 100) or "--"
  View.Group_details.Group_age.Group_right.Group_list.Group_frist.Txt_num:SetText(num)
  View.Group_details.Group_age.Group_right.Group_list.Group_frist.Txt_consume:SetText(consume)
  num = 0 < table.count(sortList[2].psgList) and table.count(sortList[2].psgList) or "--"
  consume = 0 < sortList[2].consume and string.format("%.2f%%", sortList[2].consume / (this.psgConsumeTotalNum + this.ticketNum) * 100) or "--"
  View.Group_details.Group_age.Group_right.Group_list.Group_scend.Txt_num:SetText(num)
  View.Group_details.Group_age.Group_right.Group_list.Group_scend.Txt_consume:SetText(consume)
  num = 0 < table.count(sortList[3].psgList) and table.count(sortList[3].psgList) or "--"
  consume = 0 < sortList[3].consume and string.format("%.2f%%", sortList[3].consume / (this.psgConsumeTotalNum + this.ticketNum) * 100) or "--"
  View.Group_details.Group_age.Group_right.Group_list.Group_third.Txt_num:SetText(num)
  View.Group_details.Group_age.Group_right.Group_list.Group_third.Txt_consume:SetText(consume)
  num = 0 < table.count(sortList[4].psgList) and table.count(sortList[4].psgList) or "--"
  consume = 0 < sortList[4].consume and string.format("%.2f%%", sortList[4].consume / (this.psgConsumeTotalNum + this.ticketNum) * 100) or "--"
  View.Group_details.Group_age.Group_right.Group_list.Group_fourth.Txt_num:SetText(num)
  View.Group_details.Group_age.Group_right.Group_list.Group_fourth.Txt_consume:SetText(consume)
end

local genderTypeList = {
  [12600646] = {
    sort = 1,
    psgList = {},
    consume = 0
  },
  [12600653] = {
    sort = 2,
    psgList = {},
    consume = 0
  },
  [12600667] = {
    sort = 3,
    psgList = {},
    consume = 0
  }
}

function DataModel.SetDetailByGender(state)
  if not state then
    return
  end
  for i, v in pairs(genderTypeList) do
    v.psgList = {}
    v.consume = 0
  end
  local psgCA
  for psgUid, psgData in pairs(this.outPsgDataList) do
    psgCA = PlayerData:GetFactoryData(psgData.id, "PassageFactory")
    table.insert(genderTypeList[psgCA.gender].psgList, psgData)
    if this.psgConsume[psgUid] then
      for i, consume in pairs(this.psgConsume[psgUid]) do
        genderTypeList[psgCA.gender].consume = genderTypeList[psgCA.gender].consume + consume
      end
    end
  end
  local sortList = {}
  for i, v in pairs(genderTypeList) do
    table.insert(sortList, v)
  end
  table.sort(sortList, function(a, b)
    return a.sort < b.sort
  end)
  local outPsgNum = table.count(this.outPsgDataList)
  local firstRatio = table.count(sortList[1].psgList) / outPsgNum
  local secondRatio = table.count(sortList[2].psgList) / outPsgNum
  local thirdRatio = table.count(sortList[3].psgList) / outPsgNum
  View.Group_details.Group_gender.Group_left.Group_circle.Img_first:SetActive(0 < firstRatio)
  if 0 < firstRatio then
    View.Group_details.Group_gender.Group_left.Group_circle.Img_first:SetFilledImgAmount(firstRatio)
  end
  View.Group_details.Group_gender.Group_left.Group_circle.Img_scend:SetActive(0 < secondRatio)
  if 0 < secondRatio then
    View.Group_details.Group_gender.Group_left.Group_circle.Img_scend:SetFilledImgAmount(secondRatio + firstRatio)
  end
  View.Group_details.Group_gender.Group_left.Group_circle.Img_third:SetActive(0 < thirdRatio)
  if 0 < thirdRatio then
    View.Group_details.Group_gender.Group_left.Group_circle.Img_third:SetFilledImgAmount(1)
  end
  local num = 0 < table.count(sortList[1].psgList) and table.count(sortList[1].psgList) or "--"
  local consume = 0 < sortList[1].consume and string.format("%.2f%%", sortList[1].consume / (this.psgConsumeTotalNum + this.ticketNum) * 100) or "--"
  View.Group_details.Group_gender.Group_right.Group_list.Group_frist.Txt_num:SetText(num)
  View.Group_details.Group_gender.Group_right.Group_list.Group_frist.Txt_consume:SetText(consume)
  num = 0 < table.count(sortList[2].psgList) and table.count(sortList[2].psgList) or "--"
  consume = 0 < sortList[2].consume and string.format("%.2f%%", sortList[2].consume / (this.psgConsumeTotalNum + this.ticketNum) * 100) or "--"
  View.Group_details.Group_gender.Group_right.Group_list.Group_scend.Txt_num:SetText(num)
  View.Group_details.Group_gender.Group_right.Group_list.Group_scend.Txt_consume:SetText(consume)
  num = 0 < table.count(sortList[3].psgList) and table.count(sortList[3].psgList) or "--"
  consume = 0 < sortList[3].consume and string.format("%.2f%%", sortList[3].consume / (this.psgConsumeTotalNum + this.ticketNum) * 100) or "--"
  View.Group_details.Group_gender.Group_right.Group_list.Group_third.Txt_num:SetText(num)
  View.Group_details.Group_gender.Group_right.Group_list.Group_third.Txt_consume:SetText(consume)
  local maxConsume = 0
  for i, v in ipairs(sortList) do
    maxConsume = maxConsume < v.consume and v.consume or maxConsume
  end
  View.Group_details.Group_gender.Group_bottom.Group_GenderSort.Img_gender1:SetActive(sortList[1].consume == maxConsume)
  View.Group_details.Group_gender.Group_bottom.Group_GenderSort.Img_gender2:SetActive(sortList[2].consume == maxConsume)
  View.Group_details.Group_gender.Group_bottom.Group_GenderSort.Img_gender3:SetActive(sortList[3].consume == maxConsume)
end

DataModel.psgDetailSortList = {}
local SetPsgDetailList = function(list)
  if table.count(list) == 0 then
    return
  end
  local psgList = {}
  local consume = 0
  local key = ""
  for psgUid, psgData in pairs(list) do
    consume = 0
    if this.psgConsume[psgUid] then
      for k, num in pairs(this.psgConsume[psgUid]) do
        if k ~= "ticket" then
          consume = consume + num
        end
      end
    end
    key = string.format("%s_%s_%s", psgData.id, psgData.psg_tag, psgData.origin)
    psgList[key] = psgList[key] or {}
    local ticket = 0
    if this.psgConsume[psgUid] and this.psgConsume[psgUid].ticket then
      ticket = this.psgConsume[psgUid].ticket
    end
    table.insert(psgList[key], {
      psgData = psgData,
      ticket = ticket,
      consume = consume
    })
  end
  local pairsPsgList = {}
  for _, v in pairs(psgList) do
    table.insert(pairsPsgList, v)
  end
  table.sort(pairsPsgList, function(a, b)
    local stationCA1 = PlayerData:GetFactoryData(a[1].psgData.origin, "HomeStationFactory")
    local stationCA2 = PlayerData:GetFactoryData(b[1].psgData.origin, "HomeStationFactory")
    if stationCA1.order ~= stationCA2.order then
      return stationCA1.order < stationCA2.order
    else
      local psgCA1 = PlayerData:GetFactoryData(a[1].psgData.id, "PassageFactory")
      local psgCA2 = PlayerData:GetFactoryData(b[1].psgData.id, "PassageFactory")
      if psgCA1.star ~= psgCA2.star then
        return psgCA1.star > psgCA2.star
      else
        return a[1].psgData.id > b[1].psgData.id
      end
    end
  end)
  for i, v in ipairs(pairsPsgList) do
    table.insert(DataModel.psgDetailSortList, v)
  end
end

function DataModel.SetDetailByPassenger(state)
  if not state then
    return
  end
  this.psgDetailSortList = {}
  local quest = {}
  local leaflet = {}
  local magazine = {}
  local tv = {}
  for psgUid, psgData in pairs(this.outPsgDataList) do
    local city_pid = psgData.city_pid
    if city_pid == "quests" then
      quest[psgUid] = psgData
    elseif city_pid == "magazine" then
      magazine[psgUid] = psgData
    elseif city_pid == "tv" then
      tv[psgUid] = psgData
    else
      leaflet[psgUid] = psgData
    end
  end
  SetPsgDetailList(quest)
  SetPsgDetailList(leaflet)
  SetPsgDetailList(magazine)
  SetPsgDetailList(tv)
  View.Group_details.Group_details.Group_list.ScrollGrid_.grid.self:SetDataCount(#this.psgDetailSortList)
  View.Group_details.Group_details.Group_list.ScrollGrid_.grid.self:RefreshAllElement()
end

function DataModel.NumThousandsSplit(num)
  num = math.floor(num)
  local returnNum = ""
  local flag = 1
  if num < 0 then
    flag = -1
    num = math.abs(num)
  end
  while 1 <= num / 1000 do
    local thousand = num % 1000
    returnNum = "," .. string.format("%03d", thousand) .. returnNum
    num = math.modf(num / 1000)
  end
  returnNum = num * flag .. returnNum
  return returnNum
end

DataModel.Init()
return DataModel
