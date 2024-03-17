local View = require("UIChapterSelect/UIChapterSelectView")
local GridController = require("UIChapterSelect/Controller_Grid")
local AssessmentDataController = require("UIChapterSelect/UIAssessment/UIAssessmentDataController")
local PageIndex
local OpenAssessment = function()
  AssessmentDataController:Deserialize()
end
local DataModel = {
  selectedIndex = nil,
  selectedRightIndex = nil,
  Resources = {},
  OldIndex = nil,
  OldGridIndex = 0
}

function DataModel:Serialize()
  local dataModel = {}
  dataModel.selectedIndex = self.selectedIndex
  return dataModel
end

function DataModel:OnDestroy()
  PlayerPrefs.SetInt("ChapterIndex", self.selectedIndex)
end

local isOpenTimeFunc = function(resource)
  local now_time_wday = tonumber(os.date("%w", PlayerData.ServerData.server_now))
  local breakpointsStr = ","
  local weekList = resource.weekList
  local i = 0
  local j = 1
  local time = {}
  local z = string.len(breakpointsStr)
  while true do
    i = string.find(weekList, breakpointsStr, i + 1)
    if i == nil then
      table.insert(time, string.sub(weekList, j, -1))
      break
    end
    table.insert(time, string.sub(weekList, j, i - 1))
    j = i + z
  end
  time[0] = time[7]
  table.remove(time, 7)
  return tonumber(time[now_time_wday]) == 1
end
local isOepnResourceLevel = function(resource)
  local user_lv = PlayerData:GetUserInfo().lv
  local playerLevel = resource.playerLevel
  local specifiedLevelId = resource.specifiedLevelId
  local isPassLevel, text
  if specifiedLevelId == nil or specifiedLevelId == -1 then
    isPassLevel = true
    text = string.format(GetText(80600161), playerLevel)
  else
    isPassLevel = PlayerData:GetLevelPass(specifiedLevelId)
    local levelChapter = PlayerData:GetFactoryData(specifiedLevelId).levelChapter
    text = string.format(GetText(80600162), levelChapter)
  end
  if isPassLevel == true and user_lv >= playerLevel then
    return true, isOpenTimeFunc(resource), text
  end
  return false, isOpenTimeFunc(resource), text
end
local InitCurrentList = function()
  for i = 1, #GridController.currentGridList do
    local v = GridController.currentGridList[i]
    local factory = PlayerData:GetFactoryData(v.chapterId, "ChapterFactory")
    v.name = factory.name
    local nameCN = string.gsub(factory.nameCN, "/n", "\n", 1)
    v.nameCN = nameCN
    v.nameEN = factory.nameEN
    v.time = factory.time
    v.placeCN = factory.placeCN
    v.placeEN = factory.placeEN
  end
end
local InitRightTabList = function()
  local Group_Topright = View.Group_Topright
  local right = {
    [1] = Group_Topright.BtnPolygon_Mainline,
    [2] = Group_Topright.BtnPolygon_Resource
  }
  for k, v in pairs(right) do
    v.Group_On:SetActive(false)
    v.Group_Off:SetActive(true)
  end
  right[PlayerData.selectedRightIndex].Group_Off:SetActive(false)
  right[PlayerData.selectedRightIndex].Group_On:SetActive(true)
end
local InitResourceTabList = function()
  local resourceChapterList = PlayerData:GetFactoryData(99900001, "ConfigFactory").resourceChapterList
  local Group_ResourceLevel = View.Group_ResourceLevel
  DataModel.Resources = {}
  for k, v in pairs(resourceChapterList) do
    local resource = PlayerData:GetFactoryData(v.id)
    local group = "Group_C0" .. k
    if Group_ResourceLevel[group] then
      Group_ResourceLevel[group].Img_Ban:SetActive(false)
      Group_ResourceLevel[group].Img_Highlight:SetActive(false)
      Group_ResourceLevel[group].Btn_C:SetActive(false)
      local isOpen, isOpenTime, tipText = isOepnResourceLevel(resource)
      local row = {}
      local isFinshNum = PlayerData:GetResourceLevelData(v.id)
      DataModel.Resources[k] = row
      row.resource = resource
      row.isOpen = isOpen
      row.isOpenTime = isOpenTime
      row.isFinshNum = isFinshNum == nil and resource.num or isFinshNum
      row.isResidueNum = resource.num - row.isFinshNum
      local Group = Group_ResourceLevel[group]
      local Btn_C = Group.Btn_C
      Btn_C:SetActive(true)
      Btn_C.Txt_Name:SetText(resource.nameCN)
      Btn_C.Txt_Time:SetText(resource.time)
      Btn_C.Txt_Num:SetText(string.format(GetText(80600160), row.isResidueNum, resource.num))
      if resource.num == -1 then
        Btn_C.Txt_Num:SetText(GetText(80600251))
      end
      Btn_C:SetColor(UIConfig.Color.White)
      Btn_C.Img_Icon:SetColor(UIConfig.Color.White)
      Btn_C.Txt_Time:SetColor(UIConfig.Color.White)
      Btn_C.Txt_Num:SetColor(UIConfig.Color.White)
      if row.isOpen == false or row.isOpenTime == false then
        Btn_C:SetColor("#808080")
        Btn_C.Img_Icon:SetColor("#808080")
        Btn_C.Txt_Time:SetColor("#808080")
        Btn_C.Txt_Num:SetColor("#808080")
        Group.Img_Ban:SetActive(true)
        Group.Img_Ban.Txt_Ban:SetText(tipText)
      end
    end
  end
