local view = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local Controller
local PlotJumpOrder = Class.New("PlotJumpOrder", base)

function PlotJumpOrder:Ctor()
end

function PlotJumpOrder:OnStart(ca, addPlotIndex)
  local plotList = {}
  if ca.insertParagraph > 0 then
    local paCa = PlayerData:GetFactoryData(ca.insertParagraph, "ParagraphFactory")
    if paCa.mod == "段落脚本" then
      local info
      local isMale = PlayerData.IsMale()
      local path
      if paCa.girlPath ~= nil and paCa.girlPath ~= "" then
        path = isMale and paCa.path or paCa.girlPath
      else
        path = paCa.path
      end
      if ca.insertLabel == nil or ca.insertLabel == "" then
        local pattern
        if paCa.girlPattern ~= nil and paCa.girlPattern ~= "" then
          pattern = isMale and paCa.pattern or paCa.girlPattern
        else
          pattern = paCa.pattern
        end
        info = ParseParagraphScript():Parse(path, pattern)
      else
        info = ParseParagraphScript():Parse(path, ca.insertLabel)
      end
      for k, v in pairs(info.plotBaseCAs) do
        plotList[k] = v
      end
    elseif paCa.mod == "段落" then
      local curPlotList
      if paCa.plotListGril ~= nil and 0 < #paCa.plotListGril then
        curPlotList = PlayerData.IsMale() and paCa.plotList or paCa.plotListGril
      else
        curPlotList = paCa.plotList
      end
      for k, v in pairs(curPlotList) do
        plotList[k] = PlayerData:GetFactoryData(v, "PlotFactory")
      end
    end
  end
  if plotList ~= nil then
    require("UIDialog/Model_PlotController").resetPlotList(plotList)
  end
  addPlotIndex(ca.indexInList)
end

function PlotJumpOrder.GetState()
  return false
end

function PlotJumpOrder:Dtor()
end

return PlotJumpOrder
