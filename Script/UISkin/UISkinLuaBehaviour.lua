local View = require("UISkin/UISkinView")
local DataModel = require("UISkin/UISkinDataModel")
local ViewFunction = require("UISkin/UISkinViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local params = Json.decode(initParams)
    DataModel.RoleId = params.RoleId
    DataModel.RoleData = params.RoleData
    DataModel.RoleCA = params.RoleCA
    DataModel.SkinList = {}
    DataModel.SkinGetWay = PlayerData:GetFactoryData(99900017).SkinGetWay
    DataModel.InitSkinId = tonumber(DataModel.RoleData.current_skin[1])
    local myselfSkin = table.count(DataModel.RoleData.skin_list)
    local ca_skin = DataModel.RoleCA.skinList
    local list_ca_skin = Clone(ca_skin)
    for k, v in pairs(list_ca_skin) do
      local skinCA = PlayerData:GetFactoryData(v.unitViewId)
      if skinCA.isSpine2 == 1 then
        local isHave = false
        local server = PlayerData:GetRoleById(DataModel.RoleId)
        local portrailData = PlayerData:GetFactoryData(v.unitViewId)
        if server.resonance_lv == 5 and portrailData.spine2Url ~= nil and portrailData.spine2Url ~= "" then
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
    View.Img_Bg.Group_Right.Img_Frame.ScrollGrid_SkinList.grid.self.StartCorner = "Center"
    if table.count(DataModel.SkinList) > 3 then
      View.Img_Bg.Group_Right.Img_Frame.ScrollGrid_SkinList.grid.self.StartCorner = "Left"
    end
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
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
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
