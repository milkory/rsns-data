local View = require("UICoreGradeTips/UICoreGradeTipsView")
local DataModel = require("UICoreGradeTips/UICoreGradeTipsDataModel")
local BtnItem = require("Common/BtnItem")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  local ca = PlayerData:GetFactoryData(DataModel.data.caId)
  DataModel.overviewSelectPath = ca.overviewSelectPath
  View.Group_Overview.Img_BG:SetSprite(ca.overviewBgPath)
  View.Group_Overview.Group_Top.Img_Icon:SetSprite(ca.coreIconPath)
  View.Group_Overview.Group_Top.Txt_Dec:SetText(string.format(GetText(80602321), GetText(ca.name)))
  local count = #DataModel.levelInfo + DataModel.defaultOffset
  View.Group_Overview.Page_Grade.grid.self:SetDataCount(count)
  local width = count * View.Group_Overview.Page_Grade.grid.self.CellSize.x
  width = width + (count - 1) * View.Group_Overview.Page_Grade.grid.self.Spacing.x
  View.Group_Overview.Page_Grade.grid.self.RectTransform.sizeDelta = Vector2(width, 0)
  View.Group_Overview.Page_Grade.grid.self:MoveToPos(DataModel.moveToIdx)
  Controller:Select(DataModel.moveToIdx + DataModel.defaultOffset)
  View.Group_Overview.Page_Grade.grid.self:RefreshAllElement()
  View.Group_Overview.Page_Grade.grid.self:UpdateScale()
  for i = 1, DataModel.defaultOffset do
    Controller:RefreshElementSpecified(i, count - i + 1)
  end
end

function Controller:SetElement(element, elementIndex)
  local info = DataModel.levelInfo[elementIndex]
  local isEmpty = info == nil
  element:SetActive(not isEmpty)
  if isEmpty then
    return
  end
  local isSelect = DataModel.curSelectIdx == elementIndex
  local isComplete = info.lv <= DataModel.curLv
  if info.lv == DataModel.curLv and isComplete then
    isComplete = not info.isBreak
  end
  element.Group_Child.Group_Off:SetActive(not isSelect)
  element.Group_Child.Group_On:SetActive(isSelect)
  local curOnOffElement
  if isSelect then
    element.Group_Child.Group_On.Img_Bg:SetSprite(DataModel.overviewSelectPath)
    curOnOffElement = element.Group_Child.Group_On
  else
    curOnOffElement = element.Group_Child.Group_Off
  end
  element.Group_Child.Group_Grade:SetActive(not info.isBreak)
  element.Group_Child.Group_Break:SetActive(info.isBreak)
  if not info.isBreak then
    element.Group_Child.Group_Grade.Txt_Grade:SetText(info.lv)
  end
  curOnOffElement.Img_Complete:SetActive(isComplete)
  curOnOffElement.Img_RedPoint:SetActive(RedpointTree:GetRedpointCnt(info.redName) > 0)
  element.Group_Child.Btn_:SetClickParam(elementIndex)
end

function Controller:ClickPageBtn(str)
  local idx = tonumber(str)
  View.Group_Overview.Page_Grade.grid.self:MoveToPos(idx - DataModel.defaultOffset)
  Controller:Select(idx)
  View.Group_Overview.Page_Grade.grid.self:UpdateScale()
end

