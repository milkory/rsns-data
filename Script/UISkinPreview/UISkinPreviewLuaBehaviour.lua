local View = require("UISkinPreview/UISkinPreviewView")
local DataModel = require("UISkinPreview/UISkinPreviewDataModel")
local ViewFunction = require("UISkinPreview/UISkinPreviewViewFunction")
local InitSkinView = function()
  local list = {}
  list[1] = {}
  list[1].unitViewId = DataModel.InitSkinId
  list[1].isSpine2 = 0
  if DataModel.RoleCA.spine2Url ~= nil and DataModel.RoleCA.spine2Url ~= "" then
    list[2] = {}
    list[2].unitViewId = DataModel.InitSkinId
    list[2].isSpine2 = 1
  end
  DataModel.SkinList = list
  DataModel.ChooseIndex = 1
  local count = 1
  for i = 1, table.count(list) do
    local data = list[i]
    local row = {}
    row.unitViewId = data.unitViewId
    row.isHave = false
    row.ca = PlayerData:GetFactoryData(row.unitViewId)
    row.isSelect = false
    row.isWear = false
    row.isSpine2 = data.isSpine2 or 0
    if row.isWear == true then
      row.isSelect = true
      DataModel.ChooseIndex = count
    end
    DataModel.SkinList[count] = row
    count = count + 1
  end
  View.Img_Bg.Group_Right.Txt_Showing:SetActive(true)
  View.Img_Bg.Group_Right.Group_HoldingStatus.self:SetActive(false)
end
local InitSkin = function()
  local myselfSkin = table.count(DataModel.RoleData.skin_list)
  local ca_skin = DataModel.RoleCA.skinList
  local list_ca_skin = Clone(ca_skin)
  for k, v in pairs(list_ca_skin) do
    local skinCA = PlayerData:GetFactoryData(v.unitViewId)
    if skinCA.isSpine2 == 1 then
      local isHave = false
      local server = PlayerData:GetRoleById(DataModel.RoleId)
      local portrailData = PlayerData:GetFactoryData(v.unitViewId)
      if server.resonance_lv == 5 and portrailData.State2Res ~= nil and portrailData.State2Res ~= "" then
        myselfSkin = myselfSkin + 1
        isHave = true
      end
      table.insert(ca_skin, 2 * k, {
        unitViewId = v.unitViewId,
        isSpine2 = 1,
        isHave = isHave
      })
    end
  end
  View.Img_Bg.Group_Right.Img_Frame.Img_OwnedBg.Txt_SkinNum:SetText(myselfSkin)
  DataModel.ChooseIndex = 1
  local count = 1
  for i = 1, table.count(ca_skin) do
    local data = ca_skin[i]
    local row = {}
    row.unitViewId = data.unitViewId
    row.isHave = false
    row.ca = PlayerData:GetFactoryData(row.unitViewId)
    row.isSelect = false
    row.isWear = false
    row.isSpine2 = data.isSpine2 or 0
    if tonumber(data.unitViewId) == tonumber(DataModel.RoleData.current_skin[1]) and row.isSpine2 == DataModel.RoleData.current_skin[2] then
      row.isWear = true
    end
    if row.isWear == true then
      row.isSelect = true
      DataModel.ChooseIndex = count
    end
    for c, d in pairs(DataModel.RoleData.skin_list) do
      if tostring(data.unitViewId) == c then
        row.isHave = true
        if data.isHave ~= nil then
          row.isHave = data.isHave
        end
        break
      end
    end
    DataModel.SkinList[count] = row
    count = count + 1
  end
  if table.count(DataModel.SkinList) > 3 then
    View.Img_Bg.Group_Right.Img_Frame.ScrollGrid_SkinList.grid.self.StartCorner = "Left"
  end
  View.Img_Bg.Group_Right.Txt_Showing:SetActive(false)
  View.Img_Bg.Group_Right.Group_HoldingStatus.self:SetActive(true)
