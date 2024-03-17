local View = require("UILogin/UILoginView")
local Controller = {}

function Controller:InitView()
  local btnQQ = View.Group_Account.Btn_QQ
  local sw = GameSetting.SWQQGroup
  if sw ~= nil and btnQQ ~= nil then
    btnQQ:SetActive(sw)
  end
end

function Controller:OpenView()
  local qqList = self:GetQQList()
  if qqList == nil then
    return
  end
  View.Group_QQ:SetActive(true)
  View.Group_QQ.ScrollGrid_QQ.grid.self:SetDataCount(#qqList)
  View.Group_QQ.ScrollGrid_QQ.grid.self:RefreshAllElement()
end

function Controller:CloseView()
  View.Group_QQ:SetActive(false)
end

function Controller:OnSetGrid(element, elementIndex)
  local data = self:GetQQData(elementIndex)
  if data == nil then
    return
  end
  element.Txt_Name:SetText(data.name)
  element.Btn_Join:SetClickParam(elementIndex)
end

function Controller:OnItemClick(btn, str)
  local data = self:GetQQData(tonumber(str))
  if data == nil then
    return
  end
  CS.UnityEngine.Application.OpenURL(data.Adress)
end

function Controller:GetQQList()
  local datas = PlayerData:GetFactoryData(99900057, "ConfigFactory")
  if datas == nil then
    return nil
  end
  local qqList = datas.qqList
  local result = {}
  local index = 1
  for i = 1, #qqList do
    if qqList[i].isShow then
      result[index] = qqList[i]
      index = index + 1
    end
  end
  return result
end

function Controller:GetQQData(elementIndex)
  local datas = self:GetQQList()
  if datas == nil then
    return nil
  end
  return datas[elementIndex]
end

return Controller
