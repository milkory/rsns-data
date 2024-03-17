local View = require("UIIllustration_Character/UIIllustration_CharacterView")
local DataModel = require("UIIllustration_Character/UIIllustration_CharacterDataModel")
local Controller = {}

function Controller:Init()
  DataModel.GetNumList = {}
  local getNumList = {}
  DataModel.IsReadNum = 0
  DataModel.UnitList = {}
  DataModel.AllUnitList = {}
  DataModel.NowShowList = {}
  local unitList = PlayerData:GetFactoryData(80900001).unitList
  DataModel.AllUnitNum = table.count(unitList)
  local allGetNum = 0
  for k, v in pairs(unitList) do
    local row = {}
    local ca = PlayerData:GetFactoryData(v.id)
    row.qualityInt = ca.qualityInt
    row.name = ca.name
    row.isSpine2 = ca.isSpine2
    row.line = ca.line
    row.id = v.id
    row.viewId = ca.viewId
    row.sideId = ca.sideId
    row.line = ca.line
    local tagCA = PlayerData:GetFactoryData(ca.sideId)
    row.tagIcon = tagCA.icon
    local portrailData = PlayerData:GetFactoryData(row.viewId)
    row.roleRes = portrailData.roleListResUrl
    row.server = PlayerData:GetRoleById(row.id)
    row.sortIndex = 0
    row.isGet = false
    if 0 < table.count(row.server) then
      row.viewId = row.server.current_skin[1]
      row.isGet = true
      allGetNum = allGetNum + 1
      row.sortIndex = 1
    end
    table.insert(DataModel.AllUnitList, row)
    if DataModel.UnitList[row.sideId] == nil then
      DataModel.UnitList[row.sideId] = {}
    end
    if getNumList[row.sideId] == nil then
      getNumList[row.sideId] = 0
      if row.isGet then
        getNumList[row.sideId] = 1
      end
    elseif row.isGet then
      getNumList[row.sideId] = getNumList[row.sideId] + 1
    end
    table.insert(DataModel.UnitList[row.sideId], row)
  end
  local enumSideList = PlayerData:GetFactoryData(99900017).bookCharacterSideEnumList
  DataModel.EnumSideList = {}
  table.insert(DataModel.EnumSideList, {
    id = "",
    sideName = "全部",
    icon = "UI/Book/Character_Illustration/Allicon",
    index = 1
  })
  DataModel.EnumSideIndex = {}
  DataModel.EnumSideIndex[1] = DataModel.AllUnitList
  DataModel.GetNumList[1] = table.count(PlayerData:GetRoles())
  for i = 1, table.count(enumSideList) do
    local row = {}
    local ca = PlayerData:GetFactoryData(enumSideList[i].id)
    row.index = i + 1
    row.icon = ca.icon
    row.sideName = ca.sideName
    row.id = ca.id
    DataModel.EnumSideIndex[row.index] = DataModel.UnitList[ca.id]
    DataModel.GetNumList[row.index] = getNumList[ca.id]
    table.insert(DataModel.EnumSideList, row)
  end
  for k, v in pairs(DataModel.EnumSideIndex) do
    table.sort(v, function(a, b)
      if a.sortIndex == b.sortIndex then
        if a.qualityInt == b.qualityInt then
          return a.id > b.id
        end
        return a.qualityInt > b.qualityInt
      end
      return a.sortIndex > b.sortIndex
    end)
  end
  DataModel.RightIndex = 1
  DataModel.SortStateBtn = nil
  DataModel.SortStateIndex = 0
  DataModel.isFirst = true
  Controller:Reset(View.Group_RowSelected.Btn_All)
  View.Group_RightList.ScrollGrid_RightList.grid.self:SetDataCount(table.count(DataModel.EnumSideList))
  View.Group_RightList.ScrollGrid_RightList.grid.self:RefreshAllElement()
end

function Controller:RefreshBtn(btn)
  if DataModel.SortStateBtn and DataModel.SortStateBtn == btn then
    return
  end
  btn.Img_AN:SetActive(false)
  if DataModel.SortStateBtn then
    DataModel.SortStateBtn.Img_AN:SetActive(true)
  end
  DataModel.SortStateBtn = btn
  Controller:RefreshData()
end

function Controller:Reset(btn)
  for key, value in pairs(View.Group_RowSelected) do
    if key ~= "self" then
      value.Img_AN:SetActive(true)
      value.Img_AN:SetActive(true)
    end
  end
  Controller:RefreshBtn(btn)
