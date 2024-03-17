local View = require("UIPlantTips/UIPlantTipsView")
local DataModel = require("UIPlantTips/UIPlantTipsDataModel")
local ViewFunction = {
  PlantTips_Btn_BG_Click = function(btn, str)
    UIManager:CloseTip("UI/Home_plant/PlantTips")
  end,
  PlantTips_Btn_OK_Click = function(btn, str)
    UIManager:CloseTip("UI/Home_plant/PlantTips")
  end
}
return ViewFunction
