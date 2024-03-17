local View = require("UISkip/UISkipView")
local DataModel = require("UISkip/UISkipDataModel")
local ViewFunction = {
  Skip_Btn_Skip_Click = function(btn, str)
    VideoManager:VideoOver()
    if DataModel.Cards == nil then
      return
    end
    if DataModel.Type == EnumDefine.DrawCard.Ten then
      UIManager:Open("UI/Gacha/TenPulls", Json.encode(DataModel.Cards))
    else
      DataModel.data.type = EnumDefine.DrawCard.OneSkip
      UIManager:Open("UI/ShowCharacter/ShowCharacter", Json.encode(DataModel.data), nil, nil, false, true)
    end
  end
}
return ViewFunction
