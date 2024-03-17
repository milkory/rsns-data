local View = require("UIHomeBubblePassenger/UIHomeBubblePassengerView")
local DataModel = require("UIHomeBubblePassenger/UIHomeBubblePassengerDataModel")
local ViewFunction = {
  HomeBubblePassenger_Btn_Close_Click = function(btn, str)
    View.self:CloseUI()
    View.self:Confirm()
  end,
  HomeBubblePassenger_Group_Panel_Img_BubbleBG_Btn_Interactive_Click = function(btn, str)
    UIManager:Open("UI/Passenger/Passenger", "", function()
      View.self:Confirm()
    end)
  end
}
return ViewFunction
