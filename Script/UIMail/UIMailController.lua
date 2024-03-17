local View = require("UIMail/UIMailView")
local DataModel = require("UIMail/UIMailDataModel")
local UIMailController = {}

function UIMailController:OnReceiveMailAward(args)
  if args == nil then
    return
  end
  local isOnekey = args.isOnekey
  SdkReporter.TrackGetEmailReward("", "", isOnekey)
end

function UIMailController:OnMailEvent()
  local data = DataModel.OpenData
  Net:SendProto("mail.accredit", function(json)
    CommonTips.OpenTips(80602513)
    DataModel.OpenData = PlayerData.ServerData.mails[tostring(data.id)]
    if not data.reward then
      View.Group_MailInfo_Normal.Btn_Receive.self:SetActive(false)
    end
    View.Group_MailInfo_Normal.Btn_Delete.self:SetActive(true)
    View.Group_MailInfo_Normal.ScrollView_Content.Viewport.Txt_Content.Btn_Event.self:SetActive(false)
    DataModel:RefreshData()
  end, tostring(data.id))
end

return UIMailController
