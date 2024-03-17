local View = require("UIQuestComplete/UIQuestCompleteView")
local DataModel = require("UIQuestComplete/UIQuestCompleteDataModel")
local ItemCommon = require("Common/BtnItem")
local ViewFunction = {
  QuestComplete_Btn_Close_Click = function(btn, str)
    View.self:CloseUI()
    View.self:Confirm()
  end,
  QuestComplete_ScrollGrid_QuestList_SetGrid = function(element, elementIndex)
    local info = DataModel.QuestInfo[elementIndex]
    if info.clientImagePath then
      element.Group_Anim.Img_Mask.Img_Client:SetSprite(info.clientImagePath)
      element.Group_Anim.Txt_Client:SetActive(true)
      if info.clientName ~= "" then
        element.Group_Anim.Txt_Client:SetText(string.format(GetText(80601051), info.clientName))
      else
        element.Group_Anim.Txt_Client:SetText(info.clientName)
      end
    else
      element.Group_Anim.Txt_Client:SetActive(false)
    end
    element.Group_Anim.Txt_Name:SetText(info.questName)
    element.Group_Anim.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
    element.Group_Anim.ScrollGrid_Reward.grid.self:SetDataCount(#info.reward)
    element.Group_Anim.ScrollGrid_Reward.grid.self:RefreshAllElement()
    element.Group_Anim.ScrollGrid_Reward.grid.self:MoveToTop()
  end,
  QuestComplete_ScrollGrid_QuestList_Group_Item_Group_Anim_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local info = DataModel.QuestInfo[tonumber(element.ParentParam)].reward[elementIndex]
    ItemCommon:SetItem(element.Group_Item, {
      id = info.id,
      num = info.num
    }, nil, nil, View)
    element.Group_Item.Btn_Item:SetClickParam(info.id)
  end,
  QuestComplete_ScrollGrid_QuestList_Group_Item_Group_Anim_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local id = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(id)
  end,
  QuestComplete_ShowItem_Btn_OK_Click = function(btn, str)
  end,
  QuestComplete_ShowItem_ScrollGrid_Items_SetGrid = function(element, elementIndex)
  end,
  QuestComplete_ShowItem_ScrollGrid_Items_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end
}
return ViewFunction
