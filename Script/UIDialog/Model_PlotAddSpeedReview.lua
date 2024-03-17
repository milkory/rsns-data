local base = require("UIDialog/Model_PlotBase")
local DataModel = require("UIDialog/UIDialogDataModel")
local View = require("UIDialog/UIDialogView")
local AddSpeedController = require("UIDialog/UIDialog_AddSpeedController")
local PlotAddSpeedReview = Class.New("PlotAddSpeedReview", base)

function PlotAddSpeedReview:Ctor()
end

local objectState = {}
local Hide = function(isHide)
  local transform = View.self.transform
  local count = transform.childCount - 1
  local gameObject
  if isHide then
    objectState = {}
    local name
    for i = 0, count do
      gameObject = transform:GetChild(i).gameObject
      name = gameObject.name
      if name ~= "Group_Shake" and name ~= "Img_Speaker" and name ~= "Btn_Dialog" and gameObject.activeInHierarchy then
        objectState[i] = i
        gameObject:SetActive(false)
      end
    end
  else
    for k, v in pairs(objectState) do
      transform:GetChild(v).gameObject:SetActive(true)
    end
  end
end
local lastPower = 0
local isAuto = false

function PlotAddSpeedReview:OnStart(ca)
  if ca.isAddSpeed then
    lastPower = DataModel.lastPower
    isAuto = DataModel.isAuto
    AddSpeedController.Destroy()
    DataModel.isAuto = true
    DataModel.SetAutoSpeed(ca.accelerateSpeed, true)
    Hide(true)
  else
    DataModel.SetAutoSpeed(lastPower)
    DataModel.isAuto = isAuto
    Hide(false)
  end
end

function PlotAddSpeedReview.GetState()
  return true
end

function PlotAddSpeedReview:Dtor()
end

return PlotAddSpeedReview
