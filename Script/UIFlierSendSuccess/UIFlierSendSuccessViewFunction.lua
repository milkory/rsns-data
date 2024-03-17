local View = require("UIFlierSendSuccess/UIFlierSendSuccessView")
local DataModel = require("UIFlierSendSuccess/UIFlierSendSuccessDataModel")
local ViewFunction = {
  FlierSendSuccess_Btn_Shade_Click = function(btn, str)
    local MainDataModel = require("UIMainUI/UIMainUIDataModel")
    PlayerData.TempCache.MainUIShowState = MainDataModel.UIShowEnum.OutSide
    UIManager:GoHome()
    local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
    local TimeLine = require("Common/TimeLine")
    local stationCA = PlayerData:GetFactoryData(TradeDataModel.CurStayCity)
    for k, v in pairs(stationCA.timeLineList) do
      TimeLine.LoadTimeLine(v.id, nil, true)
    end
    MainSceneCharacterManager:RecycleAll()
  end,
  FlierSendSuccess_Btn_OK_Click = function(btn, str)
    local MainDataModel = require("UIMainUI/UIMainUIDataModel")
    PlayerData.TempCache.MainUIShowState = MainDataModel.UIShowEnum.OutSide
    UIManager:GoHome()
    local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
    local TimeLine = require("Common/TimeLine")
    local stationCA = PlayerData:GetFactoryData(TradeDataModel.CurStayCity)
    for k, v in pairs(stationCA.timeLineList) do
      TimeLine.LoadTimeLine(v.id, nil, true)
    end
    MainSceneCharacterManager:RecycleAll()
  end,
  FlierSendSuccess_GroupResult_Group_R_ScrollGrid_list_SetGrid = function(element, elementIndex)
    local careerPsgList = DataModel.addPsgList[elementIndex]
    local info = careerPsgList[1]
    element.Group_sort.Group_sequence:SetActive(elementIndex <= 3)
    element.Group_sort.Group_sequence.Img_first:SetActive(elementIndex == 1)
    element.Group_sort.Group_sequence.Img_second:SetActive(elementIndex == 2)
    element.Group_sort.Group_sequence.Img_third:SetActive(elementIndex == 3)
    local psgCA = PlayerData:GetFactoryData(info.id, "PassageFactory")
    local career = PlayerData:GetFactoryData(psgCA.career).leafletPlace
    element.Group_sort.Txt_1:SetText(career)
    element.Group_sort.Txt_2:SetText(table.count(careerPsgList))
    local payRatio = DataModel.psgPayList[psgCA.career] / DataModel.totalPay
    local format = payRatio == 0 and "%d%%" or "%0.2f%%"
    element.Group_sort.Group_3.Txt_:SetText(string.format(format, payRatio * 100))
  end,
  FlierSendSuccess_GroupResult_Btn_passenger_Click = function(btn, str)
    local mainDataModel = require("UIMainUI/UIMainUIDataModel")
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
      CommonTips.OpenLoadingCB(function()
        SafeReleaseScene(false)
        CBus:ChangeScene("Home", nil, function()
          local mainUIView = require("UIMainUI/UIMainUIView")
          mainUIView.self:StartC(LuaUtil.cs_generator(function()
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
            for i, v in pairs(PlayerData:GetHomeInfo().passenger) do
              for psgUid, psgData in pairs(v) do
                local furniture = PlayerData:GetHomeInfo().furniture[psgData.u_fid]
                for roomIdx, u_cid in pairs(PlayerData.ServerData.user_home_info.coach_template) do
                  if furniture.u_cid == u_cid then
                    HomeManager:OpenHome(roomIdx - 1)
                    return
                  end
                end
              end
            end
          end))
        end)
      end)
    end))
    mainDataModel.IsGoHomeCoach = true
  end
}
return ViewFunction
