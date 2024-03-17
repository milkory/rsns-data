local View = require("UITrailerPrompt/UITrailerPromptView")
local DataModel = require("UITrailerPrompt/UITrailerPromptDataModel")
local ViewFunction = require("UITrailerPrompt/UITrailerPromptViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local distance = tonumber(initParams)
    local max = PlayerData.GetMaxTrailerNum()
    local currRemainNum = PlayerData:GetHomeInfo().req_back_num
    View.Group_Times.Txt_Times:SetText(currRemainNum)
    local trailerCost = PlayerData:GetFactoryData(99900060, "ConfigFactory").trailerCost
    local currIndex = max - currRemainNum + 1
    if currIndex < 1 or currIndex > #trailerCost then
      currIndex = 1
    end
    local unit = trailerCost[currIndex]
    local cost = math.floor(distance / unit.dis * unit.price + 0.5)
    View.Group_Price.Txt_Price:SetText(unit.price)
    View.Group_Free.self:SetActive(cost == 0)
    View.Group_Cost.Txt_Cost:SetText(cost)
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
