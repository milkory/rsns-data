local View = require("UIBook/UIBookView")
local DataModel = require("UIBook/UIBookDataModel")
local Controller = {}
local Data = {}
local SorData = {}
local allCount = 0
local getCount = 0
local CampList = {}
local InitData = function()
  local index = 0
  local all = PlayerData:GetFactoryData(80900001, "BookFactory")
  if all ~= nil and all.unitList ~= nil then
    local tab = {}
    for k, v in pairs(all.unitList) do
      local id = tonumber(v.id)
      local info = {}
      local data = PlayerData:GetFactoryData(id, "UnitFactory")
      info.id = id
      info.name = data.name or ""
      info.viewId = data.viewId
      info.qualityInt = data.qualityInt or 1
      info.jobInt = PlayerData:SearchRoleJobInt(data.jobId)
      info.campid = data.sideId
      info.hasGet = false
      tab[id] = info
      index = index + 1
    end
    Data = tab
    allCount = index
  end
  index = 0
  for k in pairs(PlayerData.ServerData.roles) do
    if Data[tonumber(k)] then
      Data[tonumber(k)].hasGet = true
    end
    index = index + 1
  end
  getCount = index
end
local InitCamp = function()
  CampList = {}
  local data = PlayerData:GetFactoryData(99900017).enumSideList
  for k, v in pairs(data) do
    local row = {}
    CampList[k] = row
    row.id = v.tagId
    row.config = PlayerData:GetFactoryData(row.id)
  end
end
local SortData = function(campId)
  local index = 0
  local data = {}
  for k, v in pairs(Data) do
    if v.campid == campId then
      index = index + 1
      data[index] = v
    end
  end
  SorData = data
  table.sort(SorData, function(a, b)
    if a.qualityInt ~= b.qualityInt then
      return a.qualityInt > b.qualityInt
    elseif a.jobInt ~= a.jobInt then
      return a.jobInt < b.jobInt
    else
      return a.id < b.id
    end
  end)
end
local InitView = function()
  local result = getCount / allCount
  local Btn = View.Group_BookMain.Btn_Role
  Btn.Txt_RoleNum:SetText(getCount .. "/" .. allCount)
  Btn.Txt_Progress:SetText(tostring(PlayerData:GetPreciseDecimalFloor(result * 100, 1)) .. "%")
  Btn.Img_bar:SetFilledImgAmount(result)
  View.Group_Role:SetActive(false)
end

function Controller.Init()
  InitData()
  InitCamp()
  InitView()
end

function Controller.OpenCamp()
  DataModel.CurrentPage = DataModel.EnumPage.Camp
  View.Group_Role:SetActive(true)
  View.Group_Role.Group_Camp:SetActive(true)
  View.Group_Role.Group_RoleList:SetActive(false)
  View.self:PlayAnim("CampIn")
  View.Group_Role.Group_Camp.ScrollGrid_Camp.grid.self:SetDataCount(table.count(CampList))
  View.Group_Role.Group_Camp.ScrollGrid_Camp.grid.self:RefreshAllElement()
end

function Controller.CloseCamp()
  View.self:PlayAnim("CampOut", function()
    DataModel.CurrentPage = DataModel.EnumPage.Main
    View.Group_Role.self:SetActive(false)
  end)
end

function Controller.OpenRole(campIndex)
  DataModel.CurrentPage = DataModel.EnumPage.Role
  View.Group_Role.Group_RoleList:SetActive(true)
  SortData(CampList[campIndex].id)
  View.Group_Role.Group_RoleList.ScrollGrid_Middle.grid.self:SetDataCount(table.count(SorData))
  View.Group_Role.Group_RoleList.ScrollGrid_Middle.grid.self:RefreshAllElement()
  View.self:PlayAnim("RoleListIn")
end

function Controller.CloseRole()
  View.self:PlayAnim("RoleListOut", function()
    DataModel.CurrentPage = DataModel.EnumPage.Camp
    View.Group_Role:SetActive(true)
    View.Group_Role.Group_Camp:SetActive(true)
    View.Group_Role.Group_RoleList:SetActive(false)
    View.Group_Role.Group_Camp.ScrollGrid_Camp.grid.self:SetDataCount(table.count(CampList))
    View.Group_Role.Group_Camp.ScrollGrid_Camp.grid.self:RefreshAllElement()
  end)
end

function Controller.SetRoleElement(element, elementIndex)
  local data = SorData[elementIndex]
  element.Btn_Item:SetClickParam(elementIndex)
  element.Txt_Name:SetText(data.name)
  element.Group_Character.Img_Character:SetSprite(PlayerData:GetFactoryData(data.viewId, "UnitViewFactory").roleListResUrl)
  element.Img_Bottom:SetSprite(UIConfig.CharacterBottom[data.qualityInt])
  element.Img_Decorate:SetSprite(UIConfig.CharacterDecorate[data.qualityInt])
  element.Img_NotHave:SetActive(not data.hasGet)
  local ca = PlayerData:GetFactoryData(data.id, "UnitFactory")
  local Group_SkillColor = element.Group_SkillColor
  local cardList = PlayerData:GetRoleCardList(ca.id)
  for i = 1, table.count(cardList) do
    local obj = "Group_SkillColor" .. i
    local cardCA = PlayerData:GetFactoryData(cardList[table.count(cardList) - i + 1].id)
    local color = cardCA.color
    Group_SkillColor[obj].Img_Color:SetSprite(UIConfig.CharacterSkillColor[color])
  end
  local Group_Locate = Group_SkillColor.Group_Locate
  Group_Locate.Img_Line:SetSprite(UIConfig.CharacterLine[ca.line])
end

function Controller.SetCampElement(element, elementIndex)
  element.Txt_Name:SetText(CampList[elementIndex].config.sideName)
  element.Img_Icon:SetSprite(UIConfig.RoleCamp[elementIndex])
  element.Btn_Camp:SetClickParam(elementIndex)
end

return Controller