end
local params
local Luabehaviour = {
  serialize = function()
    return params
  end,
  deserialize = function(initParams)
    DataModel.InfoInitPos.x = -Screen.width * 0.1 + 100
    params = initParams
    local params = Json.decode(initParams)
    DataModel.isSkinView = false
    View.Img_Bg.Group_Right.Img_Frame.ScrollGrid_SkinList.grid.self.StartCorner = "Center"
    DataModel.SkinList = {}
    if params.isSkinView == true then
      DataModel.InitSkinId = tonumber(params.id)
      DataModel.RoleId = PlayerData:GetFactoryData(params.id).character
      DataModel.RoleCA = PlayerData:GetFactoryData(params.id)
      InitSkinView()
    else
      DataModel.RoleData = params.RoleData
      DataModel.InitSkinId = tonumber(DataModel.RoleData.current_skin[1])
      DataModel.RoleId = params.RoleId
      DataModel.RoleCA = params.RoleCA
      InitSkin()
    end
    DataModel.Spine2PosX = 0
    DataModel:Reset()
    View.Img_Bg.Group_Right.Img_Frame.ScrollGrid_SkinList.grid.self:SetDataCount(table.count(DataModel.SkinList))
    View.Img_Bg.Group_Right.Img_Frame.ScrollGrid_SkinList.grid.self:RefreshAllElement()
    View.Img_Bg.Group_Right.Img_Frame.ScrollGrid_SkinList.grid.self:MoveToPos(DataModel.ChooseIndex)
    DataModel:ClickLeftSkin(DataModel.ChooseIndex, true)
    local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d")
    DataModel.live2D = live2D == 0
    local Img_Live2dBg = View.Img_Bg.Group_Left.Group_Bottom.Img_Live2dBg
    if live2D == 0 then
      Img_Live2dBg.Img_On.transform.localPosition = Vector3(24, 0, 0)
      Img_Live2dBg:SetSprite("UI/CharacterInfo/Skin/onbg")
    else
      Img_Live2dBg.Img_On.transform.localPosition = Vector3(-24, 0, 0)
      Img_Live2dBg:SetSprite("UI/CharacterInfo/Skin/offbg")
    end
    DataModel.LoadSpineBg(DataModel.InitSkinId)
    View.Group_CommonTopLeft.Btn_Home:SetActive(not MapNeedleEventData.openInsZone)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.NowSkin and DataModel.NowSkin.isSpine2 ~= 1 and View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled then
      local scrollDelta = Input.GetAxis("Mouse ScrollWheel")
      if scrollDelta ~= 0 then
        local scale = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.transform.localScale
        if scale.x + scrollDelta >= 0.5 and scale.x + scrollDelta <= 1.5 then
          scale.x = scale.x + scrollDelta
        end
        if 0.5 <= scale.y + scrollDelta and 1.5 >= scale.y + scrollDelta then
          scale.y = scale.y + scrollDelta
        end
        View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.transform.localScale = scale
        View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Character.transform.localScale = scale
      end
      if Input.touchCount ~= 2 then
        DataModel.touchInit = false
      end
      if Input.touchCount == 2 and not DataModel.touchInit then
        DataModel.touchInit = true
        local x = math.floor(Input.GetTouch(0).position.x - Input.GetTouch(1).position.x)
        local y = math.floor(Input.GetTouch(0).position.y - Input.GetTouch(1).position.y)
        DataModel.startDis = math.floor(math.sqrt(x * x + y * y))
      end
      if Input.touchCount == 2 and DataModel.touchInit then
        local cfg = PlayerData:GetFactoryData(99900001, "ConfigFactory")
        local x = math.floor(Input.GetTouch(0).position.x - Input.GetTouch(1).position.x)
        local y = math.floor(Input.GetTouch(0).position.y - Input.GetTouch(1).position.y)
        local dis = math.floor(math.sqrt(x * x + y * y))
        local changeDisRatio = (dis - DataModel.startDis) / cfg.scaleCoefficient
        if changeDisRatio ~= 0 then
          changeDisRatio = changeDisRatio * 0.1
          local scale = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.transform.localScale
          if scale.x + changeDisRatio >= 0.5 and scale.x + changeDisRatio <= 1.5 then
            scale.x = scale.x + changeDisRatio
          end
          if 0.5 <= scale.y + changeDisRatio and 1.5 >= scale.y + changeDisRatio then
            scale.y = scale.y + changeDisRatio
          end
          View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.transform.localScale = scale
          View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Character.transform.localScale = scale
          DataModel.startDis = dis
        end
      end
    end
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