function Controller:Select(idx, force)
  if not force and DataModel.curSelectIdx == idx then
    return
  end
  local info = DataModel.levelInfo[idx]
  if info == nil then
    return
  end
  local oldIdx = DataModel.curSelectIdx
  DataModel.curSelectIdx = idx
  Controller:RefreshElementSpecified(oldIdx, idx)
  View.Group_Overview.Group_Information.Group_Dec.Group_Upgrade:SetActive(not info.isBreak)
  View.Group_Overview.Group_Information.Group_Dec.Group_Break:SetActive(info.isBreak)
  if info.isBreak then
    View.Group_Overview.Group_Information.Group_Dec.Group_Break.StaticGrid_List.grid.self:RefreshAllElement()
  else
    View.Group_Overview.Group_Information.Group_Dec.Group_Upgrade.StaticGrid_List.grid.self:RefreshAllElement()
  end
  local showReward = #info.rewardItems > 0
  View.Group_Overview.Group_Information.Group_Reward:SetActive(showReward)
  if showReward then
    View.Group_Overview.Group_Information.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(#info.rewardItems)
    View.Group_Overview.Group_Information.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
  end
  local isComplete = info.lv <= DataModel.curLv
  if info.lv == DataModel.curLv and isComplete then
    isComplete = not info.isBreak
  end
  View.Group_Overview.Group_Btn.Group_Wei:SetActive(not isComplete)
  View.Group_Overview.Group_Btn.Group_Complete:SetActive(false)
  View.Group_Overview.Group_Btn.Group_Already:SetActive(false)
  View.Group_Overview.Group_Btn.Group_AlreadyGet:SetActive(false)
  if isComplete then
    if #info.rewardItems > 0 then
      local isGet = DataModel.GetRewardLv[info.lv - 1] or false
      View.Group_Overview.Group_Btn.Group_Already:SetActive(not isGet)
      View.Group_Overview.Group_Btn.Group_AlreadyGet:SetActive(isGet)
    else
      View.Group_Overview.Group_Btn.Group_Complete:SetActive(true)
    end
  end
end

function Controller:RefreshElementSpecified(oldIdx, newIdx)
  if 0 < oldIdx then
    local element = View.Group_Overview.Page_Grade.grid.self:GetElementByIndex(oldIdx - 1)
    if element then
      Controller:SetElement(element, oldIdx)
    end
  end
  if oldIdx == newIdx then
    return
  end
  if 0 < newIdx then
    local element = View.Group_Overview.Page_Grade.grid.self:GetElementByIndex(newIdx - 1)
    if element then
      Controller:SetElement(element, newIdx)
    end
  end
end

function Controller:SetChildDecElement(element, elementIndex)
  if 1 < elementIndex then
    element:SetActive(false)
    return
  end
  local info = DataModel.levelInfo[DataModel.curSelectIdx]
  if info.afterBreak then
    element.Txt_Condition:SetText(GetText(80602019))
  else
    element.Txt_Condition:SetText(string.format(DataModel.challengeTxt, info.battleName, info.num))
  end
end

function Controller:SetChildBreakElement(element, elementIndex)
  local info = DataModel.levelInfo[DataModel.curSelectIdx]
  local breakItem = info.breakItems[elementIndex]
  element.self:SetActive(breakItem ~= nil)
  if breakItem ~= nil then
    BtnItem:SetItem(element, {
      id = breakItem.id,
      num = breakItem.num
    })
    element.Btn_Item:SetClickParam(breakItem.id)
  end
end

function Controller:SetRewardElement(element, elementIndex)
  local info = DataModel.levelInfo[DataModel.curSelectIdx]
  local rewardItem = info.rewardItems[elementIndex]
  BtnItem:SetItem(element.Group_Item, {
    id = rewardItem.id,
    num = rewardItem.num
  })
  element.Group_Item.Btn_Item:SetClickParam(rewardItem.id)
end

function Controller:ClickItem(str)
  local id = tonumber(str)
  CommonTips.OpenItem({itemId = id})
end

function Controller:ClickGetReward()
  local info = DataModel.levelInfo[DataModel.curSelectIdx]
  local caId = DataModel.data.caId
  Net:SendProto("core.rec_reward", function(json)
    CommonTips.OpenShowItem(json.reward)
    DataModel.GetRewardLv[info.lv - 1] = 0
    local serverInfo = PlayerData.ServerData.engines[tostring(caId)]
    if serverInfo.lv_reward == nil then
      serverInfo.lv_reward = {}
    end
    table.insert(serverInfo.lv_reward, info.lv - 1)
    local redName = RedpointTree.NodeNames.Core .. "|" .. DataModel.data.caId .. "|" .. info.lv
    RedpointTree:ChangeRedpointCnt(redName, -1)
    RedpointTree:DeleteNode(redName)
    Controller:Select(DataModel.curSelectIdx, true)
  end, caId, info.lv - 1)
end

return Controller
