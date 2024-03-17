local View = require("UIgTips/UIgTipsView")
local DataModel = require("UIgTips/UIgTipsDataModel")
local ViewFunction = {
  gTips_Btn_Shade_Click = function(btn, str)
  end,
  gTips_Group_Sign_Group_Change_Btn_Change_Click = function(btn, str)
    DOTweenTools.DOLocalMoveCallback(View.Group_Sign.transform, 0, 1080, 0, 0.3, function()
      View.Group_Sign:SetLocalPositionY(0, 0)
      View.self:SetActive(false)
    end, 1)
  end
}
return ViewFunction
