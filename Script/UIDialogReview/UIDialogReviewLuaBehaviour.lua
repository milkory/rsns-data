local View = require("UIDialogReview/UIDialogReviewView")
local DataModel = require("UIDialogReview/UIDialogReviewDataModel")
local ViewFunction = require("UIDialogReview/UIDialogReviewViewFunction")
local customSV = require("Common/CustomSV")
local DialogDataModel = require("UIDialog/UIDialogDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local text = View.CustomScrollGrid_LOG.grid[1].Group_Text.Txt_Text
    View.CustomScrollGrid_LOG.grid[1]:SetActive(true)
    View.CustomScrollGrid_LOG.grid[1].Group_Text:SetActive(true)
    DataModel.init(text)
    local height = 0
    local count = DataModel.dialog_content.count
    if 0 < count then
      height = -DataModel.dialog_content[count].pos + DataModel.last_item_height
    end
    View.CustomScrollGrid_LOG.self:SetLuaGrid(ViewFunction.DialogReview_CustomScrollGrid_LOG_SetGrid)
    View.CustomScrollGrid_LOG.self:UpdateGridWidthOrHeight(height)
    View.myCustomSV:RefreshData(DataModel.dialog_content, View.CustomScrollGrid_LOG.self.viewportCount)
    View.myCustomSV:RefreshAllElementToBottom(View.CustomScrollGrid_LOG.self.scrollRect)
    DataModel.isAutoPlay = DialogDataModel.isAuto
    if DataModel.isAutoPlay then
      DialogDataModel.isAuto = false
    end
  end,
  awake = function()
    View.myCustomSV = customSV.New(View.CustomScrollGrid_LOG.grid, true, function(element, index)
      local name = DataModel.dialog_content[index].dialog_info.speakerName
      name = name == "" and GetText(80601218) or name
      if DataModel.dialog_content[index].dialog_info.content then
        element.Group_Text:SetActive(true)
        element.Group_Choose:SetActive(false)
        element.Group_Text.Txt_Post:SetText(string.format(GetText(80601222), name .. "："))
        local content = DataModel.dialog_content[index].dialog_info.content
        element.Group_Text.Txt_Text:SetText(string.format(GetText(80601222), content))
        if DataModel.dialog_content[index + 1] then
          element.self:SetHeight(-DataModel.dialog_content[index + 1].pos + DataModel.dialog_content[index].pos)
        else
          element.self:SetHeight(DataModel.last_item_height)
        end
        if DataModel.dialog_content.count == index then
          element.Group_Text.Txt_Post:SetText(string.format(GetText(80601219), name .. "："))
          element.Group_Text.Txt_Text:SetText(string.format(GetText(80601220), content))
        end
      else
        element.Group_Text:SetActive(false)
        element.Group_Choose:SetActive(true)
        local dialog_info = DataModel.dialog_content[index].dialog_info
        for i = 1, 3 do
          if i <= dialog_info.count then
            local group = element.Group_Choose["Group_" .. i]
            group:SetActive(true)
            group.Txt_Choice:SetText(string.format(GetText(80601222), dialog_info[i]))
            if i == dialog_info.select_id then
              group.Txt_NameChoose:SetText(string.format(GetText(80601221), PlayerData:GetUserInfo().role_name .. "："))
              group.Txt_Choice:SetText(string.format(GetText(80601221), dialog_info[i]))
              group.Txt_NameChoose:SetActive(true)
              group.Img_0:SetActive(true)
            else
              group.Txt_NameChoose:SetActive(false)
              group.Img_0:SetActive(false)
            end
          else
            element.Group_Choose["Group_" .. i]:SetActive(false)
          end
        end
        if DataModel.dialog_content[index + 1] then
          element.self:SetHeight(-DataModel.dialog_content[index + 1].pos + DataModel.dialog_content[index].pos)
        else
          element.self:SetHeight(DataModel.last_item_height)
        end
      end
      if DataModel.dialog_content.count == index then
        element.Img_Now:SetActive(true)
      else
        element.Img_Now:SetActive(false)
      end
    end)
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    DialogDataModel.isAuto = DataModel.isAutoPlay
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
