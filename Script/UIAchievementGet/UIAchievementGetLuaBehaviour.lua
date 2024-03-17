local View = require("UIAchievementGet/UIAchievementGetView")
local DataModel = require("UIAchievementGet/UIAchievementGetDataModel")
local ViewFunction = require("UIAchievementGet/UIAchievementGetViewFunction")

local function PlayAnimOnce()
  View.self:PlayAnimOnce("In", function()
    DataModel.data.nowIndex = DataModel.data.nowIndex + 1
    if DataModel.data.nowIndex <= DataModel.data.count then
      local cfg = PlayerData:GetFactoryData(DataModel.data["index" .. DataModel.data.nowIndex])
      if cfg then
        View.Txt_Name:SetText(cfg.name)
        View.Txt_Dec:SetText(cfg.story)
        local achiCfg = PlayerData:GetFactoryData(99900041).achieveList[cfg.achieveList - 1]
        View.Txt_Com:SetText(string.format(GetText(80601039), achiCfg.name))
        View.Img_Icon:SetSprite(achiCfg.pngGet)
      end
      PlayAnimOnce()
    else
      UIManager:CloseSpecialUI("UI/Achievement/AchievementGet")
    end
  end)
end

local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.data = data
    local cfg = PlayerData:GetFactoryData(data["index" .. data.nowIndex])
    View.Txt_Name:SetText(cfg.name)
    View.Txt_Dec:SetText(cfg.story)
    local achiCfg = PlayerData:GetFactoryData(99900041).achieveList[cfg.achieveList - 1]
    View.Txt_Com:SetText(string.format(GetText(80601039), achiCfg.name))
    View.Img_Icon:SetSprite(achiCfg.pngGet)
    PlayAnimOnce()
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
    View.self.transform:GetComponent(typeof(CS.Seven.UIGroup)):SetPositionY(-1000)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
