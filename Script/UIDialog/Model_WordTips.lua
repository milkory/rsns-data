local base = require("UIDialog/Model_PlotBase")
local DataModel = require("UIDialog/UIDialogDataModel")
local Tips = Class.New("Model_WordTips", base)

function Tips:Ctor()
end

function Tips:OnStart(ca)
  local index = 0
  local gotWord = {}
  local hasGot = false
  if 0 < ca.tip01 then
    for k, v in pairs(PlayerData.gotWord) do
      if tonumber(v) == ca.tip01 then
        hasGot = true
        break
      end
    end
    if hasGot == false then
      index = index + 1
      gotWord[index] = ca.tip01
    end
  end
  if 0 < ca.tip02 and ca.tip01 ~= ca.tip02 then
    hasGot = false
    for k, v in pairs(PlayerData.gotWord) do
      if tonumber(v) == ca.tip02 then
        hasGot = true
        break
      end
    end
    if hasGot == false then
      index = index + 1
      gotWord[index] = ca.tip02
    end
  end
  if next(gotWord) ~= nil then
    Net:SendProto("plot.note_noun", function(json)
      local data = {
        isOpen = true,
        gotWord = gotWord,
        perCharSpeed = DataModel.GetCurrentScaleValue(DataModel.perCharSpeed),
        animSpeed = DataModel.GetCurrentScaleValue(1)
      }
      UIManager:Open("UI/Dialog/Tips/DialogTips", Json.encode(data))
      for i, v in ipairs(DataModel.PaintData) do
        if v ~= nil and v.spine ~= nil and not v.spine:IsNull() then
          v.spine:SetOrder(v.spine.order + i)
        end
      end
    end, table.concat(gotWord, ","))
  end
end

function Tips.GetState()
  return true
end

function Tips:Dtor()
end

return Tips
