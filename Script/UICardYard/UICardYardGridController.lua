local View = require("UICardYard/UICardYardView")
local DataModel = require("UICardYard/UICardYardDataModel")
local Controller = {}
local color_config = {
  Red = {des = "红卡 ", index = 1},
  Blue = {des = "蓝卡 ", index = 2},
  Green = {des = "绿卡 ", index = 4},
  Yellow = {des = "黄卡 ", index = 3},
  Purple = {des = "紫卡 ", index = 5},
  Black = {des = "黑卡 ", index = 6}
}

function Controller.RefreshGrids()
  local count = table.count(DataModel.Current)
  DataModel.txtPosY = View.Group_Left.Txt_CardDesc.Rect.anchoredPosition.y
  if 0 < count then
    DataModel.selectId = DataModel.Current[1].cardId
    Controller.RefreshCardInfo(1)
    View.Group_Left:SetActive(true)
  else
    DataModel.selectId = 1
    View.Group_Left:SetActive(false)
  end
  View.ScrollGrid_CardYard.grid.self:SetDataCount(count)
  View.ScrollGrid_CardYard.grid.self:RefreshAllElement()
  View.CardDesCharacter.self:SetActive(false)
  View.Btn_Close_Skill.self:SetActive(false)
  local isShow = DataModel.currentState == DataModel.Enum.Grave
  View.Btn_CardCemetery.Img_On:SetActive(isShow)
  View.Btn_CardYard.Img_On:SetActive(isShow)
  local colorData = {}
  for k, v in pairs(DataModel.Current) do
    if v.cardId ~= nil then
      local cardData = PlayerData:GetFactoryData(v.cardId)
      if colorData[cardData.color] == nil then
        colorData[cardData.color] = {}
        colorData[cardData.color].num = v.num
        colorData[cardData.color].tip = color_config[tostring(cardData.color)].des
        colorData[cardData.color].index = color_config[tostring(cardData.color)].index
      else
        colorData[cardData.color].num = colorData[cardData.color].num + v.num
      end
    end
  end
  DataModel.CardColorData = {}
  local count = 1
  for k, v in pairs(colorData) do
    local row = {}
    row.des = v.tip .. v.num .. "张"
    row.index = v.index
    DataModel.CardColorData[count] = row
    count = count + 1
  end
  table.sort(DataModel.CardColorData, function(a, b)
    return a.index < b.index
  end)
  View.StaticGrid_Left.grid.self:SetDataCount(table.count(DataModel.CardColorData))
  View.StaticGrid_Left.grid.self:RefreshAllElement()
end

