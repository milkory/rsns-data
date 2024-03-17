local DataModel = {
  paragraphId = 1,
  contentId = 1,
  paragraphContent = nil,
  offset_height = 30,
  extra_options = {index = 0},
  dialog_content = {count = 0},
  coache_paragraph = 0,
  coache_content = 0
}
local CalItemHeight = function(txt, dialog_index)
  local height = 0
  if DataModel.dialog_content[dialog_index].dialog_info.content then
    txt:SetText(DataModel.dialog_content[dialog_index].dialog_info.content)
    height = txt:GetHeight() + DataModel.offset_height
  else
    height = DataModel.dialog_content[dialog_index].dialog_info.count * 50
  end
  return height
end
local CalItemPosY = function(txt, pre_dialog)
  local posy = 0
  if 0 < pre_dialog then
    posy = DataModel.dialog_content[pre_dialog].pos - CalItemHeight(txt, pre_dialog)
  end
  return posy
end
local ReplaceName = function(content, plotCA)
  if content ~= nil and plotCA.isReplaceName then
    local userInfo = PlayerData:GetUserInfo()
    local playerName = ""
    if userInfo ~= nil then
      playerName = userInfo.role_name
    end
    content = string.gsub(content, plotCA.replaceType, playerName)
  end
  return content
end
local UpdateItemData = function(id, dialog_info, pos, plotCA)
  if dialog_info == nil then
    local plotId = require("UIDialog/UIDialogDataModel").CurrentParagraphId
    error("plotId:" .. plotId .. "  paragraphId:" .. "  index:" .. id)
  end
  if plotCA then
    dialog_info.content = ReplaceName(dialog_info.content, plotCA)
  end
  DataModel.dialog_content[id] = {
    id = id,
    dialog_info = dialog_info,
    pos = pos
  }
end
local HandleCheckBox = function(paragraph_id)
  local plotCA = DataModel.paragraphContent[paragraph_id]
  if plotCA and plotCA.mod == "复选框" then
    local dialog_info = {count = 0}
    for i = 1, 3 do
      local text = plotCA["text_" .. i]
      if text ~= nil and text ~= "" then
        table.insert(dialog_info, text)
        dialog_info.count = dialog_info.count + 1
      end
    end
    DataModel.extra_options.index = DataModel.extra_options.index + 1
    local select_id = DataModel.extra_options[DataModel.extra_options.index]
    dialog_info.select_id = select_id
    return dialog_info
  end
  return nil
end

function DataModel.init(txt)
  local dialog_cnt = DataModel.dialog_content.count
  local start_index = DataModel.coache_paragraph > 0 and DataModel.coache_paragraph or 1
  for i = start_index, DataModel.paragraphId - 1 do
    local content_list
    local textInfo = DataModel.paragraphContent[i]
    if textInfo then
      content_list = textInfo.contextList
    end
    if content_list then
      local count = #content_list
      local content_index = 1
      if i == DataModel.coache_paragraph then
        content_index = 0 < DataModel.coache_content and DataModel.coache_content + 1 or 1
      end
      for i = content_index, count do
        local pos = CalItemPosY(txt, dialog_cnt)
        dialog_cnt = dialog_cnt + 1
        UpdateItemData(dialog_cnt, content_list[i], pos, textInfo)
      end
    end
    local dialog_info = HandleCheckBox(i)
    if dialog_info then
      local now_index = dialog_cnt
      if DataModel.dialog_content[dialog_cnt] then
        now_index = dialog_cnt - 1
      end
      local pos = CalItemPosY(txt, now_index)
      dialog_cnt = now_index + 1
      UpdateItemData(dialog_cnt, dialog_info, pos)
    end
  end
  local content_list
  local textInfo = DataModel.paragraphContent[DataModel.paragraphId]
  if textInfo then
    content_list = textInfo.contextList
  end
  if content_list then
    local content_index = 1
    if start_index == DataModel.paragraphId then
      content_index = 0 < DataModel.coache_content and DataModel.coache_content + 1 or 1
    end
    for i = content_index, DataModel.contentId do
      local pos = CalItemPosY(txt, dialog_cnt)
      dialog_cnt = dialog_cnt + 1
      UpdateItemData(dialog_cnt, content_list[i], pos, textInfo)
    end
  elseif DataModel.coache_paragraph ~= DataModel.paragraphId then
    local dialog_info = HandleCheckBox(DataModel.paragraphId)
    if dialog_info then
      DataModel.extra_options.index = DataModel.extra_options.index - 1
      local pos = CalItemPosY(txt, dialog_cnt)
      dialog_cnt = dialog_cnt + 1
      UpdateItemData(dialog_cnt, dialog_info, pos)
    end
  end
  DataModel.dialog_content.count = dialog_cnt
  DataModel.coache_paragraph = DataModel.paragraphId
  DataModel.coache_content = DataModel.contentId
  if 0 < dialog_cnt then
    DataModel.last_item_height = CalItemHeight(txt, dialog_cnt)
  end
end

function DataModel.ClearCoachData()
  DataModel.dialog_content = {count = 0}
  DataModel.extra_options = {index = 0}
  DataModel.coache_paragraph = 0
  DataModel.coache_content = 0
end

return DataModel
