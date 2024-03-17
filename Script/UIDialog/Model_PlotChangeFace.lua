local base = require("UIDialog/Model_PlotBase")
local DataModel = require("UIDialog/UIDialogDataModel")
local PlotChangeFace = Class.New("PlotChangeFace", base)

function PlotChangeFace.Ctor()
end

function PlotChangeFace:OnStart(ca)
  local data = DataModel.SetPaintData(DataModel.EnumSetPaintData.Find, ca.portraitIndex)
  if data ~= nil then
    local faceIndex = ca.faceIndex
    local face = data.faceData
    local faces = face.faces
    local img = data.face
    if 0 < faceIndex and faceIndex <= table.count(faces) then
      img:SetPos(face.X, face.Y)
      img:SetSprite(faces[faceIndex].face)
    end
  end
end

function PlotChangeFace:OnUpdate()
end

function PlotChangeFace.GetState()
  return true
end

function PlotChangeFace:Dtor()
end

return PlotChangeFace
