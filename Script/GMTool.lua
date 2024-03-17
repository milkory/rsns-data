local gmTool = {}
local gachaView = require("UIGacha/UIGachaViewFunction")

function gmTool.Gacha(idStr)
  tIdList = Split(idStr, "#")
  tHeroList = {}
  for k, v in pairs(tIdList) do
    table.insert(tHeroList, {id = v, isNew = true})
  end
  local t
  if #tIdList < 2 then
    t = {
      type = EnumDefine.DrawCard.One,
      cards = tHeroList,
      index = 1
    }
  else
    t = {
      type = EnumDefine.DrawCard.Ten,
      cards = tHeroList,
      index = 1
    }
  end
  local maxLv = 1
  for i, v in pairs(tHeroList) do
    local detail = PlayerData:GetFactoryData(v.id, "UnitFactory")
    if maxLv < detail.qualityInt then
      maxLv = detail.qualityInt
    end
  end
  VideoManager:Play("Video/Gacha/Gacha0" .. maxLv, function()
    UIManager:Open("UI/ShowCharacter/ShowCharacter", Json.encode(t), nil, nil, false, true)
  end, false, true, false)
  UIManager:Open("UI/Gacha/Skip", Json.encode(t))
end

return gmTool
