local View = require("UINotice_beforeLogin/UINotice_beforeLoginView")
local DataModel = {}

function DataModel.Init(count)
  DataModel.RightList = {}
  local row = {}
  for i = 0, count - 1 do
    row = Json.decode(NoticeManager:GetNoticeData(i))
    row.img = string.sub(row.img, 2, -2)
    row.img_titile = string.sub(row.img_titile, 2, -2)
    row.content = row.content:gsub("<br>", "\n")
    row.content = row.content:gsub("<br/>", "\n")
    table.insert(DataModel.RightList, row)
  end
  View.ScrollGrid_.grid.self:SetDataCount(table.count(DataModel.RightList))
  View.ScrollGrid_.grid.self:RefreshAllElement()
  DataModel.RightIndex = nil
  DataModel.ClickRightTab(1)
end

function DataModel:LeftDetail(row)
  local Group_main = View.Group_main
  Group_main.Group_Title.Txt_Title:SetText(row.left_titile or "")
  Group_main.Group_Title.Txt_Time:SetText(row.left_time)
  Group_main.Group_Title.Img_BG:SetSprite(row.img_titile)
  Group_main.Group_details.ScrollView_.Viewport.Content.TextHyperlink_Main:SetText(row.content)
  Group_main.Group_details.ScrollView_.Viewport.Content.self:SetLocalPositionY(0)
end

function DataModel.ClickRightTab(index)
  if DataModel.RightIndex and index == DataModel.RightIndex then
    return
  end
  local grid = View.ScrollGrid_.grid.self
  local old_element, now_element
  if DataModel.RightIndex and grid:GetChildByIndex(DataModel.RightIndex - 1) then
    old_element = grid:GetChildByIndex(DataModel.RightIndex - 1):GetComponent(typeof(CS.Seven.UIGridItemIndex)).element
    old_element.Btn_Tab.Img_On:SetActive(false)
  end
  if grid:GetChildByIndex(index - 1) then
    now_element = grid:GetChildByIndex(index - 1):GetComponent(typeof(CS.Seven.UIGridItemIndex)).element
    now_element.Btn_Tab.Img_On:SetActive(true)
  end
  DataModel.RightIndex = index
  local row = DataModel.RightList[index]
  DataModel:LeftDetail(row)
end

return DataModel
