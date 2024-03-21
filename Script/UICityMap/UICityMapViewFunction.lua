local View = require("UICityMap/UICityMapView")
local DataModel = require("UICityMap/UICityMapDataModel")
local Controller = require("UICityMap/UICityMapController")
local ViewFunction = {
  CityMap_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    Controller:ClickReturn()
  end,
  CityMap_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  CityMap_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  CityMap_Group_TopRight_Btn_Activity_Click = function(btn, str)
    UIManager:Open("UI/SignIn/SignIn")
  end,
  CityMap_Group_Reputation_Btn_Reputation_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    local pos = View.ScrollView_Map.Img_BG.transform.position
    local posX = pos.x
    local posY = pos.y
    homeCommon.ClickReputationBtn(DataModel.stationId, posX, posY, function()
      homeCommon.SetReputationElement(View.Group_Reputation, DataModel.stationId)
    end)
  end,
  CityMap_Group_Navigation_Btn_Quest_Click = function(btn, str)
    UIManager:Open("UI/Quest/Quest")
  end,
  CityMap_Group_Navigation_Btn_Navigation_Click = function(btn, str)
  end,
  CityMap_Group_TopRight_Btn_Mission_Click = function(btn, str)
    Net:SendProto("quest.list", function(json)
      PlayerData.ServerData.quests = json.quests
      UIManager:Open("UI/BP_Quest/BattlePass_Quest")
    end, EnumDefine.QuestListDefine.BattlePassQuest)
  end,
  CityMap_Group_TopRight_Btn_Store_Click = function(btn, str)
    local a, b = PlayerData:OpenStoreCondition()
    if a == false then
      CommonTips.OpenTips(b[1].txt)
      return
    end
    Net:SendProto("shop.info", function(json)
      UIManager:Open("UI/Store/Store", Json.encode(json))
    end)
  end,
  CityMap_Group_TopRight_Btn_Headhunt_Click = function(btn, str)
    UIManager:Open("UI/Gacha/GachaNew")
  end,
  CityMap_Group_TopRight_Btn_Depot_Click = function(btn, str)
    UIManager:Open("UI/Depot/Depot")
  end,
  CityMap_Group_TopRight_Btn_Squads_Click = function(btn, str)
    local status = {
      Current = "MainUI",
      hasOpenThreeView = false,
      squadIndex = PlayerData.BattleInfo.squadIndex
    }
    PlayerData.Last_Chapter_Parms = nil
    UIManager:Open("UI/Squads/Squads", Json.encode(status))
  end,
  CityMap_Group_TopRight_Btn_Member_Click = function(btn, str)
    local status = {btn = "Member", roleId = ""}
    UIManager:Open("UI/CharacterList/CharacterList", Json.encode(status))
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build1_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build2_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build3_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build4_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build5_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build6_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build7_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build8_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build9_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build10_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build11_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build12_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build13_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build14_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build15_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build16_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build17_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build18_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build19_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build20_Btn_Special_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build1_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build2_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build3_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build4_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build5_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build6_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build7_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build8_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build9_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build10_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build11_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build12_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build13_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build14_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build15_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build16_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build17_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build18_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build19_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_ScrollView_Map_Viewport_Group_BG_Group_Build20_Btn_Build_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickBtn(idx)
  end,
  CityMap_Group_Construct_Btn_Construct_Click = function(btn, str)
    local row = {}
    for k, v in pairs(DataModel.ConstructNowCA) do
      row[k] = v
    end
    row.ConstructMaxNum = DataModel.ConstructMaxNum
    row.ConstructNowNum = DataModel.ConstructNowNum
    row.Index_Construct = DataModel.Index_Construct
    row.stationId = DataModel.stationId
    CommonTips.OpenConstructStage(row)
  end,
  CityMap_Group_TopRight_Btn_ActivityNew_Click = function(btn, str)
    UIManager:Open("UI/Activity/ActivityMain")
  end,
  CityMap_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end
}
return ViewFunction