end

function DataModel.ChangeOpenChapter(isFirst)
  local showPage = {
    [1] = {
      page = View.Group_middle,
      func = DataModel.OpenMainTask
    },
    [2] = {
      page = View.Group_ResourceLevel,
      func = DataModel.OpenResourceLevel
    },
    [3] = {
      page = View.Group_Assessment,
      func = OpenAssessment
    }
  }
  for k, v in pairs(showPage) do
    if isFirst then
      showPage[k].page:SetActive(false)
    elseif v.page.IsActive then
      DataModel.OldIndex = k
    end
  end
  if DataModel.OldIndex ~= PlayerData.selectedRightIndex then
    View.self:PlayAnim("C" .. DataModel.OldIndex .. PlayerData.selectedRightIndex, function()
      showPage[DataModel.OldIndex].page:SetActive(false)
    end)
  end
  InitRightTabList()
  showPage[PlayerData.selectedRightIndex].page.self:SetActive(true)
  showPage[PlayerData.selectedRightIndex].func()
  PageIndex = PlayerData.selectedRightIndex
end

function DataModel.PageDragComplete(index)
  DataModel.selectedIndex = index + 1
  local grid = GridController.currentGrid.grid.self
  local isLock = PlayerData:GetUnlockChapter() < grid.Index + 1
  if DataModel.OldGridIndex == index and DataModel.IsDrag and not DataModel.IsFirst then
    DataModel.IsDrag = false
    return
  end
  DataModel.IsFirst = false
  local old = grid:GetChildByIndex(DataModel.OldGridIndex)
  if old ~= nil then
    local oldItem = old:GetComponent(typeof(CS.Seven.UIGridItemIndex)).element.Btn_Item
  end
  local chapterData = PlayerData:GetFactoryData(GridController.currentGridList[grid.Index + 1].chapterId, "ChapterFactory")
  local userInfo = PlayerData:GetUserInfo()
  local Btn_Item = grid:GetChildByIndex(grid.Index):GetComponent(typeof(CS.Seven.UIGridItemIndex)).element.Btn_Item
end

function DataModel.OpenMainTask()
  GridController.currentGrid = View.Group_middle.Page_Chapter
  GridController.currentGridList = PlayerData:GetFactoryData(99900001, "ConfigFactory").mainChapter
  DataModel.TotalCount = #GridController.currentGridList
  InitCurrentList()
  GridController:RefreshCurrentGrid()
  GridController:RefreshLeftCurrentGrid(View.Group_middle.Page_LeftChapter)
  GridController:RefreshLeftNameGrid(View.Group_middle.Page_LeftChapterName)
  if PlayerData.ChooseChapterType == 1 then
    GridController.currentGrid.grid.self:LocatElementImmediate(DataModel.selectedIndex - 1)
    View.Group_middle.Page_LeftChapter.grid.self:LocatElementImmediate(DataModel.selectedIndex - 1)
    View.Group_middle.Page_LeftChapterName.grid.self:LocatElementImmediate(DataModel.selectedIndex - 1)
  end
end

function DataModel.OpenResourceLevel()
  Net:SendProto("battle.source_chapter", function(json)
    print_r(json)
    print_r("------------------资源关卡数据--------------------")
    PlayerData:SetResourceLevelData(json)
    InitResourceTabList()
  end)
  InitResourceTabList()
end

function DataModel:InitBackGroundSprite(index)
  View.Group_middle.StaticGrid_Chapter.grid.self:SetDataCount(#GridController.currentGridList)
  View.Group_middle.StaticGrid_Chapter.grid.self:RefreshAllElement()
end

return DataModel
