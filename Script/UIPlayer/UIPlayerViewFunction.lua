local Controller = require("UIPlayer/UIPlayerController")
local DataModel = require("UIPlayer/UIPlayerDataModel")
local ViewFunction = {
  Player_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Player_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Player_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Player_Group_Right_Btn_Info_Click = function(btn, str)
    Controller.UserInfo()
  end,
  Player_Group_Right_Btn_Privacy_Click = function(btn, str)
    Controller.OpenUrl(80600177, "https://lf3-cdn-tos.draftstatic.com/obj/ies-hotsoon-draft/GSDK/Goda.html")
  end,
  Player_Group_Right_Btn_System_Click = function(btn, str)
    Controller.OpenUrl(80600178, "https://sf3-cdn-tos.douyinstatic.com/obj/ies-hotsoon-draft/GSDK/os_perms_newdomain.html")
  end,
  Player_Group_Right_Btn_SDK_Click = function(btn, str)
    Controller.OpenUrl(80600179, "https://sf1-cdn-tos.douyinstatic.com/obj/ies-hotsoon-draft/GSDK/third_party_newdomain.html")
  end,
  Player_Group_Right_Btn_User_Click = function(btn, str)
    Controller.OpenUrl(80600180, "https://sf3-cdn-tos.douyinstatic.com/obj/ies-hotsoon-draft/GSDK/user_contract_newdomain.html")
  end,
  Player_Group_Right_Btn_List_Click = function(btn, str)
    Controller.OpenUrl(80600181, "https://lf26-cdn-tos.draftstatic.com/obj/ies-hotsoon-draft/GSDK/info_collect_list.html")
  end,
  Player_Group_Right_Btn_Service_Click = function(btn, str)
    GSDKManager:Service(true, function()
      Controller.RefreshServiceBtn(true)
    end)
  end,
  Player_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Player_Group_Right_Btn_CdKey_Click = function(btn, str)
    Controller.OpenCDKey(true)
  end,
  Player_Group_Right_Btn_Questionnaire_Click = function(btn, str)
    Controller.OpenQuestionnaire(true)
  end,
  Player_Group_Right_Btn_CloseCDKey_Click = function(btn, str)
    Controller.OpenCDKey(false)
  end,
  Player_Group_Right_Btn_CloseCDKey_Btn_Confirm_Click = function(btn, str)
    Controller.RedeemGift()
  end,
  Player_Group_Right_Btn_CloseCDKey_Btn_Cancel_Click = function(btn, str)
    Controller.OpenCDKey(false)
  end,
  Player_Group_Right_Btn_CloseQuestionnaire_Click = function(btn, str)
    if DataModel.HasQuestionnaire then
      Controller.OpenQuestionnaire(false)
    else
      Controller.OpenStore(false)
    end
  end,
  Player_Group_Right_Btn_CloseQuestionnaire_ScrollGrid_Questionnaire_SetGrid = function(element, elementIndex)
    element.Btn_Questionnaire:SetClickParam(elementIndex)
    Controller.SetElement(element, elementIndex)
  end,
  Player_Group_Right_Btn_CloseQuestionnaire_ScrollGrid_Questionnaire_Group_Item_Btn_Questionnaire_Click = function(btn, str)
    Controller.OnClickBtn(tonumber(str))
  end,
  Player_Group_Right_Btn_Logout_Click = function(btn, str)
    GSDKManager:ChannelLogout(function()
      Net:SendProto("main.query_user", function(json)
        if json.rc == "" then
          PlayerData:Logout()
        end
      end, PlayerPrefs.GetString(PlayerPrefs.GetString("username") .. "openid"))
    end)
  end,
  Player_Group_Right_Btn_Store_Click = function(btn, str)
    Controller.OpenStore(true)
  end
}
return ViewFunction
