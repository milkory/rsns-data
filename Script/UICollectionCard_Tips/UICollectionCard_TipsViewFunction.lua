local View = require("UICollectionCard_Tips/UICollectionCard_TipsView")
local DataModel = require("UICollectionCard_Tips/UICollectionCard_TipsDataModel")
local ViewFunction = {
  CollectionCard_Tips_Btn_Return_Click = function(btn, str)
    View.self:CloseUI()
  end
}
return ViewFunction
