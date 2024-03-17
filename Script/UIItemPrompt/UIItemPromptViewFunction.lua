local View = require("UIItemPrompt/UIItemPromptView")
local DataModel = require("UIItemPrompt/UIItemPromptDataModel")
local ViewFunction = {
  ItemPrompt_Btn_BG_Click = function(btn, str)
    if DataModel.params.isBgClick then
      UIManager:GoBack(false, 1)
    end
  end,
  ItemPrompt_Btn_Confirm_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    View.self:Confirm()
  end,
  ItemPrompt_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    View.self:Cancel()
  end,
  ItemPrompt_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenItem({itemId = itemId})
  end
}
return ViewFunction
