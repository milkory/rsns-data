local View = require("UISquads/UISquadsView")
local DateModel = require("UISquads/UISquadsDataModel")
local Controller = {}
local color_config = {
  Red = {des = "红卡 ", index = 1},
  Blue = {des = "蓝卡 ", index = 2},
  Green = {des = "绿卡 ", index = 4},
  Yellow = {des = "黄卡 ", index = 3},
  Purple = {des = "紫卡 ", index = 5}
}
local RefreshData = function()
  local index = 0
  local cardNum = 0
  if DateModel.isRefreshSkillList == true then
    local cardPoolData = {}
    local colorData = {}
    for k, v in pairs(DateModel.curSquad) do
      if v.unitId ~= nil then
        local id = tonumber(v.unitId)
        local bg = PlayerData:GetFactoryData(PlayerData:GetRoleById(id).current_skin[1], "UnitViewFactory").roleListResUrl
        local skillList = PlayerData:GetCardDes(v.unitId)
        for k1, v1 in pairs(skillList) do
          local skillId = skillList[k1].id
          local skillFactory = PlayerData:GetFactoryData(skillId, "SkillFactory")
          if skillFactory.cardID ~= nil then
            index = index + 1
            local data = {}
            local cardData = PlayerData:GetFactoryData(skillFactory.cardID, "CardFactory")
            data.bg = bg
            data.icon = skillFactory.iconPath
            data.id = skillId
            data.des = skillList[k1].des
            data.roleId = id
            data.index = k1
            data.name = skillFactory.name
            data.num = PlayerData:GetFactoryData(id, "UnitFactory").skillList[k1].num or 1
            data.color = cardData.color
            data.cost = cardData.cost_SN
            if k1 == 3 then
              data.isLeaderCard = true
            else
              data.isLeaderCard = false
            end
            cardNum = cardNum + data.num
            data.cardId = skillFactory.cardID
            data.cardData = cardData
            cardPoolData[index] = data
            if colorData[cardData.color] == nil then
              colorData[cardData.color] = {}
              colorData[cardData.color].num = data.num
              colorData[cardData.color].tip = color_config[tostring(cardData.color)].des
              colorData[cardData.color].index = color_config[tostring(cardData.color)].index
            else
              colorData[cardData.color].num = colorData[cardData.color].num + data.num
            end
          end
        end
      end
    end
    DateModel.CardPool = cardPoolData
    DateModel.CardColorData = {}
    local count = 1
    for k, v in pairs(colorData) do
      local row = {}
      row.des = v.tip .. v.num .. "张"
      row.index = v.index
      DateModel.CardColorData[count] = row
      count = count + 1
    end
    table.sort(DateModel.CardColorData, function(a, b)
      return a.index < b.index
    end)
  end
  DateModel.txtPosY = View.Group_CardYard.Group_Left.Txt_CardDesc.Rect.anchoredPosition.y
  View.lastSeletImg = nil
  View.nowSeletImg = nil
  if 0 < table.count(DateModel.CardPool) then
    DateModel.selectId = DateModel.CardPool[1].cardId
    Controller.RefreshCardInfo(1)
    View.Group_CardYard.Group_YardTitle.Txt_:SetText(string.format(GetText(80600769), cardNum))
  else
    DateModel.selectId = 1
    CommonTips.OpenTips(80600768)
    Controller:OpenView(false)
    return
  end
  View.Group_CardYard.ScrollGrid_CardYard.grid.self:SetDataCount(table.count(DateModel.CardPool))
  View.Group_CardYard.ScrollGrid_CardYard.grid.self:RefreshAllElement()
  View.Group_CardYard.StaticGrid_Left.grid.self:SetDataCount(table.count(DateModel.CardColorData))
  View.Group_CardYard.StaticGrid_Left.grid.self:RefreshAllElement()
  DateModel.isRefreshSkillList = false
end

