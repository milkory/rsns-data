local View = require("UIPayTips/UIPayTipsView")
local DataModel = require("UIPayTips/UIPayTipsDataModel")
local Controller = {}
Controller.TYPE_ALI = 1
Controller.TYPE_WX = 2

function Controller:InitView()
  View.Group_Top.Txt_Name:SetText(DataModel:GetName())
  View.Group_Top.Txt_Price:SetText(DataModel:GetPriceStr())
  self:SelectAli()
end

function Controller:Select(type)
  local isAli = type == 1
  View.Group_Pay.Group_ALIPAY.Group_Off.self:SetActive(not isAli)
  View.Group_Pay.Group_ALIPAY.Group_On.self:SetActive(isAli)
  View.Group_Pay.Group_WeChat.Group_Off.self:SetActive(isAli)
  View.Group_Pay.Group_WeChat.Group_On.self:SetActive(not isAli)
  PayGV.CurPayType = type
end

function Controller:SelectAli()
  self:Select(self.TYPE_ALI)
end

function Controller:SelectWx()
  self:Select(self.TYPE_WX)
end

function Controller:IsAliPay(type)
  return type == 1
end

function Controller:OK()
  View.self:Confirm()
end

function Controller:CloseUI()
  View.self:CloseUI()
end

return Controller
