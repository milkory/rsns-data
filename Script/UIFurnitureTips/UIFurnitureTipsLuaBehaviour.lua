local View = require("UIFurnitureTips/UIFurnitureTipsView")
local DataModel = require("UIFurnitureTips/UIFurnitureTipsDataModel")
local ViewFunction = require("UIFurnitureTips/UIFurnitureTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local param = Json.decode(initParams)
    local furCA = PlayerData:GetFactoryData(param.id, "HomeFurnitureFactory")
    View.Group_Show.Txt_Name:SetText(furCA.name)
    View.Group_Show.ScrollView_Describe.Viewport.Txt_Describe:SetText(furCA.describe)
    local homeCoachDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
    local furData = homeCoachDataModel.GetFurnitureData(param.id)
    local furSkinCA
    if furData.data[1] == nil then
      furSkinCA = PlayerData:GetFactoryData(param.id, "HomeFurnitureSkinFactory")
      View.Group_Show.Group_Num.self:SetActive(false)
    else
      furSkinCA = PlayerData:GetFactoryData(PosClickHandler.GetFurnitureSkinId(furData.data[1].server.u_fid), "HomeFurnitureSkinFactory")
      View.Group_Show.Group_Num.self:SetActive(true)
      View.Group_Show.Group_Num.Txt_Num:SetText(param.cnt)
    end
    local tipsPath = ""
    if tonumber(param.id) == 81300192 then
      tipsPath = PlayerData:GetUserInfo().gender == 1 and furSkinCA.tipsPath or furSkinCA.SecondtipsPath
    else
      tipsPath = furSkinCA.tipsPath
    end
    View.Group_Show.Img_Icon:SetSprite(tipsPath)
    local size = furCA.x .. "\195\151" .. furCA.z .. "\195\151" .. furCA.y
    View.Group_Show.Txt_Area:SetText(size)
    DataModel.furnitureAttrList = {}
    local addedTable = {}
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    for k, v in pairs(homeConfig.furnitureAttrList) do
      local param = furCA[v.field]
      if 0 < param then
        addedTable[k] = 0
        local t = {}
        t.attrName = v.attrName
        t.param = param
        t.iconPath = v.iconPath
        table.insert(DataModel.furnitureAttrList, t)
      end
    end
    local num = #DataModel.furnitureAttrList
    if num < 4 then
      for k, v in pairs(homeConfig.furnitureAttrList) do
        if addedTable[k] == nil then
          addedTable[k] = 0
          local t = {}
          t.attrName = v.attrName
          t.param = 0
          t.iconPath = v.iconPath
          table.insert(DataModel.furnitureAttrList, t)
          num = num + 1
          if 4 <= num then
            break
          end
        end
      end
    end
    View.Group_Show.StaticGrid_Attr.grid.self:RefreshAllElement()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
