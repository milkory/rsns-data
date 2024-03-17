local View = require("UIHomeFood/UIHomeFoodView")
local DataModel = require("UIHomeFood/UIHomeFoodDataModel")
local Controller = require("UIHomeFood/UIHomeFoodController")
local ViewFunction = require("UIHomeFood/UIHomeFoodViewFunction")
local HomeCommon = require("Common/HomeCommon")
local Timer = require("Common/Timer")
local params
local Luabehaviour = {
  serialize = function()
    return params
  end,
  deserialize = function(initParams)
    if initParams then
      params = initParams
      DataModel.isOutside = Json.decode(initParams).isOutside
    end
  end,
  awake = function()
    View.timer = Timer.New(1, function()
      local curIdx = Controller.curDetailIdx
      if curIdx then
        Controller:UpdateGroupTime(curIdx)
      end
    end)
  end,
  start = function()
    View.timer:Start()
  end,
  update = function()
    HomeCommon.AutoSubMoveEnergy(function()
      Controller:RefreshMoveEnergy()
    end)
    if DataModel.dayRefreshTimeStamp ~= 0 and TimeUtil:GetServerTimeStamp() >= DataModel.dayRefreshTimeStamp then
      DataModel.InitDayRefreshTime()
      Controller:DayRefresh()
    end
    View.timer:Update()
  end,
  ondestroy = function()
    DataModel.dayRefreshTimeStamp = 0
  end,
  enable = function()
    View.ScrollGrid_FoodList.self:SetActive(false)
    Net:SendProto("meal.info", function(json)
      local oldMealInfo = PlayerData:GetHomeInfo().meal_info
      local newMealInfo = json.meal_info
      if oldMealInfo and newMealInfo then
        local oldBoxMeal = oldMealInfo.box_meal or {}
        local newBoxMeal = newMealInfo.box_meal or {}
        for k, v in pairs(oldBoxMeal) do
          if newBoxMeal[k] == nil then
            PlayerData:ClearLoveBentoClicked(k)
          end
        end
      end
      PlayerData:GetHomeInfo().meal_info = newMealInfo
      DataModel.reward = json.reward.material
      DataModel.InitDayRefreshTime()
      DataModel.InitData()
      Controller:Init()
    end)
  end,
  disenable = function()
    View.timer:Stop()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
