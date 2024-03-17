local View = require("UIHomeCoach/UIHomeCoachView")
local DataModel = require("UIHomeCoach/UIHomeCoachDataModel")
local ViewFunction = require("UIHomeCoach/UIHomeCoachViewFunction")
local Controller = require("UIHomeCoach/UIHomeCoachController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.init = true
    DataModel.tempPanel = nil
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    HomeSceneManager:ShowOutScene(false)
    DataModel.rollText = {}
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.init == true then
      DataModel.init = false
      View.Group_Decorate.Group_Warehouse.Group_PresetSave.InputField_Name.self:SetCharacterLimit(DataModel.characterMaxLimit)
      View.Group_Decorate.Group_Warehouse.Group_PresetTips.Group_ChangeName.InputField_ChangeName.self:SetCharacterLimit(DataModel.characterMaxLimit)
      Controller:Init()
    end
    if table.count(DataModel.rollText) > 0 then
      for i, v in pairs(DataModel.rollText) do
        if not v[1].IsActive or not v[2].IsActive then
          DataModel.rollText[i] = nil
        else
          v[1]:SetAnchoredPosition(Vector2(v[1]:GetAnchoredPositionX() - Time.deltaTime * 20, v[1]:GetAnchoredPositionY()))
          v[2]:SetAnchoredPosition(Vector2(v[2]:GetAnchoredPositionX() - Time.deltaTime * 20, v[2]:GetAnchoredPositionY()))
          if -v[1]:GetAnchoredPositionX() > v[1].Rect.rect.width then
            v[1]:SetAnchoredPosition(Vector2(v[1].Rect.rect.width + v[2]:GetAnchoredPositionX() + 60, v[1]:GetAnchoredPositionY()))
          end
          if -v[2]:GetAnchoredPositionX() > v[2].Rect.rect.width then
            v[2]:SetAnchoredPosition(Vector2(v[2].Rect.rect.width + v[1]:GetAnchoredPositionX() + 60, v[2]:GetAnchoredPositionY()))
          end
        end
      end
    end
  end,
  ondestroy = function()
    View.self:PlayAnim("coach_out")
    HomeSceneManager:ShowOutScene(true)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
