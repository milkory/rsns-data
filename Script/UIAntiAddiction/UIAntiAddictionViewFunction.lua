local View = require("UIAntiAddiction/UIAntiAddictionView")
local DataModel = require("UIAntiAddiction/UIAntiAddictionDataModel")
local IsValidateIDInput = function(input)
  if input:GetLength() ~= 18 then
    CommonTips.OpenTips("身份证格式输入有误请重新输入")
    return false
  end
  return true
end
local IsValidateNameInput = function(input)
  if input:GetLength() > 12 then
    CommonTips.OpenTips("名字输入有误请重新输入")
    return false
  end
  return true
end
local ViewFunction = {
  AntiAddiction_Group_CheckIn_Btn_BG_Click = function(btn, str)
    UIManager:GoBack()
  end,
  AntiAddiction_Group_CheckIn_Btn_Confirm_Click = function(btn, str)
    local InputField_Name = View.Group_CheckIn.Group_Name.InputField_Name.self
    local InputField_ID = View.Group_CheckIn.Group_ID.InputField_ID.self
    if IsValidateIDInput(InputField_ID) and IsValidateNameInput(InputField_Name) then
      Net:SendProto("main.set_real_info", function(json)
        local years = PlayerData:IsCheckYearOld(InputField_ID:GetText())
        if years < 18 then
          View.Group_CheckInTip.self:SetActive(true)
          for i = 0, 2 do
            local txt = "Txt_Des_" .. i
            View.Group_CheckInTip[txt]:SetActive(false)
          end
          if 16 < years then
            View.Group_CheckInTip["Txt_Des_" .. 2]:SetActive(true)
          elseif 8 < years then
            View.Group_CheckInTip["Txt_Des_" .. 1]:SetActive(true)
          else
            View.Group_CheckInTip["Txt_Des_" .. 0]:SetActive(true)
          end
        end
        View.Group_CheckIn.self:SetActive(false)
        UIManager:GoBack(false, 1)
        if PlayerData:GetNoPrompt("logintNotice", 1, false) == false then
          CommonTips.OpenNoticeLogin()
          PlayerData:SetNoPrompt("logintNotice", 1, true, false)
        end
      end, InputField_ID:GetText(), InputField_Name:GetText())
    end
  end,
  AntiAddiction_Group_CheckIn_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  AntiAddiction_Group_CheckInTip_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  AntiAddiction_Group_CheckInTip_Btn_Confirm_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    View.self:Confirm()
  end,
  AntiAddiction_Group_NoLoginTip_Btn_BG_Click = function(btn, str)
    UIManager:GoBack()
    View.self:Confirm()
  end,
  AntiAddiction_Group_NoLoginTip_Btn_Confirm_Click = function(btn, str)
    UIManager:GoBack()
    View.self:Confirm()
  end,
  AntiAddiction_Group_TimeTip_Btn_BG_Click = function(btn, str)
    local username = PlayerPrefs.GetString("username")
    PlayerPrefs.SetInt(username .. "timetip", 1)
    UIManager:GoBack()
  end,
  AntiAddiction_Group_TimeTip_Btn_Confirm_Click = function(btn, str)
    local username = PlayerPrefs.GetString("username")
    PlayerPrefs.SetInt(username .. "timetip", 1)
    UIManager:GoBack(false, 1)
    View.self:Confirm()
  end,
  AntiAddiction_Group_TimeUpTip_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    View.self:Confirm()
  end,
  AntiAddiction_Group_TimeUpTip_Btn_Confirm_Click = function(btn, str)
    UIManager:GoBack()
  end,
  AntiAddiction_Group_TimeOutTip_Btn_BG_Click = function(btn, str)
    CBus:ChangeScene("Login")
  end,
  AntiAddiction_Group_TimeOutTip_Btn_Confirm_Click = function(btn, str)
    CBus:ChangeScene("Login")
  end,
  AntiAddiction_Group_NoPayTip_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  AntiAddiction_Group_NoPayTip_Btn_Confirm_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  AntiAddiction_Group_SinglePayTip_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  AntiAddiction_Group_SinglePayTip_Btn_Confirm_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  AntiAddiction_Group_CumulativePayTip_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  AntiAddiction_Group_CumulativePayTip_Btn_Confirm_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  AntiAddiction_Group_CheckInTip_Btn_Cancel_Click = function(btn, str)
  end,
  AntiAddiction_Group_NoLoginTip_Btn_Cancel_Click = function(btn, str)
  end,
  AntiAddiction_Group_TimeTip_Btn_Cancel_Click = function(btn, str)
  end,
  AntiAddiction_Group_TimeUpTip_Btn_Cancel_Click = function(btn, str)
  end,
  AntiAddiction_Group_TimeOutTip_Btn_Cancel_Click = function(btn, str)
  end,
  AntiAddiction_Group_NoPayTip_Btn_Cancel_Click = function(btn, str)
  end,
  AntiAddiction_Group_SinglePayTip_Btn_Cancel_Click = function(btn, str)
  end,
  AntiAddiction_Group_CumulativePayTip_Btn_Cancel_Click = function(btn, str)
  end,
  AntiAddiction_Btn_Tips3_Click = function(btn, str)
  end
}
return ViewFunction
