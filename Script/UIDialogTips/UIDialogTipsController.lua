local View = require("UIDialogTips/UIDialogTipsView")
local DataModel = require("UIDialogTips/UIDialogTipsDataModel")
local Controller = {}
local SetText = function(data, view, perCharSpeed)
  local tCA = PlayerData:GetFactoryData(data, "DataFactory")
  local tCA2 = PlayerData:GetFactoryData(tCA.from, "ListFactory")
  view:SetActive(true)
  view.Group_Title.Txt_Title:SetText(tCA.name)
  view.Group_Title.Txt_From:SetText(tCA2.name)
  view.Group_text.Txt_Text:SetTweenContent(tCA.tipsDesc, nil, perCharSpeed)
end

function Controller.PopUpTips(data)
  View.Group_Tips:SetActive(data.isOpen)
  View.Group_OnlyTip:SetActive(not data.isOpen)
  if data.isOpen then
    DataModel.HasOpenTips = #data.gotWord > 0
    View.Group_Tips:SetActive(DataModel.HasOpenTips)
    if DataModel.HasOpenTips then
      SetText(data.gotWord[1], View.Group_Tips.Img_Bg, data.perCharSpeed)
      if #data.gotWord > 1 then
        SetText(data.gotWord[2], View.Group_Tips.Img_Bg2, data.perCharSpeed)
      else
        View.Group_Tips.Img_Bg2:SetActive(false)
      end
      View.self:PlayAnim("tipsIn1", nil, 1.0 / data.animSpeed)
    else
      UIManager:CloseTip("UI/Dialog/Tips/DialogTips")
    end
  else
    View.self:PlayAnim("tipsIn2", function()
      DataModel.timer = 0
      DataModel.HasOpenOnlyTip = true
    end)
  end
end

function Controller.CloseTips(speed)
  if DataModel.HasOpenTips == false then
    return
  end
  DataModel.HasOpenTips = false
  View.self:PlayAnim("tipsOut1", function()
    UIManager:CloseTip("UI/Dialog/Tips/DialogTips")
  end, speed)
end

function Controller.PopUpOnlyTip()
end

return Controller
