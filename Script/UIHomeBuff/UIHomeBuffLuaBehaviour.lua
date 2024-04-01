local View = require("UIHomeBuff/UIHomeBuffView")
local DataModel = require("UIHomeBuff/UIHomeBuffDataModel")
local ViewFunction = require("UIHomeBuff/UIHomeBuffViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local data = Json.decode(initParams)
      DataModel.BuffData = data
      DataModel.drinkBuff = data.drinkBuff
      DataModel.bargainBuff = data.bargainBuff
      DataModel.stationStoreBuff = data.stationStoreBuff
      DataModel.battleBuff = data.battleBuff
      local groupTips = View.Group_Tips
      DataModel:RefreshBuffGroup(groupTips.Group_Drink, DataModel.drinkBuff)
      DataModel:RefreshBuffGroup(groupTips.Group_Food, DataModel.stationStoreBuff)
      DataModel:RefreshBuffGroup(groupTips.Group_Battle, DataModel.battleBuff)
      DataModel:RefreshBuffGroup(groupTips.Group_Bargain, DataModel.bargainBuff)
      groupTips.self:SetAnchoredPosition(Vector2(data.posX, data.posY))
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    local curTime = TimeUtil:GetServerTimeStamp()
    local groupTips = View.Group_Tips
    if DataModel.drinkBuff and curTime >= DataModel.drinkBuff.endTime then
      DataModel.drinkBuff = nil
      groupTips.Group_Drink.self:SetActive(false)
    end
    if DataModel.stationStoreBuff and curTime >= DataModel.stationStoreBuff.endTime then
      DataModel.stationStoreBuff = nil
      groupTips.Group_Food.self:SetActive(false)
    end
    if DataModel.battleBuff and curTime >= DataModel.battleBuff.endTime then
      DataModel.battleBuff = nil
      groupTips.Group_Battle.self:SetActive(false)
    end
    groupTips.Img_Separate1:SetActive(DataModel.drinkBuff ~= nil and DataModel.stationStoreBuff ~= nil)
    groupTips.Img_Separate2:SetActive(DataModel.stationStoreBuff ~= nil and DataModel.battleBuff ~= nil)
    groupTips.Img_Separate3:SetActive(DataModel.battleBuff ~= nil and DataModel.bargainBuff ~= nil)
    if DataModel.drinkBuff == nil and DataModel.stationStoreBuff == nil and DataModel.bargainBuff == nil and DataModel.battleBuff == nil then
      UIManager:CloseTip("UI/Common/HomeBuff")
      return
    end
    local down = false
    if Input.GetMouseButton(0) then
      down = true
    end
    local curFrameMouseDown = false
    local curFrameMouseUp = false
    if DataModel.preMouseDown ~= down then
      if DataModel.preMouseDown == false then
        curFrameMouseDown = true
      else
        curFrameMouseUp = true
      end
    end
    DataModel.preMouseDown = down
    if curFrameMouseDown then
      local pos = Input.mousePosition
      local camera = UIManager.UICamera
      if camera ~= nil and CS.UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(View.Group_Tips.self.Rect, Vector2(pos.x, pos.y), camera) then
        return
      end
      UIManager:CloseTip("UI/Common/HomeBuff")
    end
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
