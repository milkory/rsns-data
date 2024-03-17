local View = require("UIHomeRubbish/UIHomeRubbishView")
local DataModel = require("UIHomeRubbish/UIHomeRubbishDataModel")
local ViewFunction = require("UIHomeRubbish/UIHomeRubbishViewFunction")
local Timer = require("Common/Timer")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local info = Json.decode(initParams)
    DataModel.noChangeSkin = info.noChangeSkin
    DataModel.wait_cnt = -1
    DataModel.compress_mincnt = 0
    View.Group_Info:SetActive(false)
    View.Group_Info.Img_Bg:SetActive(false)
    View.Group_Info.Btn_Close:SetActive(false)
    View.Group_Info.Group_Tips:SetActive(false)
    Net:SendProto("home.refresh_coach", function(json)
      View.Group_Info:SetActive(true)
      PlayerData:GetHomeInfo().rubbish_area = json.rubbish_area
      for k, v in pairs(json.unit_waste) do
        PlayerData:GetHomeInfo().coach_store[k].collect_ts = v.collect_ts
      end
      local u_fid = info.ufid
      DataModel._init(u_fid)
      View.Group_Info.Img_Bg:SetActive(true)
      View.Group_Info.Img_Bg.Group_Title.Btn_LeveUp:SetActive(DataModel.IsCanLevelUp())
      View.Group_Info.Img_Bg.Group_Title.Txt_Level:SetText("LV " .. DataModel.fur_level)
      View.Group_Info.StaticGrid_Channel.grid.self:RefreshAllElement()
      View.Group_Info.Group_Overview.Txt_All:SetActive(true)
      View.Group_Info.Group_Overview.Txt_All:SetText(string.format(GetText(80601888), DataModel.create_rubbish))
      ViewFunction.RefreshPanleInfo(true)
      ViewFunction.CompressListToWork(DataModel.remain_ts)
      View.Group_Info.Group_RubbishStore.Group_Space.Txt_SpaceBiggest:SetText(DataModel.rubbish_bock_capaticy)
      View.timer:Start()
    end)
  end,
  awake = function()
    View.timer = Timer.New(1, function()
      DataModel.remain_ts = DataModel.remain_ts - 1
      local remain_ts = DataModel.remain_ts < 0 and 0 or DataModel.remain_ts
      View.Group_Info.Group_TimeProcess.Txt_Timenumber:SetText(os.date("%M:%S", remain_ts))
      local process = (DataModel.unit_cost_time - DataModel.remain_ts) / DataModel.unit_cost_time
      View.Group_Info.Group_TimeProcess.Img_LineBg.Img_full:SetFilledImgAmount(process)
      if DataModel.remain_ts < 0 then
        DataModel.UpdateWaitCnt(-DataModel.compress_mincnt)
        DataModel.now_bock_cnt = DataModel.now_bock_cnt + DataModel.channel_cnt
        if DataModel.now_bock_cnt > DataModel.rubbish_compress_limit then
          local num = DataModel.now_bock_cnt - DataModel.rubbish_compress_limit
          DataModel.UpdateWaitCnt(DataModel.unit_cost_cnt * num)
          DataModel.now_bock_cnt = DataModel.rubbish_compress_limit
        end
        PlayerData:GetHomeInfo().rubbish_area.waste_block = DataModel.now_bock_cnt
        ViewFunction.RefreshPanleInfo(true)
        ViewFunction.CompressListToWork(DataModel.unit_cost_time)
      end
    end)
  end,
  start = function()
  end,
  update = function()
    if DataModel.wait_cnt >= DataModel.compress_mincnt and DataModel.rubbish_compress_limit > DataModel.now_bock_cnt then
      View.timer:Update()
    end
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
