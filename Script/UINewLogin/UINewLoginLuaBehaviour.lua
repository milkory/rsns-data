local View = require("UINewLogin/UINewLoginView")
local DataModel = require("UINewLogin/UINewLoginDataModel")
local ViewFunction = require("UINewLogin/UINewLoginViewFunction")
local Timer = require("Common/Timer")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.Init()
    View.Group_NewLoginAndJoin.Group_DirectLogin:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Login:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Switch:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Login2:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Join:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Change:SetActive(false)
    View.Btn_Tips3:SetActive(false)
    PlayerPrefs.SetInt("IsAgree", -1)
    View.Group_NewLoginAndJoin.Group_Toggle.Btn_toggle.Img_On:SetActive(PlayerPrefs.GetInt("IsAgree") == 1)
    if next(DataModel.phoneIDList) then
      if initParams then
        ViewFunction.ShowLoginPanel(false)
        View.Group_NewLoginAndJoin.Group_Login.InputField_Account:SetText(DataModel.phoneIDList[1].username)
        DataModel.SavePhoneIdList(DataModel.phoneIDList[1].username, " ", " ", DataModel.phoneIDList[1].lastLoginTs)
        return
      end
      View.Group_NewLoginAndJoin.Group_Toggle:SetAnchoredPositionY(0)
      View.Group_NewLoginAndJoin.Img_BG.Img_BG:SetActive(true)
      View.Group_NewLoginAndJoin.Img_BG.Img_BG2:SetActive(false)
      View.Group_NewLoginAndJoin.Btn_Close:SetActive(true)
      View.Group_NewLoginAndJoin.Group_Switch:SetActive(true)
      View.Group_NewLoginAndJoin.Group_Switch.Btn_off:SetActive(false)
      View.Group_NewLoginAndJoin.Group_Switch.ScrollGrid_AccountList.grid.self:SetActive(false)
      View.Group_NewLoginAndJoin.Group_Switch.Img_Account.Txt_Account:SetText(DataModel.FormatPhoneID(DataModel.phoneIDList[1].username))
      local severTs = TimeUtil.GetServerTimeStamp()
      local formatTs = DataModel.FormatTime(severTs - DataModel.phoneIDList[DataModel.nowSelectId].lastLoginTs)
      View.Group_NewLoginAndJoin.Group_Switch.Group_Time.Txt_Time:SetText(formatTs)
    else
      ViewFunction.ShowLoginPanel(false)
    end
  end,
  awake = function()
    View.timer = Timer.New(1, function()
      DataModel.codeTimer = DataModel.codeTimer - 1
      if DataModel.codeTimer < 0 then
        if DataModel.timerType == 1 then
          View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode.Txt_Get:SetActive(true)
          View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode.Txt_Count:SetActive(false)
          View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode:SetBtnInteractable(true)
        elseif DataModel.timerType == 2 then
          View.Group_NewLoginAndJoin.Group_Join.Btn_GetCode.Txt_Get:SetActive(true)
          View.Group_NewLoginAndJoin.Group_Join.Btn_GetCode.Txt_Count:SetActive(false)
          View.Group_NewLoginAndJoin.Group_Join.Btn_GetCode:SetBtnInteractable(true)
        elseif DataModel.timerType == 3 then
          View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Get:SetActive(true)
          View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Count:SetActive(false)
          View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode:SetBtnInteractable(true)
        end
      end
      if DataModel.timerType == 1 then
        View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode.Txt_Count:SetText(DataModel.codeTimer)
      elseif DataModel.timerType == 2 then
        View.Group_NewLoginAndJoin.Group_Join.Btn_GetCode.Txt_Count:SetText(DataModel.codeTimer)
      elseif DataModel.timerType == 3 then
        View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Count:SetText(DataModel.codeTimer)
      end
    end)
  end,
  start = function()
  end,
  update = function()
    if DataModel.codeTimer >= 0 then
      View.timer:Update()
    end
  end,
  ondestroy = function()
  end,
  enable = function()
    View.Group_NewLoginAndJoin.Group_Login2.InputField_PassWord:ShowPassword(false)
    View.Group_NewLoginAndJoin.Group_Login2.Btn_ShowandHide.Img_Hide:SetActive(true)
    View.Group_NewLoginAndJoin.Group_Login2.Btn_ShowandHide.Img_Show:SetActive(false)
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
