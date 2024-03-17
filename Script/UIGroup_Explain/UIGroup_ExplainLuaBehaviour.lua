local View = require("UIGroup_Explain/UIGroup_ExplainView")
local DataModel = require("UIGroup_Explain/UIGroup_ExplainDataModel")
local ViewFunction = require("UIGroup_Explain/UIGroup_ExplainViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local row = Json.decode(initParams)
    DataModel = row
    print_r(row)
    print_r(PlayerData:GetFactoryData(11400006))
    if row.id == nil then
      UIManager:GoBack(false, 1)
      return
    end
    local CA = PlayerData:GetFactoryData(row.id)
    for i = 1, 2 do
      local obj = "group_" .. i
      View[obj].self:SetActive(false)
    end
    if row.id == 11400039 then
      View.group_2.self:SetActive(true)
      View.group_2.Txt_Content:SetText(CA.des)
      View.group_2.self:SetLocalPosition(Vector3(row.position.x, row.position.y, 0))
      row.extraData.endTime = 0
      if DataModel.extraData ~= nil and DataModel.extraData.minValue ~= nil and DataModel.extraData.curValue <= DataModel.extraData.minValue then
        local textId = DataModel.extraData.textId or 80600359
        View.group_2.Txt_Time:SetText(string.format(GetText(textId), "00:00"))
      end
    else
      View.group_1.self:SetActive(true)
      View.group_1.Txt_Content:SetText(CA.des)
      View.group_1.self:SetLocalPosition(Vector3(row.position.x, row.position.y, 0))
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.extraData ~= nil and DataModel.extraData.minValue ~= nil then
      if DataModel.extraData.curValue <= DataModel.extraData.minValue then
        return
      end
      local curTime = TimeUtil:GetServerTimeStamp()
      if curTime > DataModel.extraData.refreshTime + DataModel.extraData.onceTime then
        DataModel.extraData.refreshTime = DataModel.extraData.refreshTime + DataModel.extraData.onceTime
        DataModel.extraData.curValue = DataModel.extraData.curValue + DataModel.extraData.onceAdd
        if DataModel.extraData.curValue <= DataModel.extraData.minValue then
          local textId = DataModel.extraData.textId or 80600359
          View.group_2.Txt_Time:SetText(string.format(GetText(textId), "00:00"))
        end
      else
        local remainTime = DataModel.extraData.refreshTime + DataModel.extraData.onceTime - curTime
        local sec = remainTime % 60
        local min = (remainTime - sec) / 60
        local text = string.format("%02d:%02d", min, sec)
        local textId = DataModel.extraData.textId or 80600359
        View.group_2.Txt_Time:SetText(string.format(GetText(textId), text))
      end
    end
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
