local View = require("UIBook/UIBookView")
local DataModel = require("UIBook/UIBookDataModel")
local Controller = {}
local InitView = function(isOpenCG)
  if isOpenCG then
    Controller.Open()
  else
    View.Group_CG.self:SetActive(false)
  end
end

function Controller.Init(isOpenCG)
  InitView(isOpenCG)
end

function Controller.Open()
  View.Group_CG:SetActive(true)
  DataModel.CurrentPage = DataModel.EnumPage.CG
  View.self:PlayAnim("CGIn")
end

function Controller.Close()
  View.self:PlayAnim("CGOut", function()
    DataModel.CurrentPage = DataModel.EnumPage.Main
    View.Group_CG.self:SetActive(false)
  end)
end

function Controller.Play()
  View.Group_CG.Video_CG.self:SetActive(true)
  View.Group_CG.Video_CG.self:Play("Video/Prologue/P1", false, false, true, function()
    View.Group_CG.Video_CG.self:SetActive(false)
  end)
end

return Controller
