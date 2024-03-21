local View = require("UIIllustration_Enemy/UIIllustration_EnemyView")
local DataModel = require("UIIllustration_Enemy/UIIllustration_EnemyDataModel")
local Controller = {}

function Controller:Init()
  DataModel.EnemyList = {}
  DataModel.AllEnemyList = {}
  DataModel.NowShowList = {}
  local unitList = PlayerData:GetFactoryData(80900005).unitList
  local enemyCampEnumList = PlayerData:GetFactoryData(99900017).enemyCampEnumList
  local enemyCampSortList = {}
  for k, v in pairs(enemyCampEnumList) do
    enemyCampSortList[v.id] = k
  end
  DataModel.AllEnemyNum = table.count(unitList)
  for k, v in pairs(unitList) do
    local row = {}
    local ca = PlayerData:GetFactoryData(v.id)
    row.qualityInt = ca.qualityInt
    row.serialNum = v.serialNum
    row.serialNumIndex = tonumber(string.sub(row.serialNum, string.len(row.serialNum) - 1, string.len(row.serialNum)))
    row.name = ca.name
    row.EnglishName = ca.EnglishName
    row.isSpine2 = ca.isSpine2
    row.line = ca.line
    row.id = v.id
    row.viewId = ca.viewId
    row.sideId = ca.sideId
    row.enemyCamp = ca.enemyCamp
    row.enemyCampIndex = enemyCampSortList[ca.enemyCamp]
    local campCA = PlayerData:GetFactoryData(row.enemyCamp)
    row.campIcon = campCA.iconPath
    row.enemyType = tonumber(ca.enemyType)
    local enemyCA = PlayerData:GetFactoryData(row.enemyType)
    row.enemyIcon = enemyCA.enemyCardUrl
    row.strengthText = enemyCA.strengthText
    row.hpGrade = PlayerData:GetEnemyHpGrade(ca.hp_SN)
    row.defGrade = PlayerData:GetEnemyDefGrade(ca.def_SN)
    row.atkGrade = PlayerData:GetEnemyAtkGrade(ca.atk_SN)
    local viewCA = PlayerData:GetFactoryData(row.viewId)
    row.bookHalf = viewCA.bookHalf
    row.bookFull = viewCA.bookFull
    row.server = PlayerData:GetEnemyById(row.id)
    row.sortIndex = 0
    local abilityList = {}
    for c, d in pairs(ca.abilityList) do
      local ca = PlayerData:GetFactoryData(d.id)
      local t = {}
      t.icon = ca.icon
      t.tagType = ca.tagType
      t.tagName = ca.tagName
      table.insert(abilityList, t)
    end
    row.abilityList = abilityList
    if table.count(row.server) > 0 then
      row.sortIndex = 1
    end
    table.insert(DataModel.AllEnemyList, row)
    if DataModel.EnemyList[row.enemyCamp] == nil then
      DataModel.EnemyList[row.enemyCamp] = {}
    end
    table.insert(DataModel.EnemyList[row.enemyCamp], row)
  end
  DataModel.EnumCampEnumList = {}
  table.insert(DataModel.EnumCampEnumList, {
    id = "",
    sideName = "全部",
    icon = "UI/Book/Enemy_Illustration/Allicon_Enemy",
    index = 1
  })
  DataModel.EnumSideIndex = {}
  DataModel.EnumSideIndex[1] = DataModel.AllEnemyList
  for i = 1, table.count(enemyCampEnumList) do
    local row = {}
    local ca = PlayerData:GetFactoryData(enemyCampEnumList[i].id)
    row.index = i + 1
    row.icon = ca.iconPath
    row.sideName = ca.sideName
    row.id = ca.id
    DataModel.EnumSideIndex[row.index] = DataModel.EnemyList[ca.id]
    table.insert(DataModel.EnumCampEnumList, row)
  end
  DataModel.RightIndex = 1
  DataModel.isFirst = true
  View.Group_RightList.ScrollGrid_RightList.grid.self:SetDataCount(table.count(DataModel.EnumCampEnumList))
  View.Group_RightList.ScrollGrid_RightList.grid.self:RefreshAllElement()
  DataModel.SortState.index = 1
  DataModel.SortState.currentDown = true
  Controller:Reset(View.Group_TopRight.Btn_All)
  Controller:RefreshData()
end

