local View = require("UICharacterList/UICharacterListView")
local ViewFunction = require("UICharacterList/UICharacterListViewFunction")
local BtnController = require("UICharacterList/Controller_Btn")
local DataModel = require("UICharacterList/UICharacterListDataModel")
local Luabehaviour = {
  serialize = function()
    local status = {}
    status = BtnController:Serialize()
    return Json.encode(status)
  end,
  deserialize = function(initParams)
    View.self:PlayAnim("In")
    local status = {}
    if initParams ~= nil and initParams ~= "" then
      status = Json.decode(initParams)
    end
    DataModel.isSetPainting = status.btn == "Change"
    DataModel.selectRoleIndex = status.selectRoleIndex and status.selectRoleIndex or 1
    DataModel.InitData(status.roleId)
    BtnController:Deserialize()
    BtnController.Open_Screen_Chapter(false)
    BtnController.InitFilter()
    BtnController:Init(PlayerData.CharacterSort == nil and View.Group_TopRight.Btn_Level or PlayerData.CharacterSort)
    BtnController.RefreshCharacterFilter()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    for k, v in pairs(View.ScrollGrid_Middle.grid) do
      if v ~= nil and v ~= View.ScrollGrid_Middle.grid.self then
        v._current = nil
      end
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
