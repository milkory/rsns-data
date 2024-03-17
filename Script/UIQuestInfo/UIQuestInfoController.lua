local View = require("UIQuestInfo/UIQuestInfoView")
local DataModel = require("UIQuestInfo/UIQuestInfoDataModel")
local Controller = {}

function Controller:Init()
  local goodsCA = PlayerData:GetFactoryData(DataModel.Data.id, "HomeGoodsFactory")
  local BtnItem = require("Common/BtnItem")
  BtnItem:SetItem(View.Group_Item, {
    id = DataModel.Data.id,
    num = DataModel.Data.curNum
  })
  View.Group_Item.Btn_Item:SetClickParam(tostring(DataModel.Data.id))
  View.Group_Item.Img_Specialty:SetActive(goodsCA.isSpeciality)
  View.Txt_Name:SetText(goodsCA.name)
  Controller:UpdateNum()
  View.ScrollGrid_QuestList.grid.self:SetDataCount(#DataModel.Data.quests)
  View.ScrollGrid_QuestList.grid.self:RefreshAllElement()
end

function Controller:UpdateNum()
  if DataModel.Data == nil then
    return
  end
  local curNumText = ""
  if DataModel.DeltaNum == 0 then
    curNumText = DataModel.Data.curNum
  elseif DataModel.DeltaNum > 0 then
    curNumText = string.format(GetText(80601916), DataModel.Data.curNum, DataModel.DeltaNum)
  elseif DataModel.DeltaNum < 0 then
    curNumText = string.format(GetText(80601917), DataModel.Data.curNum, -DataModel.DeltaNum)
  end
  View.Group_Num.Txt_Now:SetText(curNumText)
  View.Group_Num.Txt_Need:SetText(DataModel.Data.needNum)
end

function Controller:RefreshElement(element, elementIndex)
  local info = DataModel.Data.quests[elementIndex]
  local questCA = PlayerData:GetFactoryData(info.questId, "QuestFactory")
  local stationCA = PlayerData:GetFactoryData(info.endStation, "HomeStationFactory")
  element.Txt_Name:SetText(questCA.name)
  element.Txt_Location:SetText(stationCA.name)
  element.Txt_Num:SetText(info.needNum)
end

function Controller:SetDeltaNum(num)
  DataModel.DeltaNum = num
  Controller:UpdateNum()
end

return Controller
