local View = require("UIActivityMain/UIActivityMainView")
local DataModel = require("UIActivityMain/UIActivityMainDataModel")
local Controller = require("UIActivityMain/UIActivityMainController")
local ViewFunction = {
  ActivityMain_Group_List_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  ActivityMain_Group_List_ScrollGrid_List_Group_Tab_Btn_Tab_Click = function(btn, str)
    Controller:ClickLeftActive(tonumber(str))
  end,
  ActivityMain_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  ActivityMain_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  ActivityMain_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ActivityMain_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ActivityMain_Group_SignIn_Group_EventSignIn_ScrollGrid_Board_SetGrid = function(element, elementIndex)
    Controller:SignInSetElement(element, elementIndex)
  end,
  ActivityMain_Group_SignIn_Group_EventSignIn_ScrollGrid_Board_Group_Item_Group_Item_BtnPolygon_BG_Click = function(btn, str)
    Controller:SignInClickElement(tonumber(str))
  end,
  ActivityMain_Group_SignIn_Group_EventSignIn_Group_Decorate_Btn_Details_Click = function(btn, str)
  end,
  ActivityMain_Group_BlackTea_Group_NotJoin_Group_Add_Btn__Click = function(btn, str)
    if DataModel.BlackTeaType == DataModel.BlackTeaTypeList.NotEnabled then
      Net:SendProto("main.participate", function(Jsons)
        if Jsons.activity then
          PlayerData.ServerData.all_activities.ing[tostring(DataModel.LeftActivityCA.id)] = Jsons.activity
        end
        print_r("PlayerData.ServerData.all_activities", PlayerData.ServerData.all_activities)
        if DataModel.ActivityCA.joinPlotId and DataModel.ActivityCA.joinPlotId ~= "" then
          UIManager:Open("UI/Dialog/Dialog", Json.encode({
            id = DataModel.ActivityCA.joinPlotId
          }))
        end
        Controller:RefreshBlackTeaJoinPage()
        Controller:RefreshLeftRedState()
      end, DataModel.LeftActivityCA.id)
      return
    end
    if DataModel.BlackTeaType == DataModel.BlackTeaTypeList.Lock then
      CommonTips.OpenTips(80602587)
    end
  end,
  ActivityMain_Group_BlackTea_Group_NotJoin_Group_Preview_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:NotJoinRewardSetElemnt(element, tonumber(elementIndex))
  end,
  ActivityMain_Group_BlackTea_Group_NotJoin_Group_Preview_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:NotJoinRewardClickElemnt(str)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Quest_Btn__Click = function(btn, str)
    UIManager:Open("UI/Activity/BlackTea/ActivityAchievement")
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_StageAll_Btn__Click = function(btn, str)
    Net:SendProto("quest.list", function(Json)
      UIManager:Open("UI/Activity/BlackTea/ServerProgress")
    end, 6)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_StageOne_Btn__Click = function(btn, str)
    Net:SendProto("quest.list", function(Json)
      UIManager:Open("UI/Activity/BlackTea/PersonalProgress")
    end, 6)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Store_Btn__Click = function(btn, str)
    local parms = {}
    parms.activityId = DataModel.LeftActivityCA.id
    parms.shopId = DataModel.ActivityCA.activityStoreList[1].id
    parms.ca = PlayerData:GetFactoryData(parms.shopId)
    Net:SendProto("shop.info", function(json)
      UIManager:Open("UI/Activity/BlackTea/ActiveStore", Json.encode(parms))
    end)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Coin_Btn_GoldCoin_Click = function(btn, str)
    CommonTips.OpenRewardDetail(DataModel.CoinId)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Plot_Group_Plot1_Btn__Click = function(btn, str)
    Controller:OnClickPlot1()
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Plot_Group_Plot2_Btn__Click = function(btn, str)
    Controller:OnClickPlot2()
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Card_Btn__Click = function(btn, str)
    local cardPackId = DataModel.ActivityCA.activityCardPack
    local activityName = DataModel.ActivityCA.name
    local callBack = function()
      Controller:RefreshCard()
    end
    UIManager:Open("UI/CollectionCard/CardPack_Open", Json.encode({cardPackId = cardPackId, activityName = activityName}), callBack)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Btn_Help_Click = function(btn, str)
    CommonTips.OpenHelp(DataModel.ActivityCA.helpId)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Buff_Btn__Click = function(btn, str)
    UIManager:Open("UI/Activity/BlackTea/BuffTips")
  end
}
return ViewFunction
