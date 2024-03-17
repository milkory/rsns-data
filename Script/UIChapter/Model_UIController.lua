local View = require("UIChapter/UIChapterView")
local DataModel = require("UIChapter/UIChapterDataModel")
local CommonItem = require("Common/BtnItem")
local SetLevelId = function(id)
  PlayerData.BattleInfo.battleStageId = id
end
local _SetDropData = function(viewItem, dropData)
  if dropData ~= nil then
    local data = {}
    data.id = dropData.itemId or dropData.id
    if dropData.num ~= nil then
      data.num = tostring(dropData.num)
    else
      data.num = tostring(dropData.numMin) .. "-" .. tostring(dropData.numMax)
    end
    data.ca = PlayerData:GetItemById(data.id)
    CommonItem:SetItem(viewItem, data)
    viewItem.Img_First:SetActive(dropData.isfirst)
    viewItem:SetActive(true)
    return
  end
  CommonItem:SetItem(viewItem, dropData)
end
local _DropSort = function(dropList)
  local compareFunc = function(a, b)
    local rareA = PlayerData:GetFactoryData(a.itemId or a.id).qualityInt
    local rareB = PlayerData:GetFactoryData(b.itemId or b.id).qualityInt
    return rareA < rareB and true or false
  end
  local sortedDropList = {}
  for i = 0, #dropList do
    table.insert(sortedDropList, dropList[i])
  end
  Sort.SoryByFuncion(sortedDropList, compareFunc, 1, #sortedDropList)
  return sortedDropList
end
local model = {
  SecondPanel = {
    ShowRank = function(self, rank)
      View.Group_SecondPanel.Group_BottomLeft.Txt_Evaluate1:SetText(rank)
    end,
    ShowDrop = function(self, levelCA, count, isStageCleared)
      local dropList = {}
      if isStageCleared == false then
        local sortedFirstPass = _DropSort(levelCA.firstPassAward)
        local length = count > #sortedFirstPass and #sortedFirstPass or count
        for i = 1, length do
          local row = sortedFirstPass[i]
          row.isfirst = true
          table.insert(dropList, row)
        end
      end
      if count > #dropList then
        local dropTableList = levelCA.dropTableList
        local dropListCA = PlayerData:GetFactoryData(dropTableList[1].listId, "ListFactory")
        local sortedDropList = _DropSort(dropListCA.leveldropList)
        if type(sortedDropList) == "table" and table.count(sortedDropList) ~= 0 then
          for i = 1, count - #dropList do
            local row = sortedDropList[i]
            if row == nil then
              row = {}
            end
            row.isfirst = false
            table.insert(dropList, row)
          end
        end
      end
      local dropItemList = View.Group_SecondPanel.Group_BottomLeft.Group_Drop
      for i = 0, count - 1 do
        local itemStr = "Group_Item_0" .. tostring(i)
        dropItemList[itemStr]:SetActive(false)
        if dropList[i + 1] then
          _SetDropData(dropItemList[itemStr], dropList[i + 1])
        end
      end
      dropList = nil
    end,
    StartBattle = function(current, squadIdx, LCId, eventId)
      local status = {
        Current = current,
        squadIndex = squadIdx,
        hasOpenThreeView = false,
        levelChainId = LCId,
        eventId = eventId
      }
      SetLevelId(DataModel.levelId)
      UIManager:Open("UI/Squads/Squads", Json.encode(status))
    end
  }
}

function model.OpenDropDetails(firstPassAward, dropList)
  View.Group_DropDetails.self:SetActive(true)
  DataModel.dropList = dropList
  DataModel.firstPassAward = firstPassAward
  View.Group_DropDetails.ScrollGrid_Common.grid.self:SetDataCount(table.count(DataModel.dropList))
  View.Group_DropDetails.ScrollGrid_Common.grid.self:RefreshAllElement()
  View.Group_DropDetails.ScrollGrid_First.grid.self:SetDataCount(table.count(DataModel.firstPassAward))
  View.Group_DropDetails.ScrollGrid_First.grid.self:RefreshAllElement()
end

function model.SecondPanel.ShowLevelName(name, subHeading)
  local topRight = View.Group_SecondPanel.Group_Right.Group_TopRight
  if name == nil then
    name = ""
  end
  if subHeading == nil then
    subHeading = ""
  end
  topRight.Txt_Text1_0:SetText(name)
  topRight.Txt_Text2_0:SetText(subHeading)
end

function model.SecondPanel.ShowEnergy(energy, energyMax)
  View.Group_SecondPanel.Group_Right.Group_TopRight.Group_Energy.Txt_Number1:SetText(energy)
  View.Group_SecondPanel.Group_Right.Group_TopRight.Group_Energy.Txt_Number3:SetText(energyMax)
end

function model.SecondPanel.ShowCost(energyStart, energyEnd)
  if energyStart + energyEnd == 0 then
    View.Group_SecondPanel.Group_Right.Group_BottomRight.Btn_StartFight.Group_Energy:SetActive(false)
  else
    View.Group_SecondPanel.Group_Right.Group_BottomRight.Btn_StartFight.Group_Energy:SetActive(true)
    View.Group_SecondPanel.Group_Right.Group_BottomRight.Btn_StartFight.Group_Energy.Txt_Cost:SetText(energyStart + energyEnd)
  end
end

function model.SecondPanel.ShowDescription(description)
  if description == nil then
    description = ""
  end
  local _desc = string.gsub(description, "/n", "\n")
  View.Group_SecondPanel.Group_Right.Group_TopRight.Txt_Desc:SetText(_desc)
end

function model.SecondPanel.ShowBossIcon(levelCA)
  local bossData = PlayerData:GetFactoryData(levelCA.bossId, "UnitFactory")
  if bossData == nil then
    View.Group_SecondPanel.Group_Right.Group_MiddleRight.Btn_BossList.self:SetActive(false)
    return
  end
  local bossList = View.Group_SecondPanel.Group_Right.Group_MiddleRight.Btn_BossList
  bossList.self:SetActive(true)
  local iconUrl = PlayerData:GetFactoryData(bossData.viewId, "UnitViewFactory").face
  bossList.Txt_Text3:SetText(bossData.name)
  bossList.Img_BossIcon:SetSprite(iconUrl)
end

function model:Refresh(levelId, isLCLevel)
  DataModel.levelId = levelId
  View.Group_SecondPanel.self:SetActive(true)
  View.Group_LeftBottom.self:SetActive(false)
  View.Btn_OpenLevelChain.self:SetActive(false)
  local levelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
  local userInfo = PlayerData.ServerData.user_info
  self.SecondPanel.ShowEnergy(userInfo.energy, userInfo.max_energy or userInfo.energy)
  self.SecondPanel.ShowCost(levelCA.energyStart, levelCA.energyEnd)
  self.SecondPanel.ShowLevelName(levelCA.levelName, levelCA.levelChapter)
  self.SecondPanel.ShowDescription(levelCA.description)
  View.Group_SecondPanel.Group_Right.Group_BottomRight.Btn_LevelChainSquad.self:SetActive(isLCLevel)
  View.Group_SecondPanel.Group_Right.Group_BottomRight.Btn_StartLevelChain.self:SetActive(isLCLevel)
  local dropList = {}
  local count = 1
  local max = 6
  local dropTableList = levelCA.dropTableList
  local dropListCA = PlayerData:GetFactoryData(dropTableList[1].listId, "ListFactory")
  local sortedDropList = dropListCA.leveldropList
  for k, v in pairs(sortedDropList) do
    if PlayerData:GetFactoryData(v.id).dropList then
      for c, d in pairs(PlayerData:GetFactoryData(v.itemId).dropList) do
        dropList[count] = d
        dropList[count].isUnique = true
        dropList[count].num = 1
        dropList[count].itemId = d.id
        count = count + 1
      end
    else
      dropList[count] = v
      count = count + 1
    end
  end
  local Now_DropList = {}
  for i = 1, table.count(dropList) do
    if i <= max then
      Now_DropList[i] = dropList[i]
    end
  end
  DataModel.dropList = Now_DropList
  DataModel.perfectAward = levelCA.perfectAward
  DataModel.firstPassAward = levelCA.firstPassAward
  self.SecondPanel:ShowDrop(levelCA, 3, PlayerData:GetLevelPass(levelId))
  View.Group_SecondPanel.Group_Right.Group_BottomRight.Btn_StartFight:SetActive(true)
  View.Group_SecondPanel.Group_Right.Group_BottomRight.Txt_Ban:SetActive(false)
  if PlayerData.ChooseChapterType == 2 then
    local user_info = PlayerData:GetUserInfo()
    if user_info.lv < levelCA.playerLevel then
      View.Group_SecondPanel.Group_Right.Group_BottomRight.Btn_StartFight:SetActive(false)
      View.Group_SecondPanel.Group_Right.Group_BottomRight.Txt_Ban:SetActive(true)
      View.Group_SecondPanel.Group_Right.Group_BottomRight.Txt_Ban:SetText(string.format(GetText(80600163), levelCA.playerLevel))
    end
  end
end

function model:ClosePanels()
  View.Group_SecondPanel.self:SetActive(false)
  View.Group_DropDetails.self:SetActive(false)
  View.Group_LeftBottom.self:SetActive(false)
end

function model.PlayAniChapterBig()
  View.self:PlayAnim("ChapterBig")
end

function model.PlayAniChapterSmall()
  View.self:PlayAnim("ChapterSmall")
end

function model.OpenLeveChainInfo(levelChainCA)
  View.Group_LevelChainInfo.self:SetActive(true)
end

function model.OpenPanelChooseSkill()
  View.Group_ChooseSkill.self:SetActive(true)
  View.Group_ChooseSkill.StaticGrid_Skill.self:RefreshAllElement()
end

function model.IsUnlock(id)
  local data = PlayerData.ServerData.enemy
  for k, v in pairs(data) do
    if tonumber(v) == id then
      return true
    end
  end
  return false
end

function model.InitEnemyInfo(levelId)
  local levelData = PlayerData:GetFactoryData(levelId, "LevelFactory")
  DataModel.enemyDetailShowInfo = {}
  for i, v in pairs(levelData.enemyBookList) do
    local id = tonumber(v.id)
    local unitData = PlayerData:GetFactoryData(id, "unitFactory")
    local unitViewData = PlayerData:GetFactoryData(tonumber(unitData.viewId), "UnitViewFactory")
    local faceRes = unitViewData.face
    local isUnlock = model.IsUnlock(id)
    local t = {}
    t.id = id
    t.faceRes = faceRes
    t.isUnlock = isUnlock
    t.name = unitData.name
    t.viewId = unitData.viewId
    t.isBoss = unitData.isBoss
    t.spineUrl = unitViewData.resDir
    t.lineDes = unitData.lineDes
    t.iconPath = unitViewData.face
    t.armorDes = unitData.armorDes
    t.riskDes = unitData.riskDes
    t.normalDes = unitData.normalDes
    t.battleDes = unitData.battleDes
    t.spineX = unitViewData.spineX
    t.spineY = unitViewData.spineY
    t.spineScale = unitViewData.spineScale
    table.insert(DataModel.enemyDetailShowInfo, t)
  end
end

function model.EnemyDetailShow(idx)
  local info = DataModel.enemyDetailShowInfo[idx]
  if info == nil then
    return
  end
  if not info.isUnlock then
    CommonTips.OpenTips(80600208)
    return
  end
  if DataModel.curShowIdx == idx then
    return
  end
  DataModel.curShowIdx = idx
  local panel = View.Group_MonsterManual.Group_EnemyDetail.Group_Details
  panel.Txt_Name:SetText(info.name)
  local spine = panel.SpineAnimation_Enemy
  if info.spineUrl and info.spineUrl ~= "" then
    spine:SetActive(true)
    spine:SetData(info.spineUrl, "stand")
    local pos = DataModel.curShowSpineDefaultInfo.pos
    if pos == nil then
      pos = spine.transform.localPosition
      DataModel.curShowSpineDefaultInfo.pos = pos
    end
    local scale = DataModel.curShowSpineDefaultInfo.scale
    if scale == nil then
      scale = spine.transform.localScale
      DataModel.curShowSpineDefaultInfo.scale = scale
    end
    spine:SetPos(pos.x + info.spineX, pos.y + info.spineY)
    spine:SetLocalScale(Vector3(scale.x * info.spineScale, scale.y * info.spineScale, 1))
  end
  panel.Group_Nature.Img_Position.Txt_position:SetText(info.lineDes)
  panel.Group_Nature.Img_Defense.Txt_defense:SetText(info.armorDes)
  panel.Group_Nature.Img_Risk.Txt_risk:SetText(info.riskDes)
  panel.Group_Des.Txt_battleDes:SetText(info.battleDes)
  View.Group_MonsterManual.Group_EnemyDetail.Group_Blank.self:SetActive(false)
  panel.self:SetActive(true)
end

function model.SetGridLevelChainSquad(element, elementIndex)
  local roleId = PlayerData.ServerData.squad[100].role_list[elementIndex]
  if roleId == nil or roleId == "" then
    element.self:SetActive(false)
    return
  end
  local currentHP = PlayerData.ServerData.level_chain.roles
  local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
  local roleData = PlayerData.ServerData.roles[roleId]
  local unitViewCA = PlayerData:GetFactoryData(roleData.current_skin[1], "UnitViewFactory")
  element.self:SetActive(true)
  element.Group_Lv.Txt_Num:SetText(roleData.lv)
  element.Txt_Name:SetText(unitCA.name)
  element.Img_Mask.Img_Face:SetSprite(unitViewCA.face)
  local diff = 1
  if currentHP ~= nil and currentHP[elementIndex] ~= nil then
    diff = math.max(currentHP[elementIndex], 0) / unitCA.hp_SN
  end
  element.Img_Life.Img_Now:SetFilledImgAmount(diff)
end

function model.SetGridLevelChainSkills(LCLevelIndex, element, elementIndex)
  local index = LCLevelIndex
  local buffData = PlayerData.ServerData.level_chain.buffList[tostring(index)]
  if buffData == nil then
    return
  end
  if buffData.index ~= nil then
    element.self:SetActive(elementIndex == buffData.index)
    element.Btn_Lvup.self:SetActive(false)
  else
    element.self:SetActive(true)
    element.Btn_Lvup.self:SetActive(true)
    local buffId = buffData.buffIdList[elementIndex]
    local skillCA = PlayerData:GetFactoryData(buffId, "SkillFactory")
    element.Txt_Name:SetText(skillCA.name)
    element.Img_Desc.Txt_Desc:SetText(skillCA.description)
    element.Btn_Lvup.self:SetClickParam(elementIndex)
  end
end

return model