function Controller:ChooseRightIndex(index)
  if index and index == DataModel.RightIndex then
    return
  end
  if View.Group_RightList.ScrollGrid_RightList.grid[DataModel.RightIndex] then
    local old_element = View.Group_RightList.ScrollGrid_RightList.grid[DataModel.RightIndex]
    old_element.Btn_EnemType.Img_Selected:SetActive(false)
    old_element.Btn_EnemType.Img_UnSelected:SetActive(true)
  end
  DataModel.RightIndex = index
  local element = View.Group_RightList.ScrollGrid_RightList.grid[index]
  element.Btn_EnemType.Img_Selected:SetActive(true)
  element.Btn_EnemType.Img_UnSelected:SetActive(false)
  Controller:RefreshData()
end

function Controller:OpenEnemyTip(row, index)
  local params = {
    id = row.id,
    content = row
  }
  if row.server.read and row.server.read == 0 then
    Net:SendProto("book.read_enemy", function(json)
      PlayerData:GetEnemyById(row.id).read = 1
      row.server.read = 1
      local element = DataModel.Element[index]
      element.Btn_Card.Group_Unlocked.Img_New:SetActive(false)
      CommonTips.OpenEnemyDetail(params)
      return
    end, row.id)
  end
  if row.sortIndex == 0 then
    CommonTips.OpenTips(80602334)
    return
  end
  CommonTips.OpenEnemyDetail(params)
end

function Controller:RefreshData()
  DataModel.NowShowList = DataModel.EnumSideIndex[DataModel.RightIndex]
  Controller:SortRefreshData()
  DataModel.Element = {}
  if DataModel.isFirst then
    View.Group_Card.NewScrollGrid_EnemyCard.grid.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      View.Group_Card.NewScrollGrid_EnemyCard.grid.self:SetDataCount(table.count(DataModel.SortShowList))
      View.Group_Card.NewScrollGrid_EnemyCard.grid.self:RefreshAllElement()
      View.Group_Card.NewScrollGrid_EnemyCard.grid.self:MoveToTop()
    end))
    DataModel.isFirst = false
  else
    View.Group_Card.NewScrollGrid_EnemyCard.grid.self:SetDataCount(table.count(DataModel.SortShowList))
    View.Group_Card.NewScrollGrid_EnemyCard.grid.self:RefreshAllElement()
    View.Group_Card.NewScrollGrid_EnemyCard.grid.self:MoveToTop()
  end
end

function Controller:SetElement(element, row, elementIndex)
  local Group_Locked = element.Group_Locked
  Group_Locked:SetActive(false)
  local Group_Unlocked = element.Group_Unlocked
  Group_Unlocked:SetActive(false)
  Group_Unlocked.Img_New:SetActive(false)
  if table.count(row.server) ~= 0 then
    Group_Unlocked:SetActive(true)
    Group_Unlocked.Img_BG:SetSprite(row.enemyIcon)
    Group_Unlocked.Group_Name.Txt_Name:SetText(row.name)
    Group_Unlocked.Img_Icon:SetSprite(row.campIcon)
    Group_Unlocked.Group_TopLeft.Txt_SerialNum:SetText(row.serialNum)
    Group_Unlocked.Img_Enemy:SetSprite(row.bookHalf)
    Group_Unlocked.Img_Enemy:SetActive(true)
    if row.server.read == 0 then
      Group_Unlocked.Img_New:SetActive(true)
    end
    local Group_Data = Group_Unlocked.Group_Data
    Group_Data.Group_ATK.Txt_Num:SetText(row.atkGrade)
    Group_Data.Group_HP.Txt_Num:SetText(row.hpGrade)
    Group_Data.Group_DEF.Txt_Num:SetText(row.defGrade)
    Group_Unlocked.StaticGrid_Tag.grid.self:SetParentParam(elementIndex)
    Group_Unlocked.StaticGrid_Tag.grid.self:SetDataCount(3)
    Group_Unlocked.StaticGrid_Tag.grid.self:RefreshAllElement()
  else
    Group_Locked:SetActive(true)
    Group_Locked.Img_BG:SetSprite(row.enemyIcon)
    Group_Locked.Group_TopLeft.Txt_SerialNum:SetText(row.serialNum)
    Group_Locked.Img_Icon:SetSprite(row.campIcon)
  end
end

function Controller:SetRightElement(element, row, index)
  element.Img_Selected.Img_TypeIcon:SetSprite(row.icon)
  element.Img_UnSelected.Img_TypeIcon:SetSprite(row.icon)
  element.Img_Selected.Txt_TypeName:SetText(row.sideName)
  element.Img_UnSelected.Txt_TypeName:SetText(row.sideName)
  element.Img_Selected:SetActive(false)
  element.Img_UnSelected:SetActive(true)
  if DataModel.RightIndex == index then
    element.Img_Selected:SetActive(true)
    element.Img_UnSelected:SetActive(false)
  end
