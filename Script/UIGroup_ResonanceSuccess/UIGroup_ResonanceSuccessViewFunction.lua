local View = require("UIGroup_ResonanceSuccess/UIGroup_ResonanceSuccessView")
local DataModel = require("UIGroup_ResonanceSuccess/UIGroup_ResonanceSuccessDataModel")
local ViewFunction = {
  Group_ResonanceSuccess_Btn_Close_Click = function(btn, str)
    View.self:PlayAnim("ResonanceSuccessOut", function()
      UIManager:GoBack(false, 1)
    end)
  end
}
return ViewFunction
