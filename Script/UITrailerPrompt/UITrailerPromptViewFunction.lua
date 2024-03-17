local View = require("UITrailerPrompt/UITrailerPromptView")
local DataModel = require("UITrailerPrompt/UITrailerPromptDataModel")
local MapDataModel = require("UIHome/UIHomeMapDataModel")
local ViewFunction = {
  TrailerPrompt_Btn_BG_Click = function(btn, str)
    UIManager:CloseTip("UI/MainUI/TrailerPrompt")
  end,
  TrailerPrompt_Btn_Cancel_Click = function(btn, str)
    UIManager:CloseTip("UI/MainUI/TrailerPrompt")
  end,
  TrailerPrompt_Btn_Confirm_Click = function(btn, str)
    UIManager:CloseTip("UI/MainUI/TrailerPrompt")
    local MainController = require("UIMainUI/UIMainUIController")
    MainController.GoToNewCity(nil, nil, true)
  end
}
return ViewFunction
