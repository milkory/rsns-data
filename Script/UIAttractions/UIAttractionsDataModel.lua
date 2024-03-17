local DataModel = {}

function DataModel.Init(param)
  local id = param.id
  PlayerData:SetAttractionTipId(id)
  local ca = PlayerData:GetFactoryData(id, "ParagraphFactory")
  local caDescList = ca.DescList
  local descDataList = {}
  for i = 1, #caDescList do
    local descCA = PlayerData:GetFactoryData(caDescList[i].id)
    local data = {
      fadeInFrame = descCA.FadeInFrame,
      fadeOutFrame = descCA.FadeOutFrame,
      keepFrame = descCA.KeepFrame,
      descStr = descCA.Desc,
      avatarPath = descCA.Avatar,
      characterName = descCA.Character,
      isHalfSprite = descCA.IsHalfSprite
    }
    descDataList[i] = data
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  DataModel.maxDescNum = homeConfig.maxAttractionTipNum
  DataModel.offsetX = homeConfig.attractionTipOffsetX
  DataModel.offsetY = homeConfig.attractionTipOffsetY
  DataModel.spacing = homeConfig.attractionTipSpacing
  DataModel.attrictionId = id
  DataModel.descDataList = descDataList
  DataModel.curFrame = 0
  DataModel.curIdx = param.index or 0
end

return DataModel
