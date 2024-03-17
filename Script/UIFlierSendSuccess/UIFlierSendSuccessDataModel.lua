local View = require("UIFlierSendSuccess/UIFlierSendSuccessView")
local DataModel = {}
local this = DataModel
DataModel.sendType = 0
DataModel.addPsgList = {}
DataModel.addPsgNum = 0

function DataModel.InitData(json)
  if not json then
    return
  end
  local data = Json.decode(json)
  this.addPsgList = data.add_passenger
  this.sendType = data.sendType
  this.addPsgNum = 0
  for i, v in pairs(data.add_passenger) do
    this.addPsgNum = this.addPsgNum + table.count(v)
  end
end

function DataModel.RefreshOnShow()
  View.GroupResult.Group_bottom.Group_passengerNum.Txt_passengerNum:SetText(this.addPsgNum)
  local num = 0
  if this.sendType == 0 then
    num = PlayerData.GetLeafLetNum()
  elseif this.sendType == 1 then
    num = PlayerData:GetGoodsById(11400072).num
  elseif this.sendType == 2 then
    num = PlayerData:GetGoodsById(11400072).num
  end
  View.GroupResult.Group_L.Group_bubble.Group_num.Txt_:SetText(tonumber(num))
  this.RefreshSitNum()
  this.RefreshPassengerLike()
  this.RefreshConsume()
  this.RefreshLeft()
  local sound = SoundManager:CreateSound(30002761)
  if sound ~= nil then
    sound:Play()
  end
end

function DataModel.RefreshLeft()
  local config
  if this.sendType == 0 then
    config = PlayerData:GetFactoryData(99900061, "ConfigFactory").leafletEnd[1]
  elseif this.sendType == 1 then
    config = PlayerData:GetFactoryData(99900061, "ConfigFactory").MagazineEnd[1]
  elseif this.sendType == 2 then
    config = PlayerData:GetFactoryData(99900061, "ConfigFactory").tvEnd[1]
  end
  if config then
    View.GroupResult.Group_L.Img_BgL:SetSprite(config.icon)
    local bubbleTxt = PlayerData:GetFactoryData(config.bubbleId, "TextFactory").text
    View.GroupResult.Group_L.Group_bubble.Txt_:SetText(bubbleTxt)
    View.GroupResult.Group_L.Group_bubble.Group_num.Img_:SetSprite(config.bubbleIcon)
    local successTxt = PlayerData:GetFactoryData(config.endId, "TextFactory").text
    View.GroupResult.Group_bottom.Group_topic.Txt_success:SetText(successTxt)
    local successEnglishTxt = PlayerData:GetFactoryData(config.endEnId, "TextFactory").text
    View.GroupResult.Group_bottom.Group_topic.Txt_en:SetText(successEnglishTxt)
  end
end

local totalSitNum = 16

function DataModel.RefreshSitNum()
  View.GroupResult.Group_center.Group_upper.Group_num.Txt_:SetText(string.format("%d/%d", PlayerData:GetCurPassengerNum(), PlayerData:GetMaxPassengerNum()))
  local fullRatio = PlayerData:GetCurPassengerNum() / PlayerData:GetMaxPassengerNum()
  local fullNum = math.ceil(totalSitNum * fullRatio)
  for i = 1, totalSitNum do
    View.GroupResult.Group_center.Group_upper.Group_seat["Img_seat" .. i]:SetActive(i <= fullNum)
  end
end

DataModel.likeNumList = {
  comfort = 0,
  plantScores = 0,
  fishScores = 0,
  petScores = 0,
  foodScores = 0,
  playScores = 0,
  medicalScores = 0,
  arm = 0,
  clean = 0
}
local GetCommonSum = function(psgCfg, tagCfg)
  local psgCANum = 0
  local tagCANum = 0
  for i, v in pairs(psgCfg) do
    psgCANum = psgCANum + v.common
  end
  for i, v in pairs(tagCfg) do
    tagCANum = tagCANum + v.common
  end
  return psgCANum + tagCANum
end
local SetLevel = function(ctrl, level)
  for i = 1, 5 do
    local child = ctrl.transform:Find("Img_lv" .. i).gameObject
    child:SetActive(i <= level)
  end
end

