local base = require("UIDialog/Model_PlotBase")
local DataModel = require("UIDialog/UIDialogDataModel")
local ChangeSpine = Class.New("ChangeSpine", base)

function ChangeSpine.Ctor()
end

function ChangeSpine:OnStart(ca)
  local spineCA = ca
  local data = DataModel.SetPaintData(DataModel.EnumSetPaintData.Find, spineCA.posIndex)
  if data.spine and data.unitViewID > 0 and data.unitViewID == spineCA.unitViewID then
    data.spine:SetAction(spineCA.aniName, spineCA.isLoop, spineCA.isChangeImmediately)
  end
end

function ChangeSpine:OnUpdate()
end

function ChangeSpine.GetState()
  return true
end

function ChangeSpine:Dtor()
end

return ChangeSpine
