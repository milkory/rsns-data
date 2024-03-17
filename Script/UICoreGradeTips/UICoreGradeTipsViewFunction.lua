local View = require("UICoreGradeTips/UICoreGradeTipsView")
local DataModel = require("UICoreGradeTips/UICoreGradeTipsDataModel")
local Controller = require("UICoreGradeTips/UICoreGradeTipsController")
local ViewFunction = {
  CoreGradeTips_Group_Overview_Btn__Click = function(btn, str)
    UIManager:GoBack()
  end,
  CoreGradeTips_Group_Overview_Page_Grade_SetPage = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  CoreGradeTips_Group_Overview_Page_Grade_PageDrag = function(dragOffsetPos)
    local curIdx = math.abs(dragOffsetPos) + 1
    local deltaValue = curIdx + DataModel.defaultOffset - DataModel.curSelectIdx
    if deltaValue < 0 then
      curIdx = math.floor(curIdx + 0.5)
    elseif 0 < deltaValue then
      curIdx = math.ceil(curIdx - 0.5)
    end
    Controller:Select(curIdx + DataModel.defaultOffset)
  end,
  CoreGradeTips_Group_Overview_Page_Grade_PageDragComplete = function(index)
    Controller:Select(math.abs(index) + 1 + DataModel.defaultOffset)
  end,
  CoreGradeTips_Group_Overview_Page_Grade_PageDragBegin = function(dragOffsetPos)
  end,
  CoreGradeTips_Group_Overview_Page_Grade_Group_Item_Group_Child_Btn__Click = function(btn, str)
    Controller:ClickPageBtn(str)
  end,
  CoreGradeTips_Group_Overview_Group_Information_Group_Dec_Group_Upgrade_StaticGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetChildDecElement(element, elementIndex)
  end,
  CoreGradeTips_Group_Overview_Group_Information_Group_Dec_Group_Break_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CoreGradeTips_Group_Overview_Group_Information_Group_Dec_Group_Break_StaticGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetChildBreakElement(element, elementIndex)
  end,
  CoreGradeTips_Group_Overview_Group_Information_Group_Dec_Group_Break_StaticGrid_List_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickItem(str)
  end,
  CoreGradeTips_Group_Overview_Group_Information_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:SetRewardElement(element, elementIndex)
  end,
  CoreGradeTips_Group_Overview_Group_Information_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickItem(str)
  end,
  CoreGradeTips_Group_Overview_Group_Btn_Group_Already_Btn__Click = function(btn, str)
    Controller:ClickGetReward()
  end
}
return ViewFunction
