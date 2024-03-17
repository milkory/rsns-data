local View = require("UIESC/UIESCView")
local DataModel = require("UIESC/UIESCDataModel")
local Controller = require("UIESC/UIESCController")
local ViewFunction = require("UIESC/UIESCViewFunction")
local params
local Luabehaviour = {
  serialize = function()
    if params then
      return params
    end
  end,
  deserialize = function(initParams)
    params = initParams
    if initParams ~= nil then
      local data = Json.decode(initParams)
      if data.showAdjutantBg then
        View.Img_AdjutantBG:SetActive(data.showAdjutantBg)
        local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
        local scaleOneDaySecond = 86400 / homeConfig.dayScale
        local scaleTimeToday = (TimeUtil:GetServerTimeStamp() + PlayerData.TimeZone * 3600) % scaleOneDaySecond
        local mainUIConfig = PlayerData:GetFactoryData(99900034, "ConfigFactory")
        local todayZeroTimeStamp = scaleTimeToday / scaleOneDaySecond * 86400
        local idx = 0
        for k, v in pairs(mainUIConfig.bgList) do
          local h = tonumber(string.sub(v.changeTime, 1, 2))
          local m = tonumber(string.sub(v.changeTime, 4, 5))
          local s = tonumber(string.sub(v.changeTime, 7, 8))
          local checkTimeStamp = h * 3600 + m * 60 + s
          if todayZeroTimeStamp < checkTimeStamp then
            idx = k
            break
          end
        end
        idx = idx - 1
        if idx <= 0 then
          idx = #mainUIConfig.bgList
        end
        View.Img_AdjutantBG:SetSprite(mainUIConfig.bgList[idx].bgPath)
      else
        View.Img_AdjutantBG:SetActive(false)
      end
    else
      View.Img_AdjutantBG:SetActive(false)
    end
    DataModel.headInfo = {}
    DataModel.showStationLst = {}
    DataModel.headSelectId = 0
    DataModel.usedHeadId = 0
    Controller:Init()
    DataModel.FirstFrame = true
    View.self:PlayAnim("ESCIn")
    DataModel.InitLvRewardInfo()
    View.Group_Info.Group_License.Img_Icon:SetSprite(DataModel.lv_icon)
    View.Group_Info.Group_License.Txt_Name:SetText(DataModel.lv_name)
    View.Group_Info.Group_License.Btn_Lv.Img_RemindOut:SetActive(0 < DataModel.can_recv_cnt)
    local data = PlayerData:GetFactoryData(DataModel.lv_cfg[DataModel.max_lvidx].id)
    View.Group_Info.Group_License.Txt_Title:SetText(data.Rankname)
    Controller.RefreshSkin()
    Controller.RefreshLvInfo()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.FirstFrame then
      DataModel.FirstFrame = false
      if MainManager.bgSceneName == "Main" then
        local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
        if not TradeDataModel.GetInTravel() then
          TrainCameraManager:OpenCamera(1)
        else
          TrainCameraManager:OpenCamera(0)
        end
      else
        TrainCameraManager:OpenCamera(2)
      end
    end
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    if UIManager:GetPanel("UI/MainUI/MainUI") and UIManager:GetPanel("UI/MainUI/MainUI").IsActive then
      return
    end
    if UIManager:GetPanel("UI/HomeFurniture/HomeFood") and UIManager:GetPanel("UI/HomeFurniture/HomeFood").IsActive then
      return
    end
    TrainCameraManager:OpenCamera(-1)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