function Controller:SetElement(element, index)
  local data = DateModel.CardPool[index]
  local card = element.Group_Card
  local battleConfig = PlayerData:GetFactoryData(99900008, "ConfigFactory")
  local skillCA = PlayerData:GetFactoryData(data.id)
  local numCA = PlayerData:GetFactoryData(battleConfig.cardCostNormalID, "BattleInfoFactory")
  card.Group_Front.Img_MaskCharacter.Img_Character:SetSprite(data.bg)
  card.Group_Front.Group_SkillIcon.Img_MaskSkill.Img_Skill:SetSprite(data.icon)
  element.Txt_Num:SetText(data.num)
  element.Txt_Name:SetText(skillCA.name)
  card.Group_Front.Group_SkillIcon.Img_MaskSkill.Img_Skill:SetColor(Color.white)
  if data.color == "Red" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeRedPath)
    card.Group_Front.Group_SkillIcon.Img_MaskSkill.Img_Skill:SetColor(GameSetting.redCardColor)
  elseif data.color == "Yellow" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeYellowPath)
  elseif data.color == "Green" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeGreenPath)
  elseif data.color == "Blue" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeBluePath)
  elseif data.color == "Purple" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypePurplePath)
  elseif data.color == "Black" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeBlackPath)
  end
  local tWidth = 0
  local cost = data.cost
  if 99 < cost then
    cost = 99
  end
  if cost < 0 then
    cost = 0
  end
  local cost1 = math.floor(cost / 10)
  local cost2 = math.floor(cost % 10)
  local numTextCA = GetNumRes(cost2, numCA)
  tWidth = numTextCA.width
  card.Group_Front.Group_Cost.Img_Cost2:SetSprite(numTextCA.resStr)
  if cost1 < 1 then
    card.Group_Front.Group_Cost.Img_Cost2:SetLocalPositionX(0)
    card.Group_Front.Group_Cost.Img_Cost1:SetActive(false)
  else
    card.Group_Front.Group_Cost.Img_Cost1:SetActive(true)
    numTextCA = GetNumRes(cost1, numCA)
    tWidth = tWidth + numTextCA.width + numCA.interval
    card.Group_Front.Group_Cost.Img_Cost1:SetSprite(numTextCA.resStr)
    card.Group_Front.Group_Cost.Img_Cost1:SetLocalPositionX(numTextCA.width / 2 - tWidth / 2)
    card.Group_Front.Group_Cost.Img_Cost2:SetLocalPositionX(tWidth / 2 - numTextCA.width / 2)
  end
  card.Group_Front.Img_LeaderCardSign:SetActive(data.isLeaderCard)
  card.Group_Front.Img_Cooldown:SetActive(false)
  if DateModel.selectId == data.cardId then
    element.Img_HighLight:SetActive(true)
    View.lastSeletImg = element.Img_HighLight.transform
  else
    element.Img_HighLight:SetActive(false)
  end
end

function GetNumRes(num, numCA)
  num = math.floor(num)
  rt = PlayerData:GetFactoryData(numCA["num" .. tostring(num) .. "Id"], "BattleTextFactory")
  return rt
end

function Controller.RefreshCardInfo(index)
  local data = DateModel.CardPool[index]
  local skillName = data.name
  local skillDes = data.des
  local cardConfig = data.cardData
  local costNum = math.floor(cardConfig.cost_SN)
  local iconPath = data.icon
  View.Group_CardYard.Group_Left.Img_Icon:SetSprite(iconPath)
  View.Group_CardYard.Group_Left.Img_CardNameBg.Txt_CardName:SetText(skillName)
  View.Group_CardYard.Group_Left.Txt_CardCost:SetText(string.format("COST  <size=40>%d</size>", costNum))
  View.Group_CardYard.Group_Left.Txt_CardDesc:SetText(skillDes)
  View.Group_CardYard.Group_Left.Img_CardNameBg.Txt_CardNum:SetText(string.format(GetText(80600767), data.num))
  DateModel:GetSkillTagList(data.cardId)
  View.Group_CardYard.Group_Left.ScrollGrid_.grid.self:SetDataCount(#DateModel.skillTagList)
  View.Group_CardYard.Group_Left.ScrollGrid_.grid.self:RefreshAllElement()
  DateModel.selectId = data.cardId
  local txtHeight = View.Group_CardYard.Group_Left.Txt_CardDesc:GetHeight()
  View.Group_CardYard.Group_Left.ScrollGrid_.grid.self:SetLocalPositionY(DateModel.txtPosY - txtHeight - 30)
end

function Controller:CardBtn(btn, index)
  local data = DateModel.CardPool[index]
  if DateModel.selectId ~= data.cardId then
    View.nowSeletImg = btn.transform.parent:Find("Img_HighLight")
    View.nowSeletImg.gameObject:SetActive(true)
    if View.lastSeletImg then
      View.lastSeletImg.gameObject:SetActive(false)
    end
    View.lastSeletImg = View.nowSeletImg
    Controller.RefreshCardInfo(index)
  end
end

function Controller:OpenView(hasOpen)
  if hasOpen then
    UIManager:LoadSplitPrefab(View, "UI/Squads/Squads", "Group_CardYard")
  end
  View.Group_CardYard:SetActive(hasOpen)
  View.Group_CommonTopLeft.Btn_Return:SetActive(not hasOpen)
  if hasOpen then
    RefreshData()
    View.Group_CardYard.Group_CardDesCharacter.self:SetActive(false)
    View.Group_CardYard.Btn_Close_Skill.self:SetActive(false)
  elseif View.Group_CardYard.ScrollGrid_CardYard ~= nil then
    View.Group_CardYard.ScrollGrid_CardYard.grid.self:MoveToTop()
  end
end

return Controller
