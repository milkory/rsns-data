local ChapterMapEventListener = require("UIChapterMap/UIChapterMapEventListener")
local ChapterMapView = require("UIChapterMap/UIChapterMapView")
local Order = {}

function Order:OnStart(ca)
  for k, v in pairs(ChapterMapView.Group_Map.Group_Track.Group_Level) do
    if k ~= "self" and v.data.levelId == ca.specificLevelId then
      ChapterMapEventListener:FocusSpecificLevel(v, ca.tweenTime)
      break
    end
  end
end

function Order:IsFinish()
  return ChapterMapEventListener:IsFinish()
end

return Order
