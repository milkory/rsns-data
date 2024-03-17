local View = require("UIStoryItemTip/UIStoryItemTipView")
local DataModel = require("UIStoryItemTip/UIStoryItemTipDataModel")
local ViewFunction = {
  StoryItemTip_Btn_BG_Click = function(btn, str)
    if DataModel.CA.id == 11400027 and DataModel.Music then
      SoundManager:PauseBGM(false)
      DataModel.Music:Stop()
    end
    UIManager:GoBack(false, 1)
  end,
  StoryItemTip_Group_tape_Group_Time_Slider_Time_Slider = function(slider, value)
    DataModel.OnValueChange(value)
  end,
  StoryItemTip_Group_tape_Group_Time_Slider_Time_SliderDown = function(slider)
    DataModel.OnPoint(true)
  end,
  StoryItemTip_Group_tape_Group_Time_Slider_Time_SliderUp = function(slider)
    DataModel.OnPoint(false)
  end
}
return ViewFunction
