local View = require("UIHomeRubbish/UIHomeRubbishView")
local DataModel = require("UIHomeRubbish/UIHomeRubbishDataModel")
local RefreshPanleInfo = function(refresh_rubbish_bock)
  View.Group_Info.Img_Harashi:SetActive(false)
  if DataModel.now_bock_cnt > DataModel.rubbish_bock_capaticy then
    View.Group_Info.Img_Harashi:SetActive(true)
    View.Group_Info.Img_Harashi.Txt_Harashi:SetText(GetText(80601147))
  end
  View.Group_Info.Group_Overview.StaticGrid_Item.grid.self:RefreshAllElement()
  View.Group_Info.Group_RubbishNum.Txt_Num:SetText(DataModel.wait_cnt)
  local content = DataModel.now_bock_cnt > DataModel.rubbish_bock_capaticy and string.format("<color=red>%s</color>", DataModel.now_bock_cnt) or DataModel.now_bock_cnt
  View.Group_Info.Group_RubbishStore.Group_Space.Txt_Space:SetText(content)
  if refresh_rubbish_bock then
    View.Group_Info.Group_RubbishStore.ScrollGrid_Box.grid.self:SetDataCount(math.max(DataModel.rubbish_bock_capaticy, DataModel.now_bock_cnt))
    View.Group_Info.Group_RubbishStore.ScrollGrid_Box.grid.self:RefreshAllElement()
  end
  View.Group_Info.Group_RubbishStore.Btn_Deal:SetActive(DataModel.now_bock_cnt > 0)
end
local CompressListToWork = function(remain_ts)
  View.Group_Info.StaticGrid_Channel.grid.self:RefreshAllElement()
  if DataModel.wait_cnt >= DataModel.compress_mincnt then
    View.Group_Info.Group_TimeProcess.Txt_Timenumber:SetActive(true)
    View.Group_Info.Group_TimeProcess.Txt_Stop:SetActive(false)
    View.Group_Info.Group_TimeProcess.Txt_Stop2:SetActive(false)
    DataModel.remain_ts = remain_ts
    View.Group_Info.Group_TimeProcess.Txt_Timenumber:SetText(os.date("%M:%S", DataModel.remain_ts))
    local process = (DataModel.unit_cost_time - DataModel.remain_ts) / DataModel.unit_cost_time
    View.Group_Info.Group_TimeProcess.Img_LineBg.Img_full:SetFilledImgAmount(process)
  else
    View.Group_Info.Group_TimeProcess.Img_LineBg.Img_full:SetFilledImgAmount(0)
    View.Group_Info.Group_TimeProcess.Txt_Timenumber:SetActive(false)
    View.Group_Info.Group_TimeProcess.Txt_Stop2:SetActive(false)
    View.Group_Info.Group_TimeProcess.Txt_Stop:SetActive(true)
  end
  if DataModel.now_bock_cnt >= DataModel.rubbish_compress_limit then
    View.Group_Info.Group_TimeProcess.Txt_Timenumber:SetActive(false)
    View.Group_Info.Group_TimeProcess.Txt_Stop:SetActive(false)
    View.Group_Info.Group_TimeProcess.Txt_Stop2:SetActive(true)
  end
