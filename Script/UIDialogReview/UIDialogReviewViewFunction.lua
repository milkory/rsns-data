local View = require("UIDialogReview/UIDialogReviewView")
local DataModel = require("UIDialogReview/UIDialogReviewDataModel")
local DialogDataModel = require("UIDialog/UIDialogDataModel")
local ViewFunction = {
  DialogReview_CustomScrollGrid_LOG_SetGrid = function(element, elementIndex)
    View.myCustomSV:SetItemShowAndHide(View.CustomScrollGrid_LOG.self.currentPosXOrY)
  end,
  DialogReview_Btn_LogBack_Click = function(btn, str)
    UIManager:CloseTip("UI/Dialog/DialogReview")
    DialogDataModel.isPause = false
    for i, v in ipairs(DialogDataModel.PaintData) do
      v.spine:SetOrder(v.spine.order + i)
    end
  end,
  DialogReview_Btn_BackToButton_Click = function(btn, str)
  end
}
return ViewFunction