end

function Controller:ChooseRightIndex(index)
  if index and index == DataModel.RightIndex then
    return
  end
  if View.Group_RightList.ScrollGrid_RightList.grid[DataModel.RightIndex] then
    local old_element = View.Group_RightList.ScrollGrid_RightList.grid[DataModel.RightIndex]
    old_element.Btn_Side.Img_Selected:SetActive(false)
    old_element.Btn_Side.Img_UnSelected:SetActive(true)
  end
  DataModel.RightIndex = index
  local element = View.Group_RightList.ScrollGrid_RightList.grid[index]
  element.Btn_Side.Img_Selected:SetActive(true)
  element.Btn_Side.Img_UnSelected:SetActive(false)
  Controller:RefreshData()
end

function Controller:OpenRoleTip(row, index)
  local params = {
    id = row.id,
    content = row,
    isBook = true
  }
  if row.server.read and row.server.read == 0 then
    Net:SendProto("hero.read", function(json)
      PlayerData:GetRoleById(row.id).read = 1
      row.server.read = 1
      local element = DataModel.Element[index]
      element.Btn_Card.Img_New:SetActive(false)
      CommonTips.OpenUnitDetail(params)
    end, row.id)
    return
  end
  CommonTips.OpenUnitDetail(params)
end

function Controller:RightTopNum()
  local sideData = DataModel.EnumSideList[DataModel.RightIndex]
  View.Group_TopRight.Txt_SideName:SetText(sideData.sideName)
  View.Group_TopRight.Txt_Num:SetText(DataModel.TopSortNum .. "/" .. table.count(DataModel.NowShowList))
end

function Controller:SortList()
  local t_List = DataModel.EnumSideIndex[DataModel.RightIndex]
  DataModel.TopSortNum = DataModel.GetNumList[DataModel.RightIndex]
  if DataModel.SortStateIndex == 0 then
    DataModel.NowShowList = t_List
  else
    local num = 0
    for k, v in pairs(t_List) do
      if v.line == DataModel.SortStateIndex or v.line == 0 then
        if 0 < table.count(v.server) then
          num = num + 1
        end
        table.insert(DataModel.NowShowList, v)
      end
    end
    DataModel.TopSortNum = num
  end
end

function Controller:RefreshData(type)
  DataModel.NowShowList = {}
  Controller:SortList()
  DataModel.Element = {}
  if DataModel.isFirst then
    View.Group_Card.NewScrollGrid_Card.grid.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      View.Group_Card.NewScrollGrid_Card.grid.self:SetDataCount(table.count(DataModel.NowShowList))
      View.Group_Card.NewScrollGrid_Card.grid.self:RefreshAllElement()
      View.Group_Card.NewScrollGrid_Card.grid.self:MoveToTop()
    end))
    DataModel.isFirst = false
  else
    View.Group_Card.NewScrollGrid_Card.grid.self:SetDataCount(table.count(DataModel.NowShowList))
    View.Group_Card.NewScrollGrid_Card.grid.self:RefreshAllElement()
    View.Group_Card.NewScrollGrid_Card.grid.self:MoveToTop()
  end
  Controller:RightTopNum()
end

function Controller:SetElement(element, row)
  element.Img_BG:SetSprite(UIConfig.BookCharacterQuality[row.qualityInt])
  element.Txt_Name:SetText(row.name)
  element.Group_Character.Img_Character:SetSprite(row.roleRes)
  element.Group_Character.Img_Character:SetActive(true)
  element.Img_New:SetActive(false)
  element.Img_Uncollected:SetActive(false)
  if table.count(row.server) == 0 then
    element.Img_Uncollected:SetActive(true)
  elseif row.server.read == 0 then
    element.Img_New:SetActive(true)
  end
  local Group_SkillColor = element.Group_SkillColor
  local cardList = PlayerData:GetRoleCardList(row.id)
  for i = 1, table.count(cardList) do
    local obj = "Img_SkillColor" .. i
    local cardCA = PlayerData:GetFactoryData(cardList[i].id)
    local color = cardCA.color
    Group_SkillColor[obj]:SetSprite(UIConfig.CharacterSkillColor[color])
  end
  element.Img_sideIcon:SetSprite(row.tagIcon)
  element.Img_Row:SetSprite(UIConfig.CharacterBookLine[row.line])
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

return Controller
