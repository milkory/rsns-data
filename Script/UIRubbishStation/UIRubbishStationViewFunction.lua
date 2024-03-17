local View = require("UIRubbishStation/UIRubbishStationView")
local DataModel = require("UIRubbishStation/UIRubbishStationDataModel")
local NPCDialog = require("Common/NPCDialog")
local CommonItem = require("Common/BtnItem")
local PlayNPCTalk = function(talk_type)
  local npcConfig = PlayerData:GetFactoryData(DataModel.NpcId, "NPCFactory")
  local textTable = npcConfig[talk_type]
  if textTable then
    NPCDialog.SetNPCText(View.Group_NPC, textTable, talk_type)
  end
end
local OpenRecyclePanel = function()
  if DataModel.isRecyclePanel then
    View.Group_Recycle.Group_1.Group_Quest.ScrollGrid_List.grid.self:SetDataCount(#DataModel.integralList)
    View.Group_Recycle.Group_1.Group_Quest.ScrollGrid_List.grid.self:RefreshAllElement()
    View.Group_Recycle.Group_1.Group_Quest.ScrollGrid_List.grid.self:MoveToTop()
  end
  Net:SendProto("home.refresh_coach", function(json)
    DataModel.UpdataRubishData(json.rubbish_area)
    PlayNPCTalk("enterRecycleText")
    if not DataModel.isRecyclePanel then
      View.self:PlayAnimOnce("Recycle")
      View.Group_Zhu:SetActive(true)
      View.Group_Recycle:SetActive(true)
      View.Group_Main.self:SetActive(false)
      View.Group_Recycle.Group_1.Group_Quest.ScrollGrid_List.grid.self:SetDataCount(#DataModel.integralList)
      View.Group_Recycle.Group_1.Group_Quest.ScrollGrid_List.grid.self:RefreshAllElement()
      View.Group_Recycle.Group_1.Group_Quest.ScrollGrid_List.grid.self:MoveToTop()
    end
    DataModel:RefreshLeftData()
    if DataModel.rubbish_cnt > 0 then
      View.Group_Recycle.Group_1.Group_Sale.Group_Recycle.Group_Can:SetActive(true)
      View.Group_Recycle.Group_1.Group_Sale.Group_Recycle.Group_Not:SetActive(false)
      View.Group_Recycle.Group_1.Group_Sale.Group_Recycle.Btn_:SetActive(true)
    else
      View.Group_Recycle.Group_1.Group_Sale.Group_Recycle.Group_Can:SetActive(false)
      View.Group_Recycle.Group_1.Group_Sale.Group_Recycle.Group_Not:SetActive(true)
      View.Group_Recycle.Group_1.Group_Sale.Group_Recycle.Btn_:SetActive(false)
    end
    View.Group_Recycle.Group_1.Group_Sale.Group_Recycle.Group_Can.Group_Gold.Txt_Num:SetText(DataModel.rubbish_price)
    View.Group_Recycle.Group_1.Group_Sale.Group_Rubbish.Txt_Num:SetText(DataModel.rubbish_cnt)
    View.Group_Recycle.Group_Ding.Group_Integral.Txt_Num:SetText(DataModel.allIntegral)
  end)
end
local RefreshPanel = function()
  if DataModel.isRecyclePanel then
    OpenRecyclePanel()
  else
    NPCDialog.SetNPC(View.Group_NPC, DataModel.NpcId)
    PlayNPCTalk("enterText")
    View.Group_Main.self:SetActive(true)
    View.Group_NPC.self:SetActive(true)
    View.Group_Recycle.self:SetActive(false)
    View.Group_Zhu:SetActive(false)
    View.Img_BG:SetSprite(DataModel.BgPath)
    View.Img_BG:SetColor("#" .. DataModel.BgColor)
    View.Group_Recycle.Group_Ding.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
    View.Group_Main.Btn_Recycle.Img_RedPoint:SetActive(DataModel.canReceiveCnt > 0)
  end
end
local ViewFunction = {
  RubbishStation_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_Recycle.self.IsActive then
      View.Group_Zhu:SetActive(false)
      View.Group_Recycle:SetActive(false)
      View.Group_Main.self:SetActive(true)
      PlayNPCTalk("enterText")
      View.self:PlayAnimOnce("Main")
      View.Group_Main.Btn_Recycle.Img_RedPoint:SetActive(DataModel.canReceiveCnt > 0)
      DataModel.isRecyclePanel = false
    else
      UIManager:GoBack()
    end
  end,
  RubbishStation_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  RubbishStation_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  RubbishStation_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  RubbishStation_Group_Main_Btn_Recycle_Click = function(btn, str)
    OpenRecyclePanel()
  end,
  RubbishStation_Group_Main_Btn_Talk_Click = function(btn, str)
    PlayNPCTalk("talkText")
  end,
  RubbishStation_Group_Main_Btn_Rank_Click = function(btn, str)
    local t = {}
    t.stationId = DataModel.buildingId
    UIManager:Open("UI/RankList/RankList", Json.encode(t))
  end,
  RubbishStation_Group_Zhu_Group_Construct_Btn_Construct_Click = function(btn, str)
    DataModel.isRecyclePanel = true
    DataModel:OpenConstructStage()
  end,
  RubbishStation_Group_Recycle_Group_Ding_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  RubbishStation_Group_Recycle_Group_Ding_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  RubbishStation_Group_Recycle_Group_Ding_Group_Integral_Btn_Help_Click = function(btn, str)
    View.Group_Recycle.Group_Tips:SetActive(true)
  end,
  RubbishStation_Group_Recycle_Group_1_Group_Sale_Group_Recycle_Btn__Click = function(btn, str)
    Net:SendProto("building.clean", function(json)
      PlayNPCTalk("recycleSuccessText")
      CommonTips.OpenShowItem(json.reward)
      View.Group_Recycle.Group_Ding.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
      DataModel.UpdataIntegralList(json.env_pro)
      PlayerData:GetHomeInfo().rubbish_area.waste_block = 0
      DataModel.UpdataRubishData(PlayerData:GetHomeInfo().rubbish_area)
      View.Group_Recycle.Group_1.Group_Sale.Group_Recycle.Group_Can:SetActive(false)
      View.Group_Recycle.Group_1.Group_Sale.Group_Recycle.Group_Not:SetActive(true)
      View.Group_Recycle.Group_1.Group_Sale.Group_Recycle.Btn_:SetActive(false)
      View.Group_Recycle.Group_1.Group_Sale.Group_Recycle.Group_Can.Group_Gold.Txt_Num:SetText(DataModel.rubbish_price)
      View.Group_Recycle.Group_1.Group_Sale.Group_Rubbish.Txt_Num:SetText(DataModel.rubbish_cnt)
      View.Group_Recycle.Group_Ding.Group_Integral.Txt_Num:SetText(DataModel.allIntegral)
      View.Group_Recycle.Group_1.Group_Quest.ScrollGrid_List.grid.self:SetDataCount(#DataModel.integralList)
      View.Group_Recycle.Group_1.Group_Quest.ScrollGrid_List.grid.self:RefreshAllElement()
      View.Group_Recycle.Group_1.Group_Quest.ScrollGrid_List.grid.self:MoveToTop()
    end, DataModel.buildingId)
  end,
  RubbishStation_Group_Recycle_Group_1_Group_Quest_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local data = DataModel.integralList[elementIndex]
    element.Txt_Dec:SetText(string.format(GetText(80601859), data.integral))
    element.Group_State.Group_Already:SetActive(DataModel.integralInfoData[data.index] == -1)
    element.Group_State.Group_Not:SetActive(DataModel.integralInfoData[data.index] == 0)
    element.Group_State.Group_Can:SetActive(DataModel.integralInfoData[data.index] == 1)
    if DataModel.integralInfoData[data.index] == 0 then
      element.Txt_Schedule:SetText(string.format(GetText(80601099), DataModel.allIntegral, data.integral))
      element.Group_Schedule.Img_Schedule:SetFilledImgAmount(DataModel.allIntegral / data.integral)
    else
      element.Txt_Schedule:SetText(string.format(GetText(80601099), data.integral, data.integral))
      element.Group_Schedule.Img_Schedule:SetFilledImgAmount(1)
    end
    element.Group_State.Btn_:SetClickParam(elementIndex)
    local itemConfig = PlayerData:GetFactoryData(data.id)
    element.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
    element.ScrollGrid_Reward.grid.self:SetDataCount(#itemConfig.rewardList)
    element.ScrollGrid_Reward.grid.self:RefreshAllElement()
    element.ScrollGrid_Reward.grid.self:MoveToTop()
  end,
  RubbishStation_Group_Recycle_Group_1_Group_Quest_ScrollGrid_List_Group_Item_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local index = tonumber(element.ParentParam)
    local itemConfig = PlayerData:GetFactoryData(DataModel.integralList[index].id)
    local rewardList = itemConfig.rewardList
    CommonItem:SetItem(element.Group_Item, {
      id = rewardList[elementIndex].id,
      num = rewardList[elementIndex].num
    }, EnumDefine.ItemType.Item)
    element.Group_Item.Btn_Item:SetClickParam(rewardList[elementIndex].id)
  end,
  RubbishStation_Group_Recycle_Group_1_Group_Quest_ScrollGrid_List_Group_Item_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  RubbishStation_Group_Recycle_Group_1_Group_Quest_ScrollGrid_List_Group_Item_Group_State_Btn__Click = function(btn, str)
    local data = DataModel.integralList[tonumber(str)]
    local status = DataModel.integralInfoData[data.index]
    if status == 1 then
      Net:SendProto("building.env_reward", function(json)
        CommonTips.OpenShowItem(json.reward)
        PlayNPCTalk("rewardGetText")
        table.insert(PlayerData:GetHomeInfo().env_pro.reward, data.index - 1)
        DataModel.UpdataIntegralList(PlayerData:GetHomeInfo().env_pro)
        View.Group_Recycle.Group_1.Group_Quest.ScrollGrid_List.grid.self:SetDataCount(#DataModel.integralList)
        View.Group_Recycle.Group_1.Group_Quest.ScrollGrid_List.grid.self:RefreshAllElement()
        DataModel:RefreshLeftData()
      end, data.index - 1, DataModel.buildingId)
    end
  end,
  RubbishStation_Group_Recycle_Group_Tips_Btn_Close_Click = function(btn, str)
    View.Group_Recycle.Group_Tips:SetActive(false)
  end,
  RefreshPanel = RefreshPanel,
  OpenRecyclePanel = OpenRecyclePanel
}
return ViewFunction
