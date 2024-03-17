local DataModel = require("UIBalloonTips/UIBalloonTipsDataModel")
local Controller = require("UIBalloonTips/UIBalloonTipsController")
local ViewFunction = {
  BalloonTips_Btn_BG_Click = function(btn, str)
  end,
  BalloonTips_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  BalloonTips_Btn_Min_Click = function(btn, str)
    DataModel:SetCurrNum(1)
    Controller:RefreshShow(true)
  end,
  BalloonTips_Btn_Dec_Click = function(btn, str)
    DataModel:SetCurrNum(math.max(1, DataModel.CurrNum - 1))
    Controller:RefreshShow(true)
  end,
  BalloonTips_Group_Slider_Slider_Value_Slider = function(slider, value)
    DataModel:SetCurrNum(value)
    Controller:RefreshShow(false)
    DataModel:SetSliderRefreshState(false)
  end,
  BalloonTips_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  BalloonTips_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  BalloonTips_Btn_Add_Click = function(btn, str)
    DataModel:SetCurrNum(math.min(DataModel.CurrNum + 1, DataModel.MaxNum))
    Controller:RefreshShow(true)
  end,
  BalloonTips_Btn_Max_Click = function(btn, str)
    DataModel:SetCurrNum(DataModel.MaxNum)
    Controller:RefreshShow(true)
  end,
  BalloonTips_Btn_Cancel_Click = function(btn, str)
    UIManager:CloseTip("UI/MainUI/BalloonTips")
  end,
  BalloonTips_Btn_Sale_Click = function(btn, str)
    Net:SendProto("events.bait_through", function(json)
      local useItem = {}
      useItem[DataModel.BalloonItemId] = math.floor(DataModel.CurrNum)
      PlayerData:RefreshUseItems(useItem)
      if json.info == 1 then
        PlayerData.TempCache.EventFinish = true
        local mainController = require("UIMainUI/UIMainUIController")
        local mainDataModel = require("UIMainUI/UIMainUIDataModel")
        local mainView = require("UIMainUI/UIMainUIView")
        local tradeDataModel = require("UIHome/UIHomeTradeDataModel")
        TrainManager:ChangeState(TrainState.EventFinish, function()
          mainController.ShowWarning(false)
          mainController:InitCommonShow()
          mainDataModel.SetTrainEventBasicId()
          mainDataModel.SetTrainEventBgmId()
          mainController.PlayTrainBgm()
          TrainManager:LevelEventFinish()
          mainView.self:PlayAnimOnce("BattleEnd", function()
            UIManager:Open("UI/MainUI/Balloon_Success")
            mainDataModel.SetCamera(1)
            mainController:RunBtnState(true)
            mainController.MainLineEventShow(DataModel.TrainEventId, false)
            mainController.BackShow(true)
            tradeDataModel.StateEnter = EnumDefine.TrainStateEnter.Refresh
          end)
        end)
      else
        CommonTips.OpenTips(80601886)
      end
      if json.reward then
        PlayerData.TempCache.balloonReward = json.reward
      end
      UIManager:CloseTip("UI/MainUI/BalloonChoose")
      UIManager:CloseTip("UI/MainUI/BalloonTips")
    end, DataModel.TrainEventId, math.floor(DataModel.CurrNum), DataModel.BalloonItemId)
  end
}
return ViewFunction
