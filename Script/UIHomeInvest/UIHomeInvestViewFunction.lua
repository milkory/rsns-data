local View = require("UIHomeInvest/UIHomeInvestView")
local DataModel = require("UIHomeInvest/UIHomeInvestDataModel")
local Controller = require("UIHomeInvest/UIHomeInvestController")
local ViewFunction = {
  HomeInvest_Group_Main_Btn_Invest_Click = function(btn, str)
    Controller:ShowInvest()
  end,
  HomeInvest_Group_Main_Btn_Talk_Click = function(btn, str)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end,
  HomeInvest_Group_Invest_ScrollGrid_Level_SetGrid = function(element, elementIndex)
    local info = DataModel.InvestList[elementIndex]
    element.Img_BG.Txt_Name:SetText(info.name)
    element.Img_BG.Group_Reward.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
    element.Img_BG.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(#info.rewardList)
    element.Img_BG.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
    element.Img_BG.Group_Reward.ScrollGrid_Reward.grid.self:MoveToTop()
    element.Img_BG.Group_TZ.Btn_TZ.self:SetActive(info.remainNum > 0)
    element.Img_BG.Group_TZ.Btn_NotTZ.self:SetActive(info.remainNum <= 0)
    element.Img_BG.Group_TZ.Btn_TZ.self:SetClickParam(elementIndex)
    element.Img_BG.Img_Tuijian.Txt_1:SetText(string.format(GetText(80600686), info.remainNum))
    local costInfo = info.costList[1]
    local itemCA = PlayerData:GetFactoryData(costInfo.id, "ItemFactory")
    element.Img_BG.Group_Cost.Img_Cost:SetSprite(itemCA.buyPath or itemCA.iconPath)
    element.Img_BG.Group_Cost.Txt_Cost:SetText(costInfo.num)
    local isShow = DataModel.CurRepLv < info.repGrade
    element.Img_BG.Img_WeiDaDao.self:SetActive(isShow)
    if isShow then
      element.Img_BG.Img_WeiDaDao.Txt_JieSuo:SetText(string.format(GetText(80600687), info.repGrade))
    end
  end,
  HomeInvest_Group_Invest_ScrollGrid_Level_Group_Item_Img_BG_Group_TZ_Btn_TZ_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:DoInvest(idx)
  end,
  HomeInvest_Group_Invest_ScrollGrid_Level_Group_Item_Img_BG_Group_TZ_Btn_NotTZ_Click = function(btn, str)
  end,
  HomeInvest_Group_Invest_Group_Zhu_Group_Reputation_Btn_Reputation_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.ClickReputationBtn(DataModel.StationId, nil, nil, function()
      homeCommon.SetReputationElement(View.Group_Invest.Group_Zhu.Group_Reputation, DataModel.StationId)
    end)
  end,
  HomeInvest_Group_Invest_Group_Zhu_Btn_Refresh_Click = function(btn, str)
    Controller:ItemUseRefresh()
  end,
  HomeInvest_Group_Invest_Group_Ding_Btn_YN_Click = function(btn, str)
  end,
  HomeInvest_Group_Invest_Group_Ding_Btn_YN_Btn_Add_Click = function(btn, str)
  end,
  HomeInvest_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_Invest.self.IsActive then
      Controller:ReturnToMain()
      return
    end
    UIManager:GoBack()
  end,
  HomeInvest_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  HomeInvest_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80303386}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  HomeInvest_Group_Invest_Group_Ding_Group_FZ_Btn_Icon_Click = function(btn, str)
    View.Group_Invest.Group_Tips.self:SetActive(true)
  end,
  HomeInvest_Group_Invest_Group_Ding_Img_BG_Btn_Xk_Click = function(btn, str)
    Controller:ShowTradePermission()
  end,
  HomeInvest_Group_Invest_Group_Tips_Btn_Close_Click = function(btn, str)
    View.Group_Invest.Group_Tips.self:SetActive(false)
  end,
  HomeInvest_Group_Invest_Group_XK_Btn_Close_Click = function(btn, str)
    View.Group_Invest.Group_XK.self:SetActive(false)
  end,
  HomeInvest_Group_Invest_Group_XK_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local info = DataModel.TradePermissionGoods[elementIndex]
    local btnItem = require("Common/BtnItem")
    btnItem:SetItem(element.Group_Item, {
      id = info.goodsId
    })
    element.Group_Item.Btn_Item:SetClickParam(info.goodsId)
    element.Img_Specialty:SetActive(info.isSpecial)
    element.Img_Get.self:SetActive(info.needItemNum <= DataModel.TotalTZ)
    element.Group_Cost.Txt_Cost:SetText(info.needItemNum)
    element.Txt_Huode:SetText(string.format(GetText(80600707), info.name))
    element.Txt_Huode.Txt_CityName:SetActive(info.stationName ~= nil)
    if info.stationName then
      element.Txt_Huode.Txt_CityName:SetText(string.format(GetText(80602196), info.stationName))
    end
  end,
  HomeInvest_Group_Invest_Group_XK_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local id = tonumber(str)
    CommonTips.OpenGoodsTips(id, 1)
  end,
  HomeInvest_Group_Invest_ScrollGrid_Level_Group_Item_Img_BG_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local info = DataModel.InvestList[tonumber(element.ParentParam)]
    local rewardInfo = info.rewardList[elementIndex]
    local BtnItem = require("Common/BtnItem")
    BtnItem:SetItem(element.Group_Item, {
      id = rewardInfo.id,
      num = rewardInfo.num
    })
    element.Group_Item.Btn_Item:SetClickParam(rewardInfo.id)
  end,
  HomeInvest_Group_Invest_ScrollGrid_Level_Group_Item_Img_BG_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreItemTips({itemId = itemId})
  end,
  HomeInvest_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeInvest_Group_Invest_Group_Ding_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  HomeInvest_Group_Invest_Group_Ding_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  HomeInvest_Group_Invest_Group_Ding_Btn_Refresh_Click = function(btn, str)
  end
}
return ViewFunction
