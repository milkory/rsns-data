local View = require("UIPlayer/UIPlayerView")
local DataModel = require("UIPlayer/UIPlayerDataModel")
local Controller = {}

function Controller.RefreshServiceBtn(hasReset)
  local count = PlayerData:GetUserInfo().red_dot_num
  if count and 0 < count then
    View.Group_Right.Btn_Service.Txt_Count:SetActive(not hasReset)
    if hasReset then
      PlayerData:GetUserInfo().red_dot_num = 0
    else
      View.Group_Right.Btn_Service.Txt_Count:SetText(tostring(count))
    end
  else
    View.Group_Right.Btn_Service.Txt_Count:SetActive(false)
  end
end

function Controller.OpenCDKey(hasOpen)
  View.Group_Right.Btn_CloseCDKey:SetActive(hasOpen)
  if hasOpen then
    View.Group_Right.Btn_CloseCDKey.InputField_CDKey.self:SetText("")
  end
end

function Controller.RedeemGift()
  local cdKey = View.Group_Right.Btn_CloseCDKey.InputField_CDKey.self:GetText()
  if cdKey == "" then
    CommonTips.OpenTips(GetText(80600225))
    return
  else
    GSDKManager:RedeemGift(cdKey, function(code)
      local hint = ""
      if code == 0 then
        hint = "兑换成功"
      elseif code == -400001 then
        hint = "参数错误,重新登陆账号"
      elseif code == -400006 then
        hint = "CdKey已经被使用过了"
      elseif code == -400007 then
        hint = "已经领取过同一批次的CdKey"
      elseif code == -400008 then
        hint = "CdKey未开放领取"
      elseif code == -400009 then
        hint = "CdKey领取已经结束"
      elseif code == -400010 then
        hint = "CdKey不存在"
      elseif code == -400011 then
        hint = "命中风控"
      else
        hint = "联系项目技术接口人"
      end
      hint = hint .. "(未翻译)"
      CommonTips.OpenTips(hint, true)
      if code == 0 then
        Controller.OpenCDKey(false)
      end
    end)
  end
end

function Controller.EntranceHost(sceneId, language)
  DataModel.EntranceHostData = {}
  GSDKManager:EntranceHost(sceneId, language, function(data)
  end, function(data)
  end)
end

function Controller.CheckQuestionnaire(callback)
  DataModel.QuestionnaireData = {}
  GSDKManager:CheckQuestionnaire(function(data)
    local info = Json.decode(data)
    if info.ec == 0 and 0 < info.data.unfinished_count then
      info = info.data
      local serverTime = TimeUtil:GetServerTimeStamp()
      local index = 1
      for k, v in pairs(info.survey_info) do
        if v.finished_flg == false and serverTime >= v.begin_time and serverTime <= v.end_time then
          DataModel.QuestionnaireData[index] = v.page_url
          index = index + 1
        end
      end
      if callback ~= nil and 0 < #DataModel.QuestionnaireData then
        callback()
      end
    end
  end, function(data)
    print_r("问卷信息Error: " .. data)
  end)
end

function Controller.RefreshQuestionnaireBtn()
  Controller.OpenQuestionnaire(false)
  local count = #DataModel.QuestionnaireData
  View.Group_Right.Btn_Questionnaire:SetActive(0 < count)
  View.Group_Right.Btn_Questionnaire.Txt_Count:SetActive(0 < count)
  if 0 < count then
    View.Group_Right.Btn_Questionnaire.Txt_Count:SetText(tostring(count))
  end
end

function Controller.OpenQuestionnaire(hasOpen)
  View.Group_Right.Btn_CloseQuestionnaire:SetActive(hasOpen)
  if hasOpen then
    DataModel.HasQuestionnaire = true
    View.Group_Right.Btn_CloseQuestionnaire.ScrollGrid_Questionnaire.grid.self:SetDataCount(#DataModel.QuestionnaireData)
    View.Group_Right.Btn_CloseQuestionnaire.ScrollGrid_Questionnaire.grid.self:RefreshAllElement()
  end
end

function Controller.OpenStore(hasOpen)
  if hasOpen then
    if PlayerData.ProductList == nil then
      return
    end
    View.Group_Right.Btn_CloseQuestionnaire:SetActive(hasOpen)
    DataModel.HasQuestionnaire = false
    View.Group_Right.Btn_CloseQuestionnaire.ScrollGrid_Questionnaire.grid.self:SetDataCount(PlayerData.ProductList.Count)
    View.Group_Right.Btn_CloseQuestionnaire.ScrollGrid_Questionnaire.grid.self:RefreshAllElement()
  else
    View.Group_Right.Btn_CloseQuestionnaire:SetActive(hasOpen)
  end
end

function Controller.SetElement(element, elementIndex)
  local text = "商品"
  if DataModel.HasQuestionnaire then
    text = "问卷"
  end
  element.Btn_Questionnaire.Txt_:SetText(text .. elementIndex)
end

function Controller.OnClickBtn(index)
  if DataModel.HasQuestionnaire then
    GSDKManager:Questionnaire(DataModel.QuestionnaireData[index], function()
      Controller.CheckQuestionnaire(function()
        Controller.RefreshQuestionnaireBtn()
      end)
      Controller.OpenQuestionnaire(false)
    end)
  else
    DataModel.isRequestPayResult = false
    DataModel.timer = DataModel.time
    DataModel.index = 0
    UIManager:Open("UI/Common/Waiting")
    View.Img_Mask:SetActive(true)
    DataModel.Product = PlayerData.ProductList[index - 1]
    PlayerData.PayProduct(DataModel.Product, function(orderID)
      if orderID ~= nil and orderID ~= "" then
        DataModel.OrderID = orderID
        DataModel.isRequestPayResult = true
      else
        UIManager:CloseTip("UI/Common/Waiting")
        View.Img_Mask:SetActive(false)
      end
    end)
  end
end

function Controller.UserInfo()
  local data = PlayerData:GetUserInfo()
  local url = "https://gsdk.dailygn.com/"
  if GSDKManager.AppService.EnableSandboxMode then
    url = "https://gsdk-sandbox.dailygn.com/"
  end
  MGameManager.WebView(GetText(80600182), url .. "h5/personal_protection/query?" .. "nickname=" .. data.role_name .. "&roleid=" .. PlayerPrefs.GetString("username") .. "&gamename=" .. data.role_name .. "&version=" .. GameSetting.version)
end

function Controller.OpenUrl(textId, url)
  MGameManager.WebView(GetText(textId), url)
end

function Controller.InitView()
  Controller.RefreshServiceBtn()
  Controller.RefreshQuestionnaireBtn()
  View.Img_Mask:SetActive(false)
  if UseGSDK and GSDKManager.AppService.ChannelOp ~= "bsdk" then
    View.Group_Right.Btn_Logout:SetActive(true)
  else
    View.Group_Right.Btn_Logout:SetActive(false)
  end
end

return Controller