function Controller.SetElement(element, index)
  local data = DataModel.Current[index]
  local battleConfig = PlayerData:GetFactoryData(99900008, "ConfigFactory")
  local numCA = PlayerData:GetFactoryData(battleConfig.cardCostNormalID, "BattleInfoFactory")
  local card = PlayerData:GetFactoryData(data.cardId, "CardFactory")
  local skillCA = PlayerData:GetFactoryData(data.skillId)
  local imgCharater = element.Group_Card.Group_Front.Img_MaskCharacter.Img_Character
  local curRole = PlayerData:GetRoleById(data.roleId)
  local bg
  if curRole and curRole.current_skin then
    bg = PlayerData:GetFactoryData(curRole.current_skin[1], "UnitViewFactory").roleListResUrl
  else
    local viewId = PlayerData:GetFactoryData(data.roleId).viewId
    local viewCA = PlayerData:GetFactoryData(viewId)
    if viewCA ~= nil and viewCA.roleListResUrl ~= nil and viewCA.roleListResUrl ~= "" then
      bg = PlayerData:GetFactoryData(viewId).roleListResUrl
    else
      bg = PlayerData:GetFactoryData(99900008, "ConfigFactory").teamCardPath
    end
  end
  imgCharater:SetSprite(bg)
  element.Group_Card.Group_Front.Group_SkillIcon.Img_MaskSkill.Img_Skill:SetSprite(card.iconPath)
  element.Txt_Num:SetText(data.num)
  element.Txt_Name:SetText(skillCA.name)
  element.Group_Card.Group_Front.Group_SkillIcon.Img_MaskSkill.Img_Skill:SetColor(Color.white)
  if card.color == "Red" then
    element.Group_Card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeRedPath)
    element.Group_Card.Group_Front.Group_SkillIcon.Img_MaskSkill.Img_Skill:SetColor(GameSetting.redCardColor)
  elseif card.color == "Yellow" then
    element.Group_Card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeYellowPath)
  elseif card.color == "Green" then
    element.Group_Card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeGreenPath)
  elseif card.color == "Blue" then
    element.Group_Card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeBluePath)
  elseif card.color == "Purple" then
    element.Group_Card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypePurplePath)
  elseif card.color == "Black" then
    element.Group_Card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeBlackPath)
  end
  local tWidth = 0
  local cost = card.cost_SN
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
  element.Group_Card.Group_Front.Group_Cost.Img_Cost2:SetSprite(numTextCA.resStr)
  if cost1 < 1 then
    element.Group_Card.Group_Front.Group_Cost.Img_Cost2:SetLocalPositionX(0)
    element.Group_Card.Group_Front.Group_Cost.Img_Cost1:SetActive(false)
  else
    element.Group_Card.Group_Front.Group_Cost.Img_Cost1:SetActive(true)
    numTextCA = GetNumRes(cost1, numCA)
    tWidth = tWidth + numTextCA.width + numCA.interval
    element.Group_Card.Group_Front.Group_Cost.Img_Cost1:SetSprite(numTextCA.resStr)
    element.Group_Card.Group_Front.Group_Cost.Img_Cost1:SetLocalPositionX(numTextCA.width / 2 - tWidth / 2)
    element.Group_Card.Group_Front.Group_Cost.Img_Cost2:SetLocalPositionX(tWidth / 2 - numTextCA.width / 2)
  end
  element.Group_Card.Group_Front.Img_LeaderCardSign:SetActive(data.isLeaderCard)
  element.Group_Card.Group_Front.Img_Cooldown:SetActive(false)
  if DataModel.selectId == data.cardId then
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
  local data = DataModel.Current[index]
  local skillConfig = PlayerData:GetFactoryData(data.skillId)
  local skillName = skillConfig.name
  local skillDes = data.des
  local cardConfig = PlayerData:GetFactoryData(skillConfig.cardID)
  local costNum = math.floor(cardConfig.cost_SN)
  local iconPath = skillConfig.iconPath
  View.Group_Left.Img_Icon:SetSprite(iconPath)
  View.Group_Left.Img_CardNameBg.Txt_CardName:SetText(skillName)
  View.Group_Left.Txt_CardCost:SetText(string.format("COST  <size=40>%d</size>", costNum))
  View.Group_Left.Txt_CardDesc:SetText(skillDes)
  View.Group_Left.Img_CardNameBg.Txt_CardNum:SetText(string.format(GetText(80600767), data.num))
  DataModel:GetSkillTagList(skillConfig.cardID)
  View.Group_Left.ScrollGrid_.grid.self:SetDataCount(#DataModel.skillTagList)
  View.Group_Left.ScrollGrid_.grid.self:RefreshAllElement()
  local txtHeight = View.Group_Left.Txt_CardDesc:GetHeight()
  View.Group_Left.ScrollGrid_.grid.self:SetLocalPositionY(DataModel.txtPosY - txtHeight - 30)
  DataModel.selectId = data.cardId
end

function Controller.CardBtn(btn, index)
  local data = DataModel.Current[index]
  if DataModel.selectId ~= data.cardId then
    View.nowSeletImg = btn.transform.parent:Find("Img_HighLight")
    View.nowSeletImg.gameObject:SetActive(true)
    if View.lastSeletImg then
      View.lastSeletImg.gameObject:SetActive(false)
    end
    View.lastSeletImg = View.nowSeletImg
    Controller.RefreshCardInfo(index)
  end
end

return Controller
