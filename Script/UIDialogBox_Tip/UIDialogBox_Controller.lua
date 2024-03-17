local DataModel = require("UIDialogBox_Tip/UIDialogBox_TipDataModel")
local ViewFunction = require("UIDialogBox_Tip/UIDialogBox_TipViewFunction")
local View = require("UIDialogBox_Tip/UIDialogBox_TipView")
local Controller = {}

function Controller.Update(time, successRatio)
  if DataModel.CurrTime == nil or time - DataModel.CurrTime > 5 then
    DataModel.CurrTime = time
    local param = {
      levelTextId = DataModel.TextId,
      facePath = DataModel.FacePath,
      params = {successRatio}
    }
    Controller.Init(param)
  end
end

function Controller.Init(param)
  if param.params and table.count(param.params) > 0 then
    local str = GetText(param.levelTextId)
    View.Txt_Context:SetText(string.format(str, table.unpack(param.params)))
  else
    View.Txt_Context:SetText(GetText(param.levelTextId))
  end
  if param.facePath then
    View.Img_Guide.Img_Head:SetSprite(param.facePath)
  end
end

function Controller.ChangeTextId(textId)
  DataModel.TextId = textId
end

function Controller.Close()
  if not DataModel.IsDestroy and not DataModel.IsClosing and View and View.self and View.self.IsActive then
    DataModel.IsClosing = true
    View.self:PlayAnim("DialogBox_out", function()
      DataModel.IsClosing = false
      UIManager:ClosePanel(false, "UI/Common/DialogBox_Tip")
    end)
  end
end

return Controller
