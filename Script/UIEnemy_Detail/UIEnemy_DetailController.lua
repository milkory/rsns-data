local View = require("UIEnemy_Detail/UIEnemy_DetailView")
local DataModel = require("UIEnemy_Detail/UIEnemy_DetailDataModel")
local Controller = {}

function Controller:Init(id)
  DataModel.EnemyCA = PlayerData:GetFactoryData(id)
  DataModel.EnemyViewCA = PlayerData:GetFactoryData(DataModel.EnemyCA.viewId)
  DataModel.EnemyCampCA = PlayerData:GetFactoryData(DataModel.EnemyCA.enemyCamp)
  DataModel.EnemyTypeCA = PlayerData:GetFactoryData(DataModel.EnemyCA.enemyType)
  DataModel.EnemySideCA = PlayerData:GetFactoryData(DataModel.EnemyCA.sideId)
  View.Group_Enemy.Img_Enemy:SetSprite(DataModel.EnemyViewCA.bookFull)
  View.Group_Enemy.self:SetLocalPosition(Vector3(DataModel.EnemyViewCA.bookX, DataModel.EnemyViewCA.bookY, 0))
  local Group_Left = View.Group_Left
  local Group_TopLeft = Group_Left.Group_TopLeft
  Group_TopLeft.Img_TypeIcon:SetSprite(DataModel.EnemyCampCA.iconPath)
  Group_TopLeft.Txt_SideName:SetText(DataModel.EnemyCA.name)
  Group_Left.Img_IconSide:SetActive(false)
  Group_TopLeft.Txt_TypeName:SetText("")
  if DataModel.EnemySideCA then
    Group_Left.Img_IconSide:SetActive(true)
    Group_Left.Img_IconSide:SetSprite(DataModel.EnemySideCA.iconPath)
    Group_TopLeft.Txt_TypeName:SetText(DataModel.EnemySideCA.sideName)
  end
  local Group_BottomRight = Group_Left.Group_BottomRight
  Group_BottomRight.Txt_:SetText(DataModel.EnemyTypeCA.strengthText)
  local Group_Icon = View.ScrollView_Right.Viewport.Content.Group_Icon
  DataModel.IdentityList = {}
  for k, v in pairs(DataModel.EnemyCA.abilityList) do
    local ca = PlayerData:GetFactoryData(v.id)
    local t = {}
    t.id = ca.id
    t.icon = ca.icon
    t.tagType = ca.tagType
    t.tagName = ca.tagName
    table.insert(DataModel.IdentityList, t)
  end
  if table.count(DataModel.IdentityList) == 0 then
    Group_Icon.Group_Identity.ScrollGrid_Identity.grid.self:SetActive(false)
    Group_Icon.Group_Identity.Txt_None:SetActive(true)
  else
    Group_Icon.Group_Identity.ScrollGrid_Identity.grid.self:SetActive(true)
    Group_Icon.Group_Identity.Txt_None:SetActive(false)
    if table.count(DataModel.IdentityList) <= 6 then
      Group_Icon.Group_Identity.ScrollGrid_Identity.self:SetEnable(false)
      Group_Icon.Group_Identity.ScrollGrid_Identity.grid.self:SetStartCorner("Center")
    else
      Group_Icon.Group_Identity.ScrollGrid_Identity.self:SetEnable(true)
      Group_Icon.Group_Identity.ScrollGrid_Identity.grid.self:SetStartCorner("Left")
    end
    Group_Icon.Group_Identity.ScrollGrid_Identity.grid.self:SetDataCount(table.count(DataModel.IdentityList))
    Group_Icon.Group_Identity.ScrollGrid_Identity.grid.self:RefreshAllElement()
  end
  DataModel.ResistanceList = {}
  for k, v in pairs(DataModel.EnemyCA.resistanceList) do
    local ca = PlayerData:GetFactoryData(v.id)
    local t = {}
    t.id = ca.id
    t.icon = ca.icon
    t.tagType = ca.tagType
    t.tagName = ca.tagName
    t.tagTypeInt = ca.tagTypeInt
    table.insert(DataModel.ResistanceList, t)
  end
  if table.count(DataModel.ResistanceList) == 0 then
    Group_Icon.Group_Resistance.ScrollGrid_Resistance.grid.self:SetActive(false)
    Group_Icon.Group_Resistance.Txt_None:SetActive(true)
  else
    Group_Icon.Group_Resistance.ScrollGrid_Resistance.grid.self:SetActive(true)
    Group_Icon.Group_Resistance.Txt_None:SetActive(false)
    if 6 >= table.count(DataModel.ResistanceList) then
      Group_Icon.Group_Resistance.ScrollGrid_Resistance.self:SetEnable(false)
      Group_Icon.Group_Resistance.ScrollGrid_Resistance.grid.self:SetStartCorner("Center")
    else
      Group_Icon.Group_Resistance.ScrollGrid_Resistance.self:SetEnable(true)
      Group_Icon.Group_Resistance.ScrollGrid_Resistance.grid.self:SetStartCorner("Left")
    end
    Group_Icon.Group_Resistance.ScrollGrid_Resistance.grid.self:SetDataCount(table.count(DataModel.ResistanceList))
    Group_Icon.Group_Resistance.ScrollGrid_Resistance.grid.self:RefreshAllElement()
  end
  DataModel.WeaknessList = {}
  for k, v in pairs(DataModel.EnemyCA.weaknessList) do
    local ca = PlayerData:GetFactoryData(v.id)
    local t = {}
    t.id = ca.id
    t.icon = ca.icon
    t.tagType = ca.tagType
    t.tagName = ca.tagName
    t.tagTypeInt = ca.tagTypeInt
    table.insert(DataModel.WeaknessList, t)
  end
  if table.count(DataModel.WeaknessList) == 0 then
    Group_Icon.Group_Weakness.ScrollGrid_Weakness.grid.self:SetActive(false)
    Group_Icon.Group_Weakness.Txt_None:SetActive(true)
  else
    Group_Icon.Group_Weakness.ScrollGrid_Weakness.grid.self:SetActive(true)
    Group_Icon.Group_Weakness.Txt_None:SetActive(false)
    if 6 >= table.count(DataModel.WeaknessList) then
      Group_Icon.Group_Weakness.ScrollGrid_Weakness.self:SetEnable(false)
      Group_Icon.Group_Weakness.ScrollGrid_Weakness.grid.self:SetStartCorner("Center")
    else
      Group_Icon.Group_Weakness.ScrollGrid_Weakness.self:SetEnable(true)
      Group_Icon.Group_Weakness.ScrollGrid_Weakness.grid.self:SetStartCorner("Left")
    end
    Group_Icon.Group_Weakness.ScrollGrid_Weakness.grid.self:SetDataCount(table.count(DataModel.WeaknessList))
    Group_Icon.Group_Weakness.ScrollGrid_Weakness.grid.self:RefreshAllElement()
  end
  DataModel.DropRewardList = {}
  for k, v in pairs(DataModel.EnemyCA.enemyDrop) do
    local ca = PlayerData:GetFactoryData(v.id)
    local t = {}
    t.id = ca.id
    t.icon = ca.iconPath or ca.imagePath
    t.qualityInt = ca.qualityInt + 1
    table.insert(DataModel.DropRewardList, t)
  end
  if table.count(DataModel.DropRewardList) == 0 then
    View.ScrollView_Right.Viewport.Content.Group_Drop.self:SetActive(false)
  else
    View.ScrollView_Right.Viewport.Content.Group_Drop.self:SetActive(true)
    View.ScrollView_Right.Viewport.Content.Group_Drop.StaticGrid_DropItem.grid.self:SetDataCount(table.count(DataModel.DropRewardList))
    View.ScrollView_Right.Viewport.Content.Group_Drop.StaticGrid_DropItem.grid.self:RefreshAllElement()
  end
  local Group_BottomLeft = View.Group_Left.Group_BottomLeft
  Group_BottomLeft.Group_Ver2.self:SetActive(true)
  Group_BottomLeft.Group_Ver1.self:SetActive(false)
  Group_BottomLeft.Group_Ver2.Group_ATK.Txt_Num:SetText(DataModel.Content.atkGrade)
  Group_BottomLeft.Group_Ver2.Group_DEF.Txt_Num:SetText(DataModel.Content.defGrade)
  Group_BottomLeft.Group_Ver2.Group_HP.Txt_Num:SetText(DataModel.Content.hpGrade)
  View.ScrollView_Right.Viewport.Content.Group_Description.Txt_Content:SetText(DataModel.EnemyCA.unitInformation)
  local textHight = View.ScrollView_Right.Viewport.Content.Group_Description.Txt_Content:GetHeight()
  if 70 < textHight then
    View.ScrollView_Right:SetContentHeight(DataModel.ContentHight + (textHight - 70))
  end
end

function Controller:SetRightElement(element, row)
  element.Img_TagIcon:SetSprite(row.icon)
  element.Txt_TagName:SetText(row.tagName)
end

function Controller:SetDropElement(element, row)
  element.Img_Item:SetSprite(row.icon)
  element.Img_Bottom:SetSprite(UIConfig.BottomConfig[row.qualityInt])
  element.Img_Mask:SetSprite(UIConfig.MaskConfig[row.qualityInt])
  element.Btn_Item:SetClickParam(elementIndex)
end

return Controller
