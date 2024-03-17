local View = require("UIBargainBuff/UIBargainBuffView")
local DataModel = require("UIBargainBuff/UIBargainBuffDataModel")
local Controller = require("UIBargainBuff/UIBargainBuffController")
local ViewFunction = {
  BargainBuff_Group_Spine_Btn_Skip_Click = function(btn, str)
    Controller:SkipSpine()
  end
}
return ViewFunction
