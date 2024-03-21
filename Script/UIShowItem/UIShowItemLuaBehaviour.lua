local View = require("UIShowItem/UIShowItemView")
local ViewFunction = require("UIShowItem/UIShowItemViewFunction")
local DataModel = require("UIShowItem/UIShowItemDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local status = {}
    if initParams ~= nil and initParams ~= "" then
      status = Json.decode(initParams)
    end
    DataModel.stepClose = 0
    DataModel.Data = PlayerData:SortShowItem(status.rewards)
    if table.count(DataModel.Data) <= 15 then
      View.ScrollGrid_Items.self:SetEnable(false)
      View.ScrollGrid_Items.grid.self:SetStartCorner("Center")
    else
      View.ScrollGrid_Items.self:SetEnable(true)
      View.ScrollGrid_Items.grid.self:SetStartCorner("Left")
    end
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
      View.ScrollGrid_Items.grid.self:SetDataCount(table.count(DataModel.Data))
      View.ScrollGrid_Items.grid.self:RefreshAllElement()
      local row = View.ScrollGrid_Items.grid.self:GetRow()
      View.Group_300:SetActive(false)
      View.Group_580:SetActive(false)
      View.Group_800:SetActive(false)
      View.Group_890:SetActive(false)
      if row == 1 then
        View.Group_300:SetActive(true)
      elseif row == 2 then
        View.Group_580:SetActive(true)
      elseif row == 3 then
        View.Group_800:SetActive(true)
      else
        View.Group_890:SetActive(true)
      end
    end))
    if status.title then
      View.Group_300.Group_Title.Txt_Title:SetText(status.title)
    else
      View.Group_300.Group_Title.Txt_Title:SetText(GetText(80601874))
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    DataModel.stepClose = DataModel.stepClose + 1
    if DataModel.stepClose > DataModel.timeClose then
      ViewFunction.ShowItem_Btn_OK_Click()
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
