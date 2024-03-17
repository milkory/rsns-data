local View = require("UIBook/UIBookView")
local DataModel = require("UIBook/UIBookDataModel")
local Data = {}
local Controller = {}
local allCount = 0
local getCount = 0
local IsUnlock = function(data, id)
  if data then
    for k, v in pairs(data) do
      if tonumber(v) == id then
        return true
      end
    end
  end
  return false
end
local InitView = function()
  local result = getCount / allCount
  local Btn = View.Group_BookMain.Btn_Enemy
  Btn.Txt_RoleNum:SetText(getCount .. "/" .. allCount)
  Btn.Txt_Progress:SetText(tostring(PlayerData:GetPreciseDecimalFloor(result * 100, 1)) .. "%")
  Btn.Img_bar:SetFilledImgAmount(result)
  View.Group_Enemy.self:SetActive(false)
end
local InitData = function()
  local all = PlayerData:GetFactoryData(80900005, "BookFactory")
  allCount = #all.unitList
  local enemy = PlayerData.ServerData.enemy
  getCount = 0
  local tab = {}
  for _, v in ipairs(all.unitList) do
    local id = tonumber(v.id)
    local info = {}
    local data = PlayerData:GetFactoryData(id, "UnitFactory")
    info.id = id
    info.isUnlock = IsUnlock(enemy, id)
    if info.isUnlock then
      getCount = getCount + 1
    end
    info.name = data.name
    info.viewId = data.viewId
    info.isBoss = data.isBoss
    local viewData = PlayerData:GetFactoryData(data.viewId, "UnitViewFactory")
    info.spineUrl = viewData.resDir
    info.spineScale = viewData.spineScale
    info.spineX = viewData.spineX
    info.spineY = viewData.spineY
    info.lineDes = data.lineDes
    info.iconPath = viewData.face
    info.armorDes = data.armorDes
    info.riskDes = data.riskDes
    info.normalDes = data.normalDes
    info.battleDes = data.battleDes
    table.insert(tab, info)
  end
  Data = tab
end

function Controller.Init()
  InitData()
  InitView()
end

function Controller.SetElement(element, elementIndex)
  element.Btn_Enemy:SetClickParam(elementIndex)
  local data = Data[tonumber(elementIndex)]
  element.Txt_Name:SetText(data.name)
  local lock = element.Group_Lock
  lock.self:SetActive(not data.isUnlock)
  element.Img_IconMask.Img_Icon:SetSprite(data.iconPath)
  element.Img_Boss:SetActive(data.isBoss)
end

function Controller.OnClickBtn(elementIndex)
  local data = Data[elementIndex]
  if not data.isUnlock then
    CommonTips.OpenTips(80600208)
    return
  end
  View.Group_EnemyDetail.self:SetActive(true)
  local Group_Details = View.Group_EnemyDetail.Group_Details
  Group_Details.Txt_Name:SetText(data.name)
  local spine = Group_Details.SpineAnimation_Enemy
  if data and data.spineUrl and data.spineUrl ~= "" then
    spine:SetActive(true)
    spine:SetData(data.spineUrl, "stand")
    spine:SetPos(data.spineX + DataModel.SpineEnemyPosition.x, data.spineY + DataModel.SpineEnemyPosition.y)
    spine:SetLocalScale(data.spineScale * DataModel.SpineEnemyScale)
  end
  Group_Details.Group_Nature.Img_Position.Txt_position:SetText(data.lineDes)
  Group_Details.Group_Nature.Img_Defense.Txt_defense:SetText(data.armorDes)
  Group_Details.Group_Nature.Img_Risk.Txt_risk:SetText(data.riskDes)
  Group_Details.Group_Des.Txt_NormalDes:SetText(data.normalDes)
  Group_Details.Group_Des.Txt_battleDes:SetText(data.battleDes)
end

function Controller.Open()
  DataModel.CurrentPage = DataModel.EnumPage.Enemy
  View.Group_Enemy.self:SetActive(true)
  local grid = View.Group_Enemy.ScrollGrid_Middle.grid.self
  grid:SetDataCount(#Data)
  grid:RefreshAllElement()
end

function Controller.Close()
  DataModel.CurrentPage = DataModel.EnumPage.Main
  View.Group_Enemy.self:SetActive(false)
end

return Controller
