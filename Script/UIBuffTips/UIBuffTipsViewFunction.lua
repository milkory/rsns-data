local View = require("UIBuffTips/UIBuffTipsView")
local DataModel = require("UIBuffTips/UIBuffTipsDataModel")
local ViewFunction = {
  BuffTips_StaticGrid_Stage_SetGrid = function(element, elementIndex)
    local info = DataModel.allBuffStage[elementIndex]
    element.Img_Mask:SetActive(DataModel.curStageIndex < info.stageIndex)
    element.Group_Title.Txt_Num:SetText(info.stageIndex)
    local buffActive = info.stageIndex <= DataModel.curStageIndex and (info.stageCfg.buyNum >= DataModel.curStageCfg.buyNum or info.stageCfg.revenueNum >= DataModel.curStageCfg.revenueNum)
    element.Group_State.Img_ON:SetActive(buffActive)
    element.Group_State.Img_Off:SetActive(DataModel.curStageIndex < info.stageIndex)
  end,
  BuffTips_Group_Bar_Btn_Check_Click = function(btn, str)
    if UIManager:IsPanelOpened("UI/Activity/BlackTea/ServerProgress") then
      View.self:CloseUI()
      return
    end
    UIManager:Open("UI/Activity/BlackTea/ServerProgress")
  end,
  BuffTips_Btn_Close_Click = function(btn, str)
    View.self:PlayAnim("BuffTips_Out", function()
      View.self:CloseUI()
    end)
  end
}
return ViewFunction
