local View = require("UIGachaDetails/UIGachaDetailsView")
local DataModel = require("UIGachaDetails/UIGachaDetailsDataModel")
local Controller = {}

function Controller:Init()
  DataModel.extractCA = PlayerData:GetFactoryData(DataModel.param.id)
  local tagCA = PlayerData:GetFactoryData(DataModel.extractCA.protectTag)
  DataModel.maxPageNum = 100000
  DataModel.gachaRecordTable = {}
  View.Group_Record.Img_Tips.Txt_Tips:SetText(tagCA.recordTips)
  Controller:Select(DataModel.SelectType.ViewDetail, true)
end

function Controller:Select(type, force)
  if not force and type == DataModel.curSelect then
    return
  end
  DataModel.curSelect = type
  local isViewDetail = type == DataModel.SelectType.ViewDetail
  local isGachaRecord = type == DataModel.SelectType.GachaRecord
  View.ScrollView_Details:SetActive(isViewDetail)
  View.Btn_Details.Img_On:SetActive(isViewDetail)
  View.Btn_Record.Img_On:SetActive(isGachaRecord)
  View.Group_Record:SetActive(isGachaRecord)
  if type == DataModel.SelectType.ViewDetail then
    Controller:ShowViewDetail()
  elseif type == DataModel.SelectType.GachaRecord then
    Controller:ShowGachaRecord(1, true)
  end
end

function Controller:ShowViewDetail()
  local extract = DataModel.extractCA.details
  View.ScrollView_Details.Viewport.Txt_Details:SetText(extract)
  View.ScrollView_Details:SetVerticalNormalizedPosition(1)
end

function Controller:ShowGachaRecord(page, force)
  if not force and page == DataModel.curSelectPage then
    return
  end
  if page < 1 or page > DataModel.maxPageNum then
    return
  end
  local count = #DataModel.gachaRecordTable
  local isNull = count == 0
  local isRequest = count <= DataModel.defaultClientPageNum * (page - 1)
  View.Group_Record.Group_Null:SetActive(isNull)
  View.Group_Record.Group_Data:SetActive(not isNull)
  if isRequest then
    Net:SendProto("recruit.records", function(json)
      if json.record_cnt then
        DataModel.maxPageNum = math.ceil(json.record_cnt / DataModel.defaultClientPageNum)
      end
      if json.card_records and #json.card_records > 0 then
        DataModel.curSelectPage = page
        for k, v in ipairs(json.card_records) do
          table.insert(DataModel.gachaRecordTable, v)
        end
        count = #DataModel.gachaRecordTable
        isNull = count == 0
        View.Group_Record.Group_Null:SetActive(isNull)
        View.Group_Record.Group_Data:SetActive(not isNull)
        View.Group_Record.Group_Data.StaticGrid_List.grid.self:RefreshAllElement()
      else
        DataModel.maxPageNum = page - 1
      end
      View.Group_Record.Group_Data.Txt_Page:SetText(page .. "/" .. DataModel.maxPageNum)
    end, DataModel.extractCA.protectTag, DataModel.defaultToServerPageNum, math.floor(count / DataModel.defaultToServerPageNum) + 1)
  else
    DataModel.curSelectPage = page
    if not isNull then
      View.Group_Record.Group_Data.StaticGrid_List.grid.self:RefreshAllElement()
      View.Group_Record.Group_Data.Txt_Page:SetText(page .. "/" .. DataModel.maxPageNum)
    end
  end
end

function Controller:ShowRecordElement(element, elementIndex)
  local curIdx = (DataModel.curSelectPage - 1) * DataModel.defaultClientPageNum + elementIndex
  local info = DataModel.gachaRecordTable[curIdx]
  local isShow = info ~= nil
  element:SetActive(isShow)
  if isShow then
    local unitCA = PlayerData:GetFactoryData(info.role_id)
    local color = "#FFFFFF"
    if unitCA.qualityInt >= 4 then
      color = "#FFE266"
    elseif unitCA.qualityInt >= 3 then
      color = "#E4B7FF"
    end
    element.Txt_Character:SetText(unitCA.name)
    element.Txt_Character:SetColor(color)
    local name
    if info.card_id and info.card_id ~= "" then
      local ca = PlayerData:GetFactoryData(info.card_id)
      name = ca.name
    else
      name = GetText(80605604)
    end
    element.Txt_TagName:SetText(name)
    element.Txt_Time:SetText(os.date("%Y-%m-%d %H:%M:%S", info.obtain_time))
  end
end

return Controller
