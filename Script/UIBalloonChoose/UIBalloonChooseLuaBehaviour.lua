local View = require("UIBalloonChoose/UIBalloonChooseView")
local DataModel = require("UIBalloonChoose/UIBalloonChooseDataModel")
local ViewFunction = require("UIBalloonChoose/UIBalloonChooseViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.InitData = Json.decode(initParams)
    local basicCfg = PlayerData:GetFactoryData(99900043, "ConfigFactory")
    DataModel.BalloonCfg = basicCfg.balloonItemList
    for i, v in ipairs(DataModel.BalloonCfg) do
      local Btn_Bg = View.Group_Balloon["Group_Choose" .. i].Btn_Bg
      local cfg = DataModel.BalloonCfg[i]
      local id = cfg.id
      local item = PlayerData:GetFactoryData(id, "ItemFactory")
      Btn_Bg.Txt_Name:SetText(item.name)
      Btn_Bg.Txt_Des:SetText(item.des)
      Btn_Bg.Group_Num.Img_Item:SetSprite(item.iconPath)
      local serverNum = PlayerData:GetItemById(id).num
      Btn_Bg.Group_Num.Txt_Num:SetText(serverNum or 0)
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
