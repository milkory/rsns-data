local View = require("UIPassengerReward/UIPassengerRewardView")
local DataModel = require("UIPassengerReward/UIPassengerRewardDataModel")
local ViewFunction = {
  PassengerReward_Btn_Shade_Click = function(btn, str)
    View.self:CloseUI()
    local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
    local TimeLine = require("Common/TimeLine")
    local stationCA = PlayerData:GetFactoryData(TradeDataModel.CurStayCity)
    for k, v in pairs(stationCA.timeLineList) do
      TimeLine.LoadTimeLine(v.id, nil, true)
    end
    MainSceneCharacterManager:RecycleAll()
    View.self:Confirm()
  end,
  PassengerReward_Group_R_Btn__Click = function(btn, str)
    DataModel.RefreshDetail(true)
  end,
  PassengerReward_Group_details_Group_details_Group_list_ScrollGrid__SetGrid = function(element, elementIndex)
    local info = DataModel.psgDetailSortList[elementIndex]
    if info then
      local psgCA = PlayerData:GetFactoryData(info[1].psgData.id, "PassageFactory")
      local psgTagCA = PlayerData:GetFactoryData(info[1].psgData.psg_tag, "ListFactory")
      local stationCA = PlayerData:GetFactoryData(info[1].psgData.origin, "HomeStationFactory")
      element.Txt_1:SetText(psgCA.type)
      element.Txt_2:SetText(psgTagCA.name)
      element.Txt_3:SetText(stationCA.name)
      local txt = ""
      local city_pid = info[1].psgData.city_pid
      if city_pid == "quests" then
        txt = "客运任务"
      elseif city_pid == "magazine" then
        txt = "杂志类型"
      elseif city_pid == "tv" then
        txt = "频道类型"
      else
        txt = PlayerData:GetFactoryData(info[1].psgData.city_pid, "ListFactory").namePlace
      end
      element.Txt_4:SetText(txt)
      element.Txt_5:SetText(table.count(info))
      local ticket = 0
      for i, v in ipairs(info) do
        ticket = ticket + v.ticket
      end
      local consume = 0
      for i, v in ipairs(info) do
        consume = consume + v.consume
      end
      element.Txt_6:SetText(ticket)
      element.Txt_7:SetText(consume)
    end
  end,
  PassengerReward_Group_details_Group_tad_Group_age_Btn_Age_Click = function(btn, str)
    DataModel.SetDetailByType(1)
  end,
  PassengerReward_Group_details_Group_tad_Group_gender_Btn_Gender_Click = function(btn, str)
    DataModel.SetDetailByType(2)
  end,
  PassengerReward_Group_details_Group_tad_Group_details_Btn_Details_Click = function(btn, str)
    DataModel.SetDetailByType(3)
  end,
  PassengerReward_Group_details_Btn_CloseDetails_Click = function(btn, str)
    DataModel.RefreshDetail(false)
  end
}
return ViewFunction
