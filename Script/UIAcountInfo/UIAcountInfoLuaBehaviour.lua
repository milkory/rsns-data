local View = require("UIAcountInfo/UIAcountInfoView")
local DataModel = require("UIAcountInfo/UIAcountInfoDataModel")
local NewLoginDataModel = require("UINewLogin/UINewLoginDataModel")
local ViewFunction = require("UIAcountInfo/UIAcountInfoViewFunction")
local Timer = require("Common/Timer")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local phoneIDList = PlayerPrefs.GetString("PhoneIDList")
    local phoneID
    if phoneIDList ~= "" then
      local phoneIDList = Json.decode(phoneIDList)
      if phoneIDList[1] then
        phoneID = phoneIDList[1].username
      end
    end
    if phoneID then
      local formatPhoneID = NewLoginDataModel.FormatPhoneID(phoneID)
      View.Group_NewLoginAndJoin.Group_Main.Img_Account.Txt_ID:SetText(formatPhoneID)
      View.Group_NewLoginAndJoin.Group_Change.InputField_Account:SetText(phoneID)
    end
    View.Group_NewLoginAndJoin.Group_Change:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Main:SetActive(true)
    DataModel.codeTimer = 0
  end,
  awake = function()
    View.timer = Timer.New(1, function()
      DataModel.codeTimer = DataModel.codeTimer - 1
      if DataModel.codeTimer < 0 then
        View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Get:SetActive(true)
        View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Count:SetActive(false)
        View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode:SetBtnInteractable(true)
      end
      View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Count:SetText(DataModel.codeTimer)
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
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
