local View = require("UIBuyCoachSkin/UIBuyCoachSkinView")
local DataModel = require("UIBuyCoachSkin/UIBuyCoachSkinDataModel")
local BtnItem = require("Common/BtnItem")
local Controller = {}

function Controller:Init()
  local skinCA = PlayerData:GetFactoryData(DataModel.initParamsData.skinId)
  View.Group_Detail.Img_DisplayBg.Img_CarriagePicture:SetSprite(skinCA.thumbnail)
  View.Group_Detail.Txt_SkinName:SetText(skinCA.name)
  View.Group_Detail.Txt_Text:SetText(skinCA.skinDetail)
  DataModel.CostMaterials = skinCA.produceMaterialList
  View.Group_Detail.Group_Material.ScrollGrid_Dikuang.grid.self:SetDataCount(#DataModel.CostMaterials)
  View.Group_Detail.Group_Material.ScrollGrid_Dikuang.grid.self:RefreshAllElement()
  DataModel.isEnough = true
  for i, costInfo in ipairs(DataModel.CostMaterials) do
    if costInfo.num > PlayerData:GetGoodsById(costInfo.id).num then
      DataModel.isEnough = false
      break
    end
  end
end

function Controller:RefreshElement(element, elementIndex)
  local info = DataModel.CostMaterials[elementIndex]
  BtnItem:SetItem(element.Img_Dikuang.Group_Item, {
    id = info.id
  })
  element.Img_Dikuang.Group_Item.Btn_Item:SetClickParam(info.id)
  local haveNum = PlayerData:GetGoodsById(info.id).num
  element.Img_Dikuang.Group_Cost.Txt_Have:SetText(PlayerData:TransitionNum(haveNum))
  element.Img_Dikuang.Group_Cost.Txt_Need:SetText(PlayerData:TransitionNum(info.num))
  if haveNum < info.num then
    element.Img_Dikuang.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
  else
    element.Img_Dikuang.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
  end
end

function Controller:ClickElement(str)
  local id = tonumber(str)
  CommonTips.OpenItem({itemId = id})
end

function Controller:ClickConfirm()
  if not DataModel.isEnough then
    CommonTips.OpenTips(80601046)
    return
  end
  local costItem = {}
  for i, costInfo in ipairs(DataModel.CostMaterials) do
    costItem[costInfo.id] = costInfo.num
  end
  Net:SendProto("home.unlock_skin", function(json)
    PlayerData:RefreshUseItems(costItem)
    local serverCoach = PlayerData:GetHomeInfo().coach_store[DataModel.initParamsData.coachUid]
    serverCoach.skin = tostring(DataModel.initParamsData.skinId)
    table.insert(serverCoach.skin_house, tostring(DataModel.initParamsData.skinId))
    Controller:GoBack(function()
      View.self:Confirm()
    end)
  end, DataModel.initParamsData.skinId, DataModel.initParamsData.coachUid)
end

function Controller:ClickCancel()
  Controller:GoBack()
end

function Controller:GoBack(cb)
  View.self:PlayAnim("BuyCoachSkin_out", function()
    UIManager:GoBack(false)
    if cb then
      cb()
    end
  end)
end

return Controller