function DataModel.RefreshPassengerLike()
  local psgCA, tagCA
  for i, v in pairs(this.addPsgList) do
    for _, psgData in pairs(v) do
      psgCA = PlayerData:GetFactoryData(psgData.id, "PassageFactory")
      tagCA = PlayerData:GetFactoryData(psgData.psg_tag, "ListFactory")
      if GetCommonSum(psgCA.comfort, tagCA.comfort) > 0 then
        this.likeNumList.comfort = this.likeNumList.comfort + 1
      end
      if 0 < GetCommonSum(psgCA.plantScores, tagCA.plantScores) then
        this.likeNumList.plantScores = this.likeNumList.plantScores + 1
      end
      if 0 < GetCommonSum(psgCA.fishScores, tagCA.fishScores) then
        this.likeNumList.fishScores = this.likeNumList.fishScores + 1
      end
      if 0 < GetCommonSum(psgCA.petScores, tagCA.petScores) then
        this.likeNumList.petScores = this.likeNumList.petScores + 1
      end
      if 0 < GetCommonSum(psgCA.foodScores, tagCA.foodScores) then
        this.likeNumList.foodScores = this.likeNumList.foodScores + 1
      end
      if 0 < GetCommonSum(psgCA.playScores, tagCA.playScores) then
        this.likeNumList.playScores = this.likeNumList.playScores + 1
      end
      if 0 < GetCommonSum(psgCA.medicalScores, tagCA.medicalScores) then
        this.likeNumList.medicalScores = this.likeNumList.medicalScores + 1
      end
      if 0 < GetCommonSum(psgCA.arm, tagCA.arm) then
        this.likeNumList.arm = this.likeNumList.arm + 1
      end
      if 0 < GetCommonSum(psgCA.clean, tagCA.clean) then
        this.likeNumList.clean = this.likeNumList.clean + 1
      end
    end
  end
  SetLevel(View.GroupResult.Group_center.Group_under.Group_like.Group_arm, math.ceil(this.likeNumList.arm / DataModel.addPsgNum * 5))
  SetLevel(View.GroupResult.Group_center.Group_under.Group_like.Group_medical, math.ceil(this.likeNumList.medicalScores / DataModel.addPsgNum * 5))
  SetLevel(View.GroupResult.Group_center.Group_under.Group_like.Group_play, math.ceil(this.likeNumList.playScores / DataModel.addPsgNum * 5))
  SetLevel(View.GroupResult.Group_center.Group_under.Group_like.Group_food, math.ceil(this.likeNumList.foodScores / DataModel.addPsgNum * 5))
  SetLevel(View.GroupResult.Group_center.Group_under.Group_like.Group_pet, math.ceil(this.likeNumList.petScores / DataModel.addPsgNum * 5))
  SetLevel(View.GroupResult.Group_center.Group_under.Group_like.Group_fish, math.ceil(this.likeNumList.fishScores / DataModel.addPsgNum * 5))
  SetLevel(View.GroupResult.Group_center.Group_under.Group_like.Group_plant, math.ceil(this.likeNumList.plantScores / DataModel.addPsgNum * 5))
  SetLevel(View.GroupResult.Group_center.Group_under.Group_like.Group_comfort, math.ceil(this.likeNumList.comfort / DataModel.addPsgNum * 5))
  SetLevel(View.GroupResult.Group_center.Group_under.Group_like.Group_clean, math.ceil(this.likeNumList.clean / DataModel.addPsgNum * 5))
end

local GetPaySum = function(psgCfg, tagCfg)
  local psgCANum = 0
  local tagCANum = 0
  for i, v in pairs(psgCfg) do
    psgCANum = psgCANum + v.pay
  end
  for i, v in pairs(tagCfg) do
    tagCANum = tagCANum + v.pay
  end
  return psgCANum + tagCANum
end
DataModel.psgPayList = {}
DataModel.totalPay = 0

function DataModel.RefreshConsume()
  local psgCA, tagCA, comfort, plant, fish, pet, food, play, medical, arm, clean
  DataModel.psgPayList = {}
  DataModel.totalPay = 0
  for _, v in pairs(this.addPsgList) do
    for _, psgData in pairs(v) do
      psgCA = PlayerData:GetFactoryData(psgData.id, "PassageFactory")
      tagCA = PlayerData:GetFactoryData(psgData.psg_tag, "TagFactory")
      comfort = GetPaySum(psgCA.comfort, tagCA.comfort)
      plant = GetPaySum(psgCA.plantScores, tagCA.plantScores)
      fish = GetPaySum(psgCA.fishScores, tagCA.fishScores)
      pet = GetPaySum(psgCA.petScores, tagCA.petScores)
      food = GetPaySum(psgCA.foodScores, tagCA.foodScores)
      play = GetPaySum(psgCA.playScores, tagCA.playScores)
      medical = GetPaySum(psgCA.medicalScores, tagCA.medicalScores)
      arm = GetPaySum(psgCA.arm, tagCA.arm)
      clean = GetPaySum(psgCA.clean, tagCA.clean)
      if not DataModel.psgPayList[psgCA.career] then
        DataModel.psgPayList[psgCA.career] = comfort + plant + fish + pet + food + play + medical + arm + clean
      else
        DataModel.psgPayList[psgCA.career] = DataModel.psgPayList[psgCA.career] + comfort + plant + fish + pet + food + play + medical + arm + clean
      end
    end
    DataModel.totalPay = DataModel.totalPay + DataModel.psgPayList[psgCA.career]
  end
  if #this.addPsgList > 1 then
    table.sort(this.addPsgList, function(a, b)
      local psgCA1 = PlayerData:GetFactoryData(a[1].id, "PassageFactory")
      local psgCA2 = PlayerData:GetFactoryData(b[1].id, "PassageFactory")
      return DataModel.psgPayList[psgCA1.career] > DataModel.psgPayList[psgCA2.career]
    end)
  end
  View.GroupResult.Group_R.ScrollGrid_list.grid.self:SetDataCount(table.count(this.addPsgList))
  View.GroupResult.Group_R.ScrollGrid_list.grid.self:RefreshAllElement()
end

return DataModel
