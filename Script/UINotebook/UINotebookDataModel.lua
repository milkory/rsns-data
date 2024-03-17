local View = require("UINotebook/UINotebookView")
local DataModel = {}
local this = DataModel
DataModel.bookIndex = 1
DataModel.curBookTab = {}
DataModel.curBookCfg = {}
DataModel.noteBook = {}
DataModel.curMenu = 1
DataModel.menuNum = 0
DataModel.menuPrefersKey = {}
DataModel.bookPageElements = {}
DataModel.menuElements = {}
DataModel.noteElements = {}
DataModel.noteBookCfg = nil
DataModel.count = 0
DataModel.completedCount = 0
DataModel.dragMouseStartPos = nil

function DataModel.SetJsonData(json)
  if not json then
    return
  end
  local data = Json.decode(json)
  local bookIndex = data.bookIndex or 1
  DataModel.bookIndex = bookIndex
  DataModel.curBookTab = data.dataTab and data.dataTab[bookIndex] or {}
  local dataTab = data.dataTab and data.dataTab[bookIndex]
  if dataTab and dataTab.id then
    local cfg = PlayerData:GetFactoryData(dataTab.id, "ListFactory")
    if cfg then
      DataModel.curBookCfg = cfg
      DataModel.noteBook = cfg.notebook or {}
    end
  end
end

function DataModel.InitData()
  DataModel.menuPrefersKey = {}
  for i, v in ipairs(DataModel.noteBook) do
    table.insert(DataModel.menuPrefersKey, v.id)
  end
  DataModel.bookPageElements = {
    View.Img_NoteTrade,
    View.Img_NoteSolicit,
    View.Img_NotePassenger
  }
  DataModel.menuElements = {
    View.Group_Page.Btn_Trading,
    View.Group_Page.Btn_Bargain,
    View.Group_Page.Btn_Quotes,
    View.Group_Page.Btn_Tips
  }
  DataModel.noteElements = {
    {
      View.Img_NoteTrade.Group_Trading,
      View.Img_NoteTrade.Group_Bargain,
      View.Img_NoteTrade.Group_Quotes,
      View.Img_NoteTrade.Group_Tips
    },
    {
      View.Img_NoteSolicit.Group_Solicit
    },
    {
      View.Img_NotePassenger.Group_Passenger
    }
  }
  DataModel.curMenu = 1
  DataModel.menuNum = 0
end

function DataModel.RefreshOnSHow()
  local prefersKey = DataModel.menuPrefersKey[DataModel.curMenu]
  PlayerData:SetPlayerPrefs("int", prefersKey, PlayerData:GetHomeInfo().trade_lv)
  for i, element in ipairs(DataModel.bookPageElements) do
    element:SetActive(i == DataModel.bookIndex)
  end
  for i, element in ipairs(DataModel.menuElements) do
    local cfg = DataModel.noteBook[i]
    element:SetActive(cfg)
    if cfg then
      local dataCfg = PlayerData:GetFactoryData(cfg.id, "DataFactory")
      element.Img_Open.Txt_:SetText(dataCfg.name)
      element.Img_Close.Txt_:SetText(dataCfg.name)
      element:SetClickParam(i)
      if DataModel.curMenu == i then
        element.Img_Open:SetActive(true)
        element.Img_Close:SetActive(false)
        element.Img_RemindOut:SetActive(false)
      else
        element.Img_Open:SetActive(false)
        element.Img_Close:SetActive(true)
        element.Img_RemindOut:SetActive(DataModel.GetMenuRedPointState(i))
      end
      DataModel.menuNum = DataModel.menuNum + 1
    end
  end
  local noteElements = DataModel.noteElements[DataModel.bookIndex]
  if noteElements then
    for i, element in ipairs(noteElements) do
      element:SetActive(DataModel.curMenu == i)
      if DataModel.curMenu == i then
        DataModel.RefreshMenuInfo(i)
      end
    end
  end
  DataModel.RefreshProgress()
  View.Group_pageA:SetActive(false)
  View.Group_pageB:SetActive(false)
  if DataModel.curBookCfg.cover then
    View.Group_Cover.Group_position.Img_Cover:SetSprite(DataModel.curBookCfg.cover)
  end
  if DataModel.bookIndex == 1 then
    View.self:PlayAnim("NoteBook")
  end
  if DataModel.bookIndex == 2 then
    View.self:PlayAnim("NoteBookSolicit")
  end
  if DataModel.bookIndex == 3 then
    View.self:PlayAnim("NoteBookPassenger")
  end
end

