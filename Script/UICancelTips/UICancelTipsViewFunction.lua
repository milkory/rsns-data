local View = require("UICancelTips/UICancelTipsView")
local DataModel = require("UICancelTips/UICancelTipsDataModel")
local ViewFunction = {
  CancelTips_Btn_BG_Click = function(btn, str)
    UIManager:CloseTip("UI/Home/HomeSafe/CancelTips")
  end,
  CancelTips_Btn_Cancel_Click = function(btn, str)
    UIManager:CloseTip("UI/Home/HomeSafe/CancelTips")
  end,
  CancelTips_Btn_Confirm_Click = function(btn, str)
    Net:SendProto("building.cancel_share", function(json)
      View.self:Confirm()
      UIManager:CloseTip("UI/Home/HomeSafe/CancelTips")
      local data = {
        gold = {
          ["11400001"] = {
            num = DataModel.value
          }
        }
      }
      CommonTips.OpenShowItem(data)
    end, DataModel.key)
  end
}
return ViewFunction
