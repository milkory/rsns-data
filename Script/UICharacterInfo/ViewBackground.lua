local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = require("UICharacterInfo/DataModel")
local module = {
  Load = function(self, skinId, isSkin)
    local portraitId = DataModel.RoleData.current_skin[1]
    if skinId then
      portraitId = skinId
    end
    if portraitId == nil or portraitId == 0 then
      local viewCa = PlayerData:GetFactoryData(DataModel.RoleCA.viewId, "UnitViewFactory")
      portraitId = DataModel.RoleCA.viewId
    end
    View.Group_Middle.SpineAnimation_Character:SetActive(false)
    View.Group_Middle.SpineSecondMode_Character:SetActive(false)
    local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d")
    DataModel.live2D = live2D
    local isSpine2 = false
    View.Group_Middle.Group_Mask.self:SetActive(false)
    if portrailData.spineUrl ~= nil and portrailData.spineUrl ~= "" then
      View.Group_Middle.Group_Character.self:SetActive(false)
      View.Group_Middle.SpineAnimation_Character:SetActive(true)
      local spineUrl = portrailData.spineUrl
      local state = false
      if DataModel.RoleData.resonance_lv == 5 and portrailData.spine2Url ~= nil and portrailData.spine2Url ~= "" and DataModel.RoleData.current_skin[2] == 1 then
        state = true
      end
      if isSkin ~= nil then
        state = isSkin
      end
      if state == true then
        spineUrl = portrailData.spine2Url
        isSpine2 = true
      end
      View.Group_Middle.SpineAnimation_Character:SetActive(not isSpine2)
      View.Group_Middle.SpineSecondMode_Character:SetActive(isSpine2)
      View.Group_Middle.SpineSecondMode_Character:SetLocalScale(Vector3(1, 1, 1))
      if live2D == 1 then
        View.Group_Middle.SpineAnimation_Character:SetActive(false)
        View.Group_Middle.SpineSecondMode_Character:SetActive(false)
        View.Group_Middle.Group_Character.self:SetActive(true)
        if isSpine2 == true then
          View.Group_Middle.Group_Character.Img_Character:SetSprite(portrailData.State2Res)
          View.Group_Middle.Group_Mask.self:SetActive(true)
        else
          View.Group_Middle.Group_Character.Img_Character:SetSprite(portrailData.resUrl)
        end
        View.Group_Middle.Group_Character.Img_Character:SetNativeSize()
        DataModel.InfoInitPos.isRecord = true
        if DataModel.InfoInitPos.isRecord then
          DataModel.InfoInitPos.isRecord = false
          local transform = View.Group_Middle.transform
          View.Group_Middle.Group_Character.self:SetLocalPositionX(DataModel.InfoInitPos.x)
          DataModel.InfoInitPos.y = transform.localPosition.y
          DataModel.InfoInitPos.scale = transform.localScale.x
        end
        DataModel.InfoInitPos.offsetX = portrailData.offsetX
        DataModel.InfoInitPos.offsetY = portrailData.offsetY
      elseif isSpine2 then
        View.Group_Middle.SpineSecondMode_Character:SetPrefab(spineUrl)
        View.Group_Middle.SpineAnimation_Character:SetData("")
        View.Group_Middle.SpineSecondMode_Character.transform.localPosition = Vector3(portrailData.spine2X, portrailData.spine2Y, 0)
        View.Group_Middle.Group_Mask.self:SetActive(true)
        if portrailData.state2Overturn == true then
          View.Group_Middle.SpineSecondMode_Character:SetLocalScale(Vector3(-1, 1, 1))
        end
      else
        View.Group_Middle.SpineAnimation_Character:SetActive(true)
        View.Group_Middle.SpineSecondMode_Character:SetPrefab("")
        View.Group_Middle.SpineAnimation_Character:SetData(spineUrl)
        View.Group_Middle.SpineAnimation_Character:SetLocalScale(Vector3(100, 100, 1))
        View.Group_Middle.SpineAnimation_Character.transform.localPosition = Vector3(-275 + portrailData.spineX, -1200 + portrailData.spineY, 0)
      end
    else
      View.Group_Middle.SpineAnimation_Character:SetActive(false)
      View.Group_Middle.Group_Character.self:SetActive(true)
      View.Group_Middle.Group_Character.Img_Character:SetSprite(portrailData.resUrl)
      View.Group_Middle.Group_Character.Img_Character:SetNativeSize()
      if DataModel.InfoInitPos.isRecord then
        DataModel.InfoInitPos.isRecord = false
        local transform = View.Group_Middle.transform
        View.Group_Middle.Group_Character.self:SetLocalPositionX(DataModel.InfoInitPos.x)
        DataModel.InfoInitPos.y = transform.localPosition.y
        DataModel.InfoInitPos.scale = transform.localScale.x
      end
      DataModel.InfoInitPos.offsetX = portrailData.offsetX
      DataModel.InfoInitPos.offsetY = portrailData.offsetY
    end
    if DataModel.InfoInitPos.isRecord == false then
      local pos = DataModel.InfoInitPos
      local posX = pos.x + portrailData.offsetX * pos.scale
      local posY = pos.y + portrailData.offsetY * pos.scale
      View.Group_Middle.Group_Character.Img_Character:SetLocalPosition(Vector3(-275 + portrailData.offsetX, portrailData.offsetY, 0))
      View.Group_Middle.Group_Character.Img_Character:SetLocalScale(Vector3(portrailData.offsetScale, portrailData.offsetScale, portrailData.offsetScale))
      if isSpine2 == true then
        posX = pos.x + portrailData.offsetX2 * pos.scale
        posY = pos.y + portrailData.offsetY2 * pos.scale
        View.Group_Middle.Group_Character.Img_Character:SetLocalScale(Vector3(1, 1, 1))
        View.Group_Middle.Group_Character.Img_Character:SetLocalPosition(Vector3(portrailData.offsetX2, portrailData.offsetY2, 0))
      end
    end
    DataModel.NowSkin = {}
    DataModel.NowSkin.portraitId = tonumber(portraitId)
    DataModel.NowSkin.isSpine2 = isSpine2 == true and 1 or 0
    DataModel.LoadSpineBg()
  end
}
return module
