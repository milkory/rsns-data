local View = require("UIESC/UIESCView")
local DataModel = require("UIESC/UIESCDataModel")
local Controller = require("UIESC/UIESCController")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  ESC_Btn_Close_Click = function(btn, str)
    Controller:Exit()
  end,
  ESC_Btn_Camera_Click = function(btn, str)
    CommonTips.OpenTips(80600368)
  end,
  ESC_Btn_Notice_Click = function(btn, str)
    CommonTips.OpenNoticeLogin()
  end,
  ESC_Btn_Mail_Click = function(btn, str)
    local funcCommon = require("Common/FuncCommon")
    if funcCommon.FuncActiveCheck(117) then
      Net:SendProto("mail.get", function(json)
        PlayerData.ServerData.mails = json.mails
        Controller:ExitTo("UI/Mail/Mail")
      end)
    end
  end,
  ESC_Btn_Set_Click = function(btn, str)
    Controller:ExitTo("UI/Setting/Setting")
  end,
  ESC_Btn_LogOut_Click = function(btn, str)
    CommonTips.OnPrompt(80600797, nil, nil, function()
      SdkHelper.TryLogout()
      PlayerData:Logout()
    end)
  end,
  ESC_Btn_Signln_Click = function(btn, str)
    Controller:ExitTo("UI/SignIn/SignIn")
  end,
  ESC_Group_Info_Btn_ProfilePhoto_Click = function(btn, str)
    Controller:ClickHead()
  end,
  ESC_Group_Info_Btn_ChangeName_Click = function(btn, str)
    local timestamp = PlayerData:GetUserInfo().name_punish_time or 0
    Controller:CheckModifyIsPunish("UI/Common/Group_InputName", timestamp, 80600172)
  end,
  ESC_Group_Info_Group_Energy_Btn_Add_Click = function(btn, str)
    UIManager:Open("UI/Energy/Energy", nil, function()
      local userInfo = PlayerData:GetUserInfo()
      View.Group_Info.Group_Energy.Txt_Num:SetText(userInfo.energy .. "/" .. userInfo.max_energy)
      View.Group_Info.Group_Diamond.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    end)
  end,
  ESC_Group_Info_Group_HomeEnergy_Btn_Add_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.OpenMoveEnergyUseItem(function()
      homeCommon.SetMoveEnergyElement(View.Group_Info.Group_HomeEnergy)
      View.Group_Info.Group_Diamond.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    end)
  end,
  ESC_Group_Info_Group_Loadage_Btn_Add_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_Energy_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_Loadage_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_HomeEnergy_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_Gold_Btn_Add_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_Gold_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_Diamond_Btn_Add_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  ESC_Group_Info_Group_Diamond_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Btn_MoreInfo_Click = function(btn, str)
    View.Group_Info.Group_MoreInfo.self:SetActive(true)
  end,
  ESC_Group_Info_Group_MoreInfo_Group_Trade_Btn_Add_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_MoreInfo_Group_Trade_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_MoreInfo_Btn_Fans_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_MoreInfo_Btn_Rep_Click = function(btn, str)
    Controller:ShowAllRep()
  end,
  ESC_Group_Info_Group_MoreInfo_Btn_LessInfo_Click = function(btn, str)
    View.Group_Info.Group_MoreInfo.self:SetActive(false)
  end,
  ESC_Group_AllRep_Btn_Close_Click = function(btn, str)
    View.Group_AllRep.self:SetActive(false)
  end,
  ESC_Group_AllRep_ScrollGrid_CityList_SetGrid = function(element, elementIndex)
    Controller:RefreshRepElement(element, elementIndex)
  end,
  ESC_Group_LevelReward_Img_BG_Group_Tab_ScrollGrid_Tab_SetGrid = function(element, elementIndex)
    element.Btn_Unfinished.Txt_:SetText("LV " .. DataModel.lv_cfg[elementIndex].level)
    element.Img_Finished.Txt_:SetText("LV " .. DataModel.lv_cfg[elementIndex].level)
    element.Img_Selected.Txt_:SetText("LV " .. DataModel.lv_cfg[elementIndex].level)
    element.Btn_Unfinished:SetClickParam(elementIndex)
    element.Img_Selected:SetActive(elementIndex == DataModel.lv_selectIdx)
    local id = tostring(DataModel.lv_cfg[elementIndex].id)
    element.Img_Got:SetActive(DataModel.rec_list[DataModel.lv_cfg[elementIndex].level])
    element.Img_Remind:SetActive(not DataModel.rec_list[DataModel.lv_cfg[elementIndex].level] and elementIndex <= DataModel.max_lvidx)
    element.Img_Finished:SetActive(elementIndex <= DataModel.max_lvidx)
  end,
  ESC_Group_LevelReward_Img_BG_Group_Tab_ScrollGrid_Tab_Group_Item_Btn_Unfinished_Click = function(btn, str)
    DataModel.lv_selectIdx = tonumber(str)
    Controller.RefreshLvInfo()
    local info = PlayerData:GetFactoryData(DataModel.lv_cfg[DataModel.lv_selectIdx].id).Unlockright
    local count = #info
    View.Group_LevelReward.Img_BG.Group_BotRight:SetLocalPositionY(DataModel.pos_list[count + 1])
  end,
  ESC_Group_LevelReward_Img_BG_Group_BotRight_Img_RewardBg_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local info = PlayerData:GetFactoryData(DataModel.lv_cfg[DataModel.lv_selectIdx].id).reward[elementIndex]
    CommonItem:SetItem(element.Group_Item, {
      id = info.id,
      num = info.num
    }, EnumDefine.ItemType.Item)
    element.Group_Item.Btn_Item:SetClickParam(info.id)
  end,
  ESC_Group_LevelReward_Img_BG_Group_BotRight_Img_RewardBg_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  ESC_Group_ChangeProfilePhoto_ScrollGrid_ProfilePhoto_SetGrid = function(element, elementIndex)
    Controller:RefreshHeadElement(element, elementIndex)
  end,
  ESC_Group_ChangeProfilePhoto_ScrollGrid_ProfilePhoto_Group_Item_Btn_ProfilePhoto_Click = function(btn, str)
    Controller:ClickHeadElement(str)
  end,
  ESC_Group_ChangeProfilePhoto_Btn_Close_Click = function(btn, str)
    Controller:CloseChangeHeadPanel(false)
  end,
  ESC_Group_ChangeProfilePhoto_Btn_Use_Click = function(btn, str)
    Controller:CloseChangeHeadPanel(true)
  end,
  ESC_Group_AllRep_Btn_BG_Click = function(btn, str)
    View.Group_AllRep.self:SetActive(false)
  end,
  ESC_Group_ChangeProfilePhoto_Btn_BG_Click = function(btn, str)
    Controller:CloseChangeHeadPanel(false)
  end,
  ESC_Group_LevelReward_Btn_Close_Click = function(btn, str)
    View.Group_LevelReward:SetActive(false)
  end,
  ESC_Group_LevelReward_Img_BG_Group_TopRight_Group_Unlock_StaticGrid_UnlockRight_SetGrid = function(element, elementIndex)
    local info = PlayerData:GetFactoryData(DataModel.lv_cfg[DataModel.lv_selectIdx].id).Unlockright[elementIndex]
    if info then
      element:SetActive(true)
      element.Img_BgOpen.Txt_:SetText(info.id)
      element.Img_Bg.Txt_:SetText(info.id)
      element.Img_Bg:SetActive(DataModel.lv_selectIdx > DataModel.max_lvidx)
      element.Img_BgOpen:SetActive(DataModel.lv_selectIdx <= DataModel.max_lvidx)
    else
      element:SetActive(false)
    end
  end,
  ESC_Group_Info_Group_License_Btn_Lv_Click = function(btn, str)
    UIManager:LoadSplitPrefab(View, "UI/MainUI/ESC", "Group_LevelReward")
    View.Group_LevelReward:SetActive(true)
    DataModel.lv_selectIdx = DataModel.max_lvidx
    View.Group_LevelReward.Img_BG.Group_Tab.ScrollGrid_Tab.grid.self.ScrollRect.verticalNormalizedPosition = 1
    Controller.RefreshLvInfo()
    View.Group_LevelReward.Img_BG.Group_Tab.ScrollGrid_Tab.grid.self:MoveToPos(DataModel.max_lvidx)
    local info = PlayerData:GetFactoryData(DataModel.lv_cfg[DataModel.lv_selectIdx].id).Unlockright
    local count = #info
    View.Group_LevelReward.Img_BG.Group_BotRight:SetLocalPositionY(DataModel.pos_list[count + 1])
  end,
  ESC_Group_LevelReward_Img_BG_Group_TakeBtn_Btn_Take_Click = function(btn, str)
    Net:SendProto("home.rank_reward", function(json)
      CommonTips.OpenShowItem(json.reward)
      DataModel.rec_list[DataModel.lv_cfg[DataModel.lv_selectIdx].level] = 1
      table.insert(PlayerData:GetHomeInfo().rank_reward, DataModel.lv_cfg[DataModel.lv_selectIdx].level)
      Controller.RefreshLvInfo()
      DataModel.can_recv_cnt = DataModel.can_recv_cnt - 1
      View.Group_Info.Group_License.Btn_Lv.Img_RemindOut:SetActive(DataModel.can_recv_cnt > 0)
      View.Group_Info.Group_Diamond.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    end, tostring(DataModel.lv_cfg[DataModel.lv_selectIdx].id and DataModel.lv_selectIdx - 1))
  end,
  ESC_Group_Info_Btn_LCZspine_Click = function(btn, str)
    local gender = PlayerData:GetUserInfo().gender or 1
    local characterId = gender == 1 and 70000067 or 70000063
    local json = Json.encode({characterId = characterId})
    UIManager:Open("UI/ChangeSkin/ChangeSkin", json)
  end,
  ESC_NewScrollGrid_BtnList_SetGrid = function(element, elementIndex)
    local info = DataModel.FuncShowList[elementIndex]
    element.Btn_Func.self:SetClickParam(elementIndex)
    element.Btn_Func.Img_Icon:SetSprite(info.icon)
    element.Btn_Func.Txt_Name:SetText(info.name)
    element.Btn_Func.Img_Tip:SetActive(false)
    if info.prefab == "UI/Achievement/Achievement" then
      element.Btn_Func.Img_Tip:SetActive(RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.AchievementUI) > 0)
    end
    if info.prefab == "UI/Home_MachiningMenu/Home_MachiningMenu" then
      local machiningData = require("UIHome_MachiningMenu/UIHome_MachiningMenuDataModel")
      machiningData.InitData()
      element.Btn_Func.Img_Tip:SetActive(machiningData.GetRedPointState())
    end
  end,
  ESC_NewScrollGrid_BtnList_Group_Item_Btn_Func_Click = function(btn, str)
    local idx = tonumber(str)
    local info = DataModel.FuncShowList[idx]
    if info.prefab == "" then
      CommonTips.OpenTips(80600368)
      return
    end
    if info.prefab == "UI/Squads/Squads" then
      local status = {
        Current = "MainUI",
        hasOpenThreeView = false,
        squadIndex = PlayerData.BattleInfo.squadIndex
      }
      Controller:ExitTo(info.prefab, Json.encode(status))
      return
    elseif info.prefab == "UI/Store/Store" then
      Controller:OpenStoreBuyDiamond()
      return
    elseif info.prefab == "UI/PlotReview/PlotReview" then
      Net:SendProto("plot.info", function(json)
        Controller:ExitTo("UI/PlotReview/PlotReview", Json.encode(json.plot_paragraph))
      end)
      return
    elseif info.prefab == "UI/Login/AcountInfo" then
      UIManager:Open("UI/Login/AcountInfo")
      return
    end
    if info.param ~= nil and info.param ~= "" then
      Controller:ExitTo(info.prefab, Json.encode(info.param))
    else
      Controller:ExitTo(info.prefab)
    end
  end,
  ESC_Group_Info_Txt_UID_Btn_Copy_Click = function(btn, str)
    CS.UnityEngine.GUIUtility.systemCopyBuffer = PlayerData:GetUserInfo().uid
    CommonTips.OpenTips(80602254)
  end,
  ESC_ScrollGrid_BtnList_SetGrid = function(element, elementIndex)
    local info = DataModel.FuncShowList[elementIndex]
    element.Btn_Func.self:SetClickParam(elementIndex)
    element.Btn_Func.Img_Icon:SetSprite(info.icon)
    element.Btn_Func.Txt_Name:SetText(info.name)
    element.Btn_Func.Img_Tip:SetActive(false)
    if info.prefab == "UI/Achievement/Achievement" then
      element.Btn_Func.Img_Tip:SetActive(RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.AchievementUI) > 0)
    end
  end,
  ESC_ScrollGrid_BtnList_Group_Item_Btn_Func_Click = function(btn, str)
    local idx = tonumber(str)
    local info = DataModel.FuncShowList[idx]
    if info.prefab == "" then
      CommonTips.OpenTips(80600368)
      return
    end
    if info.prefab == "UI/Squads/Squads" then
      local status = {
        Current = "MainUI",
        hasOpenThreeView = false,
        squadIndex = PlayerData.BattleInfo.squadIndex
      }
      Controller:ExitTo(info.prefab, Json.encode(status))
      return
    elseif info.prefab == "UI/Store/Store" then
      Controller:OpenStoreBuyDiamond()
      return
    elseif info.prefab == "UI/PlotReview/PlotReview" then
      Net:SendProto("plot.info", function(json)
        Controller:ExitTo("UI/PlotReview/PlotReview", Json.encode(json.plot_paragraph))
      end)
      return
    end
    if info.param ~= nil and info.param ~= "" then
      Controller:ExitTo(info.prefab, Json.encode(info.param))
    else
      Controller:ExitTo(info.prefab)
    end
  end
}
return ViewFunction