function DataModel.GetCountInfo(tab)
  local count = 0
  local completedCount = 0
  local bookCfg = PlayerData:GetFactoryData(tab.id, "ListFactory")
  for i, info in ipairs(bookCfg.notebook) do
    local dataCfg = PlayerData:GetFactoryData(info.id, "DataFactory")
    for i, v in pairs(dataCfg.noteList) do
      local unLock = PlayerData:GetHomeInfo().trade_lv >= v.level
      if unLock then
        completedCount = completedCount + 1
      end
      count = count + 1
    end
  end
  return count, completedCount
end

function DataModel.GetAllCountInfo(dataTab)
  local allCount = 0
  local allCompletedCount = 0
  for i, tab in ipairs(dataTab) do
    local count, completedCount = DataModel.GetCountInfo(tab)
    allCount = allCount + count
    allCompletedCount = allCompletedCount + completedCount
  end
  return allCount, allCompletedCount
end

function DataModel.GetNewNum(tab)
  local num = 0
  local bookCfg = PlayerData:GetFactoryData(tab.id, "ListFactory")
  for i, v in ipairs(bookCfg.notebook) do
    local prefersKey = v.id
    local dataCfg = PlayerData:GetFactoryData(v.id, "DataFactory")
    for i, noteCfg in ipairs(dataCfg.noteList) do
      if PlayerData:GetHomeInfo().trade_lv >= noteCfg.level and noteCfg.level > PlayerData:GetPlayerPrefs("int", prefersKey) then
        num = num + 1
      end
    end
  end
  return num
end

function DataModel.GetAllNewNum(dataTab)
  local num = 0
  for i, tab in ipairs(dataTab) do
    num = num + DataModel.GetNewNum(tab)
  end
  return num
end

function DataModel.RefreshProgress()
  DataModel.count, DataModel.completedCount = DataModel.GetCountInfo(DataModel.curBookTab)
  View.Group_Progress.StaticGrid_.grid.self:SetDataCount(DataModel.count)
  View.Group_Progress.StaticGrid_.grid.self:RefreshAllElement()
  View.Group_Progress.Img_BGNum.Txt_Num:SetText(string.format("%d/%d", DataModel.completedCount, DataModel.count))
end

function DataModel.ClickMenuRefresh(menuIndex)
  if DataModel.curMenu == menuIndex then
    return
  end
  View.Group_pageA:SetActive(false)
  View.Group_pageB:SetActive(false)
  View.Group_pageA:SetActive(menuIndex > DataModel.curMenu)
  View.Group_pageB:SetActive(menuIndex < DataModel.curMenu)
  local animName = menuIndex > DataModel.curMenu and "PageDown" or "PageUp"
  View.self:PlayAnimOnce(animName)
  local menuElement = DataModel.menuElements[DataModel.curMenu]
  menuElement.Img_Open:SetActive(false)
  menuElement.Img_Close:SetActive(true)
  menuElement = DataModel.menuElements[menuIndex]
  menuElement.Img_Open:SetActive(true)
  menuElement.Img_Close:SetActive(false)
  menuElement.Img_RemindOut:SetActive(false)
  local infoElement = DataModel.noteElements[DataModel.bookIndex][DataModel.curMenu]
  infoElement:SetActive(false)
  infoElement = DataModel.noteElements[DataModel.bookIndex][menuIndex]
  infoElement:SetActive(true)
  DataModel.curMenu = menuIndex
  DataModel.RefreshMenuInfo(menuIndex)
  local prefersKey = DataModel.menuPrefersKey[menuIndex]
  PlayerData:SetPlayerPrefs("int", prefersKey, PlayerData:GetHomeInfo().trade_lv)
end

function DataModel.RefreshMenuInfo(menuIndex)
  local infoElements = DataModel.noteElements[DataModel.bookIndex]
  if infoElements then
    local element = infoElements[menuIndex]
    local imgCount = 0
    local unLockImgCount = 0
    local cfg = DataModel.noteBook[menuIndex]
    local dataCfg = PlayerData:GetFactoryData(cfg.id, "DataFactory")
    for i, v in pairs(dataCfg.noteList) do
      if element[v.path] then
        local unLock = PlayerData:GetHomeInfo().trade_lv >= v.level
        element[v.path]:SetActive(unLock)
        if unLock then
          unLockImgCount = unLockImgCount + 1
        end
      end
      imgCount = imgCount + 1
    end
  end
end

function DataModel.GetMenuRedPointState(menuIndex)
  local prefersKey = DataModel.menuPrefersKey[menuIndex]
  local cfg = DataModel.noteBook[menuIndex]
  local dataCfg = PlayerData:GetFactoryData(cfg.id, "DataFactory")
  for i, v in pairs(dataCfg.noteList) do
    if PlayerData:GetHomeInfo().trade_lv >= v.level and v.level > PlayerData:GetPlayerPrefs("int", prefersKey) then
      return true
    end
  end
  return false
end

return DataModel
