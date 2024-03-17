local View = require("UIGroup_InputName/UIGroup_InputNameView")
local DataModel = require("UIGroup_InputName/UIGroup_InputNameDataModel")
local Controller = require("UIGroup_InputName/UIGroup_InputNameController")
local ViewFunction = {
  Group_InputName_Group_BG_Btn_Close_Click = function(btn, str)
    if DataModel.isGuide == false then
      UIManager:GoBack(false, 1)
    end
  end,
  Group_InputName_Group_BG_Btn_Confirm_Click = function(btn, str)
    Controller:ModifyName()
  end,
  Group_InputName_Group_BG_Btn_Cancel_Click = function(btn, str)
    if DataModel.isGuide == false then
      UIManager:GoBack(false, 1)
    end
  end,
  Group_InputName_Group_BG_Btn_Random_Click = function(btn, str)
    Controller:RandomName()
  end
}
return ViewFunction
