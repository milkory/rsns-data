local View = require("UITalkPlus/UITalkPlusView")
local DataModel = require("UITalkPlus/UITalkPlusDataModel")
local Controller = require("UITalkPlus/UITalkPlusController")
local ViewFunction = {
  TalkPlus_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  TalkPlus_ScrollGrid_List_Group_Talk_Btn_Talk_Click = function(btn, str)
    Controller:ElementClick(str)
  end
}
return ViewFunction
