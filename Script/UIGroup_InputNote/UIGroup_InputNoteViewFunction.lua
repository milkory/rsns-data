local View = require("UIGroup_InputNote/UIGroup_InputNoteView")
local DataModel = require("UIGroup_InputNote/UIGroup_InputNoteDataModel")
local Controller = require("UIGroup_InputNote/UIGroup_InputNoteController")
local ViewFunction = {
  Group_InputNote_Btn_Close_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  Group_InputNote_Btn_Confirm_Click = function(btn, str)
    Controller:ModifyNote()
  end,
  Group_InputNote_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end
}
return ViewFunction
