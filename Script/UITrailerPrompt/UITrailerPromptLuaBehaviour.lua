local View = require("UITrailerPrompt/UITrailerPromptView")
local DataModel = require("UITrailerPrompt/UITrailerPromptDataModel")
local ViewFunction = require("UITrailerPrompt/UITrailerPromptViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local distance = tonumber(initParams)
    local currRemainNum = PlayerData:GetHomeInfo().req_back_num
    local currMonthRemainNum = PlayerData:GetHomeInfo().monthly_req_back_num
    local currAllRemainNum = currRemainNum + currMonthRemainNum
    View.Group_Times.Txt_Times:SetText(currAllRemainNum)
    local unit
    if 0 < currMonthRemainNum then
      local max = PlayerData:GetFactoryData(99900060, "ConfigFactory").trailerMonthCardMax
      local trailerMonthCardCost = PlayerData:GetFactoryData(99900060, "ConfigFactory").trailerMonthCardCost
      local currIndex = max - currMonthRemainNum + 1
      if currIndex < 1 or currIndex > #trailerMonthCardCost then
        currIndex = 1
      end
      unit = trailerMonthCardCost[currIndex]
    elseif 0 < currRemainNum then
      local max = PlayerData.GetMaxTrailerNum()
      local trailerCost = PlayerData:GetFactoryData(99900060, "ConfigFactory").trailerCost
      local currIndex = max - currRemainNum + 1
      if currIndex < 1 or currIndex > #trailerCost then
        currIndex = 1
      end
      unit = trailerCost[currIndex]
    end
    if unit ~= nil then
      local cost = math.floor(distance / unit.dis * unit.price + 0.5)
      View.Group_Price.Txt_Price:SetText(unit.price)
      View.Group_Free.self:SetActive(cost == 0)
      View.Group_Cost.Txt_Cost:SetText(cost)
    else
      CommonTips.OpenTips(80602289)
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