end
local ViewFunction = {
  HomeRubbish_Group_Info_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
    if not DataModel.noChangeSkin then
      local ca = PlayerData:GetFactoryData(DataModel.skin_id)
      HomeManager:GetFurnitureByUfid(DataModel.u_fid).viewPart:ChangeSkin(ca)
    end
  end,
  HomeRubbish_Group_Info_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
    if not DataModel.noChangeSkin then
      local ca = PlayerData:GetFactoryData(DataModel.skin_id)
      HomeManager:GetFurnitureByUfid(DataModel.u_fid).viewPart:ChangeSkin(ca)
    end
  end,
  HomeRubbish_Group_Info_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeRubbish_Group_Info_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80301422}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  HomeRubbish_Group_Info_Group_Overview_Group_Item_Btn_Blow_Click = function(btn, str)
  end,
  HomeRubbish_Group_Info_Group_Overview_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local data = DataModel.coach_list[elementIndex]
    element.Btn_Blow.Img_Blow:SetActive(false)
    element.Btn_Blow.Img_Full:SetActive(false)
    element.Txt_Number:SetText(string.format("%02d", elementIndex))
    element.Txt_Quantity:SetActive(false)
    element.Img_Store:SetActive(false)
    element.Txt_Empty:SetActive(false)
    element.Btn_Blow:SetActive(false)
    if data then
      if data.goods_coach then
        element.Img_Store:SetActive(true)
      else
        element.Txt_Quantity:SetActive(true)
        local unit_cnt = DataModel.unit_waste[DataModel.coach_list[elementIndex].coach_id]
        element.Txt_Quantity:SetText(string.format("%d/h", unit_cnt))
        if DataModel.channel_cnt < 3 then
          element.Btn_Blow:SetActive(true)
          local days = DataModel.CalDaysBetweenTimestamps(data.recv_time, DataModel.serverTime)
          if 2 <= days then
            local reall_days = math.floor(math.abs(DataModel.serverTime - data.recv_time) / 86400)
            days = reall_days
          end
          if days == 1 then
            element.Btn_Blow.Img_Blow:SetActive(true)
            element.Btn_Blow:SetClickParam(elementIndex)
          elseif 2 <= days then
            element.Btn_Blow.Img_Full:SetActive(true)
            View.Group_Info.Img_Harashi:SetActive(true)
            View.Group_Info.Img_Harashi.Txt_Harashi:SetText(GetText(80601146))
            element.Btn_Blow:SetClickParam(elementIndex)
          else
            element.Btn_Blow:SetActive(false)
          end
        end
      end
    else
      element.Txt_Empty:SetActive(true)
    end
  end,
  HomeRubbish_Group_Info_Group_Overview_StaticGrid_Item_Group_Item_Btn_Blow_Click = function(btn, str)
    local coachId = tonumber(str)
    Net:SendProto("home.rec_coach_waste", function(json)
      local add_rubbish = json.rubbish_area.waste_num - DataModel.wait_cnt
      DataModel.UpdateRecvTime(coachId, TimeUtil:GetServerTimeStamp())
      local pre_cnt = DataModel.wait_cnt
      DataModel.UpdateWaitCnt(add_rubbish)
      if DataModel.wait_cnt - add_rubbish < DataModel.compress_mincnt and DataModel.wait_cnt >= DataModel.compress_mincnt and DataModel.rubbish_compress_limit > DataModel.now_bock_cnt then
        CompressListToWork(DataModel.unit_cost_time)
        View.Group_Info.StaticGrid_Channel.grid.self:RefreshAllElement()
      end
      local duration = 0.5
      local add_num = DataModel.wait_cnt - pre_cnt
      DOTweenTools.DoTextProgress(View.Group_Info.Group_RubbishNum.Txt_Num, pre_cnt, DataModel.wait_cnt, duration, nil, function(remain_time)
        local value = MathEx.Clamp((duration - remain_time) / duration, 0, 1)
        View.Group_Info.Group_RubbishNum.Txt_Num:SetText(math.floor(add_num * value + pre_cnt))
      end)
      RefreshPanleInfo(false)
    end, DataModel.coach_list[coachId].coach_id)
  end,
  HomeRubbish_Group_Info_StaticGrid_Channel_SetGrid = function(element, elementIndex)
    element.Txt_Text:SetText(string.format(GetText(80601158), elementIndex))
    element:SetEnableAnimator(false)
    element.Img_Arrows.Img_Arrow1:SetActive(false)
    element.Img_Arrows.Img_Arrow2:SetActive(false)
    element.Img_Arrows.Img_Arrow3:SetActive(false)
    element.Img_Arrows.Img_Arrow4:SetActive(false)
    element.Img_Arrows.Img_Arrow5:SetActive(false)
    element.Img_Arrows.Img_Arrow6:SetActive(false)
    element.Img_Arrows.Img_Arrow7:SetActive(false)
    if elementIndex <= DataModel.channel_cnt then
      element.Img_Black:SetActive(false)
      if DataModel.now_bock_cnt < DataModel.rubbish_compress_limit then
        element:SetEnableAnimator(DataModel.wait_cnt >= DataModel.compress_mincnt)
      end
    else
      element.Img_Black:SetActive(true)
      local needLevel = 1
      local homeCfg = PlayerData:GetFactoryData(99900014)
      if elementIndex == 2 then
        needLevel = homeCfg.secondOpenLevel
      elseif elementIndex == 3 then
        needLevel = homeCfg.thirdOpenLevel
      end
      element.Img_Black.Txt_UnlockLevel:SetText(string.format(GetText(80601148), needLevel))
    end
  end,
  HomeRubbish_Group_Info_Group_RubbishStore_ScrollGrid_Box_SetGrid = function(element, elementIndex)
    element.Img_Cell.Img_Boxicon:SetActive(elementIndex <= DataModel.now_bock_cnt)
  end,
  HomeRubbish_Group_Info_Group_RubbishStore_Btn_Deal_Click = function(btn, str)
    Net:SendProto("home.refresh_coach", function(json)
      PlayerData:GetHomeInfo().rubbish_area = json.rubbish_area
      if json.rubbish_area.waste_block <= 0 then
        CommonTips.OpenTips(80601175)
        return
      end
      local home_cfg = PlayerData:GetFactoryData(82900012)
      local unit_cnt = home_cfg.costList[1].num
      local cost_num = unit_cnt * json.rubbish_area.waste_block
      CommonTips.OnPrompt(string.format(GetText(80601150), cost_num), nil, nil, function()
        if cost_num > PlayerData:GetUserInfo().gold then
          CommonTips.OpenTips(80601025)
          return
        end
        Net:SendProto("building.clean", function()
          PlayerData:GetHomeInfo().rubbish_area.waste_block = 0
          CommonTips.OpenTips(80601247)
          DataModel.now_bock_cnt = 0
          RefreshPanleInfo(true)
          CompressListToWork(DataModel.unit_cost_time)
        end)
      end)
    end)
  end,
  HomeRubbish_Group_Info_Btn_Close_Click = function(btn, str)
    View.Group_Info.Btn_Close:SetActive(false)
    View.Group_Info.Group_Tips:SetActive(false)
  end,
  RefreshPanleInfo = RefreshPanleInfo,
  CompressListToWork = CompressListToWork,
  HomeRubbish_Group_Info_Group_Channel1_Img_Black_Btn_Levelup_Click = function(btn, str)
  end,
  HomeRubbish_Group_Info_Img_Bg_Group_Title_Btn_Tips_Click = function(btn, str)
  end,
  HomeRubbish_Group_Info_Img_Bg_Group_Title_Btn_LeveUp_Click = function(btn, str)
    local t = {}
    t.furUfid = DataModel.u_fid
    t.furId = PlayerData:GetHomeInfo().furniture[DataModel.u_fid].id
    UIManager:Open("UI/HomeUpgrade/HomeUpgrade", Json.encode(t), function()
      Net:SendProto("home.refresh_coach", function(json)
        View.Group_Info:SetActive(true)
        PlayerData:GetHomeInfo().rubbish_area = json.rubbish_area
        for k, v in pairs(json.unit_waste) do
          PlayerData:GetHomeInfo().coach_store[k].collect_ts = v.collect_ts
        end
        DataModel._init(DataModel.u_fid)
        View.Group_Info.Img_Bg.Group_Title.Btn_LeveUp:SetActive(DataModel.IsCanLevelUp())
        View.Group_Info.Img_Bg.Group_Title.Txt_Level:SetText("LV " .. DataModel.fur_level)
        View.Group_Info.StaticGrid_Channel.grid.self:RefreshAllElement()
        View.Group_Info.Group_Overview.Txt_All:SetActive(true)
        View.Group_Info.Group_Overview.Txt_All:SetText(string.format(GetText(80601888), DataModel.create_rubbish))
        RefreshPanleInfo(true)
        CompressListToWork(DataModel.remain_ts)
        View.Group_Info.Group_RubbishStore.Group_Space.Txt_SpaceBiggest:SetText(DataModel.rubbish_bock_capaticy)
      end)
    end)
  end
}
return ViewFunction
