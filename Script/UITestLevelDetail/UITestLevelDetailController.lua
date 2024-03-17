local View = require("UITestLevelDetail/UITestLevelDetailView")
local DataModel = require("UITestLevelDetail/UITestLevelDetailDataModel")
local Controller = {}
local BattleControlManager, currentRoleIndex

function Controller.OpenRoleCardList(hasOpen)
  View.Group_CharacterCard:SetActive(hasOpen)
end

function Controller.InitView(data)
  BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
  BattleControlManager:Pause(true)
  DataModel.cardList = {}
  DataModel.roles = {}
  local info = BattleControlManager.currentPlayerTeamData.battleData.BattleResult
  if info ~= nil then
    local index = 1
    local temp = {}
    for key, value in pairs(info.cardOrder) do
      temp[index] = value
      index = index + 1
    end
    DataModel.cardList = temp
    local expConfig = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
    index = 1
    for key, value in pairs(info.roleInfoList) do
      temp = {}
      DataModel.roles[index] = temp
      temp.name = value.name
      if table.count(PlayerData:GetRoleById(key)) > 0 then
        temp.face = PlayerData:GetFactoryData(PlayerData:GetRoleById(key).current_skin[1], "UnitViewFactory").face
      else
        temp.face = PlayerData:GetFactoryData(PlayerData:GetFactoryData(key).viewId).face
      end
      local roleId = tostring(key)
      local role = PlayerData.ServerData.roles[roleId] == nil and PlayerData:GetFactoryData(roleId) or PlayerData.ServerData.roles[roleId]
      temp.lv = role.lv or 1
      role.exp = role.exp or 0
      temp.expValue = role.exp / expConfig[temp.lv].levelUpExp
      temp.damage = value.damage
      temp.heal = value.heal
      temp.getHit = value.getHit
      if 0 < info.damageTotal then
        temp.damagePercent = value.damage / info.damageTotal
      else
        temp.damagePercent = 0
      end
      if 0 < info.healTotal then
        temp.healPercent = value.heal / info.healTotal
      else
        temp.healPercent = 0
      end
      if 0 < info.getHitTotal then
        temp.getHitPercent = value.getHit / info.getHitTotal
      else
        temp.getHitPercent = 0
      end
      local count = 1
      temp.cardList = {}
      for key1, value1 in pairs(value.cardOrder) do
        temp.cardList[count] = value1
        count = count + 1
      end
      index = index + 1
    end
    data.healTotal = info.healTotal
    data.getHitTotal = info.getHitTotal
  end
  if DataModel.cardList ~= nil then
    View.Group_Card.ScrollGrid_Card.grid.self:SetDataCount(#DataModel.cardList)
    View.Group_Card.ScrollGrid_Card.grid.self:RefreshAllElement()
  end
  if DataModel.roles ~= nil then
    View.Group_Character.StaticGrid_Character.grid.self:SetDataCount(#DataModel.roles)
    View.Group_Character.StaticGrid_Character.grid.self:RefreshAllElement()
  end
  local duration = (BattleControlManager:GetBattleFrame() - data.duration) / GameSetting.fps
  local hours = math.floor(duration / 3600)
  local minutes = math.floor(duration % 3600 / 60)
  local remainingSeconds = math.floor(duration % 60)
  data.duration = string.format("%02d:%02d:%02d", hours, minutes, remainingSeconds)
  Controller.OpenRoleCardList(false)
  local group = View.Group_Statistics
  group.Txt_TotalTimeNum:SetText(data.duration)
  group.Txt_SkillTotalNum:SetText(data.skillDamageNow)
  group.Txt_SkillDamageNum:SetText(data.skillDamageMax)
  group.Txt_10sDamageNum:SetText(data.damageTotalAt10s)
  group.Txt_UseCardNum:SetText(data.usedCards)
  group.Txt_CostNum:SetText(data.usedCost)
  local groupCharacter = View.Group_Character
  groupCharacter.Txt_TotalNum:SetText(data.damageTotal)
  groupCharacter.Txt_TotalHealNum:SetText(data.healTotal)
  groupCharacter.Txt_TotalHitNum:SetText(data.getHitTotal)
end

local SetCardInfo = function(view, data)
  view.Img_MaskCharacter.Img_Character:SetSprite(data.roleResPath)
  view.Img_CardType:SetSprite(data.cardTypePath)
  view.Group_SkillIcon.Img_MaskSkill.Img_Skill:SetSprite(data.iconPath)
  local isDouble = data.cost1Path ~= ""
  local cost1 = view.Group_Cost.Img_Cost1
  cost1:SetActive(isDouble)
  if isDouble then
    cost1:SetSprite(data.cost1Path)
    cost1:SetLocalPosition(Vector3(data.x1, 0, 0))
    cost1:SetWidthHeight(data.width1, data.height1)
  end
  local cost2 = view.Group_Cost.Img_Cost2
  cost2:SetSprite(data.cost2Path)
  cost2:SetLocalPosition(Vector3(data.x2, 0, 0))
  cost2:SetWidthHeight(data.width2, data.height2)
  view.Img_NoCostSign:SetActive(false)
  view.Img_LeaderCardSign:SetActive(false)
end

function Controller.SetElement(element, elementIndex)
  SetCardInfo(element, DataModel.cardList[elementIndex])
end

function Controller.SetRolesElement(element, elementIndex)
  local data = DataModel.roles[elementIndex]
  element.Img_Mask.Img_Face:SetSprite(data.face)
  element.Img_Exp.Img_Now:SetFilledImgAmount(data.expValue)
  element.Group_Lv.Txt_Num:SetText(data.lv)
  element.Img_Damage.Txt_Num:SetText(data.damage)
  element.Img_Damage.Txt_Percent:SetText(math.floor(data.damagePercent * 100 + 0.5) .. "%")
  element.Img_Damage.Img_Now:SetFilledImgAmount(data.damagePercent)
  element.Img_Heal.Txt_Num:SetText(data.heal)
  element.Img_Heal.Txt_Percent:SetText(math.floor(data.healPercent * 100 + 0.5) .. "%")
  element.Img_Heal.Img_Now:SetFilledImgAmount(data.healPercent)
  element.Img_Hit.Txt_Num:SetText(data.getHit)
  element.Img_Hit.Txt_Percent:SetText(math.floor(data.getHitPercent * 100 + 0.5) .. "%")
  element.Img_Hit.Img_Now:SetFilledImgAmount(data.getHitPercent)
  element.Txt_Name:SetText(data.name)
end

function Controller.OnClickRole(index)
  currentRoleIndex = index
  Controller.OpenRoleCardList(true)
  View.Group_CharacterCard.ScrollGrid_Card.grid.self:SetDataCount(#DataModel.roles[index].cardList)
  View.Group_CharacterCard.ScrollGrid_Card.grid.self:RefreshAllElement()
end

function Controller.SetRoleCardElement(element, elementIndex)
  SetCardInfo(element, DataModel.roles[currentRoleIndex].cardList[elementIndex])
end

function Controller.Destroy()
  BattleControlManager:Pause(false)
  BattleControlManager = nil
end

return Controller