end

function Controller:ResetActive(btn)
  for key, value in pairs(btn) do
    if key == "self" then
    elseif key == "Img_DeN" then
      btn[key]:SetActive(true)
    elseif key == "Img_DeP" then
      btn[key]:SetActive(true)
    else
      btn[key]:SetActive(false)
    end
  end
end

function Controller:Deactivate(btn)
  if btn.Img_DeP.gameObject.activeInHierarchy then
    btn.Img_DeP:SetActive(false)
    btn.Img_DeN:SetActive(true)
  elseif btn.Img_AP.gameObject.activeInHierarchy then
    btn.Img_AP:SetActive(false)
    btn.Img_AN:SetActive(true)
  end
end

function Controller:Active(btn)
  if btn.Img_AN.gameObject.activeInHierarchy then
    btn.Img_AP:SetActive(true)
    btn.Img_AN:SetActive(false)
    DataModel.SortState.currentDown = false
  elseif btn.Img_DeN.gameObject.activeInHierarchy then
    btn.Img_DeP:SetActive(true)
    btn.Img_DeN:SetActive(false)
    DataModel.SortState.currentDown = true
  end
end

function Controller:Revert(btn)
  if btn.Img_DeP.gameObject.activeInHierarchy then
    btn.Img_DeP:SetActive(false)
    btn.Img_DeN:SetActive(false)
    btn.Img_AP:SetActive(true)
    btn.Img_AN:SetActive(false)
    DataModel.SortState.currentDown = false
  elseif btn.Img_AP.gameObject.activeInHierarchy then
    btn.Img_DeP:SetActive(true)
    btn.Img_DeN:SetActive(false)
    btn.Img_AP:SetActive(false)
    btn.Img_AN:SetActive(false)
    DataModel.SortState.currentDown = true
  end
end

function Controller:Reset(btn)
  for key, value in pairs(View.Group_TopRight) do
    if key ~= "self" then
      Controller:ResetActive(value)
      Controller:Deactivate(value)
    end
  end
  DataModel.SortState.currentBtn = btn
  Controller:Active(DataModel.SortState.currentBtn)
end

function Controller:Click(btn)
  if DataModel.SortState.currentBtn == btn then
    Controller:Revert(btn)
    Controller:RefreshData()
    return
  end
  Controller:Deactivate(DataModel.SortState.currentBtn)
  DataModel.SortState.currentBtn = btn
  Controller:Active(DataModel.SortState.currentBtn)
  Controller:RefreshData()
end

function Controller:SortDown(List)
  table.sort(List, function(a, b)
    if a.enemyCampIndex == b.enemyCampIndex then
      if a.sideId == b.sideId then
        if a.enemyType == b.enemyType then
          return a.serialNumIndex < b.serialNumIndex
        end
        return a.enemyType < b.enemyType
      end
      return a.sideId > b.sideId
    end
    return a.enemyCampIndex < b.enemyCampIndex
  end)
end

function Controller:SortUp(List)
  table.sort(List, function(a, b)
    if a.enemyCampIndex == b.enemyCampIndex then
      if a.sideId == b.sideId then
        if a.enemyType == b.enemyType then
          return a.serialNumIndex > b.serialNumIndex
        end
        return a.enemyType > b.enemyType
      end
      return a.sideId < b.sideId
    end
    return a.enemyCampIndex > b.enemyCampIndex
  end)
end

function Controller:SortRefreshData()
  DataModel.SortShowList = {}
  local index = DataModel.SortState.index
  if index == 1 then
    DataModel.SortShowList = DataModel.NowShowList
    if DataModel.SortState.currentDown then
      Controller:SortDown(DataModel.SortShowList)
    else
      Controller:SortUp(DataModel.SortShowList)
    end
    return
  end
  local type
  if index == 2 then
    type = EnumDefine.BookSortEnemy.Elites
  else
    type = EnumDefine.BookSortEnemy.Boss
  end
  for k, v in pairs(DataModel.NowShowList) do
    if v.enemyType == type then
      table.insert(DataModel.SortShowList, v)
    end
  end
  if DataModel.SortState.currentDown then
    Controller:SortDown(DataModel.SortShowList)
  else
    Controller:SortUp(DataModel.SortShowList)
  end
end

return Controller
