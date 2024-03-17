local View = require("UIQuestTips/UIQuestTipsView")
local DataModel = require("UIQuestTips/UIQuestTipsDataModel")
local Controller = {}

function Controller:Show()
  if DataModel.count > 0 then
    local curShowInfo = DataModel.questInfo[1]
    DataModel.count = DataModel.count - 1
    table.remove(DataModel.questInfo, 1)
    local questCA = PlayerData:GetFactoryData(curShowInfo.id, "QuestFactory")
    View.Txt_New:SetActive(curShowInfo.isNew and questCA.isShowUnlock)
    View.Img_Side:SetActive(questCA.questType == "Side")
    View.Txt_Side:SetActive(questCA.questType == "Side")
    View.Img_Main:SetActive(questCA.questType == "Main")
    View.Txt_Main:SetActive(questCA.questType == "Main")
    View.Txt_Dec:SetText(questCA.describe)
    View.Txt_Num:SetText(curShowInfo.newPcnt .. "/" .. questCA.num)
    View.Group_Progress.Img_Before:SetFilledImgAmount(curShowInfo.oldPcnt / questCA.num)
    View.Group_Progress.Img_Now:SetFilledImgAmount(curShowInfo.newPcnt / questCA.num)
    View.self:PlayAnimOnce("tips", function()
      if DataModel.count == 0 then
        UIManager:GoBack(false)
      else
        self:Show()
      end
    end)
  else
    UIManager:GoBack(false)
  end
end

return Controller
