local View = require("UIHomeCarriageeditor/UIHomeCarriageeditorView")
local DataModel = require("UIHomeCarriageeditor/UIWeaponDataModel")
local MainDataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
local MainController = require("UIHomeCarriageeditor/UIHomeCarriageeditorController")
local BtnItem = require("Common/BtnItem")
local Controller = {}

function Controller:InitView()
  DataModel.InitCoachInfo()
  Controller:ShowTopElectric()
  View.Img_Glass:SetActive(true)
  View.Img_Black:SetActive(true)
  View.Img_Basepicture:SetActive(true)
  View.Group_TrainWeapon.self:SetActive(true)
  View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.Group_Name.Txt_Number:SetText("01")
  View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.Group_Name.Btn_Name.self:SetClickParam(0)
  View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.Group_Name.Btn_Name.self:SetActive(true)
  View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.Group_Name.Btn_Name.Img_Name:SetActive(false)
  View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.Group_Name.Btn_Name.Img_Tips:SetActive(true)
  View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.Btn_Locomotivehead:SetSprite(DataModel.coachHeadInfo.thumbnail)
  View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.Group_Name.Txt_Name:SetText(DataModel.coachHeadInfo.name)
  Controller:RefreshCoachHeadWeaponShow()
  Controller:RefreshStaticGridTrain(true)
  View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.self:SetAnchoredPositionX(0)
  View.Group_TrainWeapon.Img_AccessoryBg.StaticGrid_Accessory.grid.self:RefreshAllElement()
  View.Group_TrainWeapon.Img_PendantBg.StaticGrid_Accessory.grid.self:RefreshAllElement()
end

function Controller:ShowCoachDetailPanel(btn, str)
  local idx = tonumber(str)
  local info
  if idx == 0 then
    info = DataModel.coachHeadInfo
  else
    info = DataModel.coachInfo[idx]
  end
  MainController:ShowCoachTip(info, btn, 122)
end

function Controller:RefreshCoachHeadWeaponShow()
  local coachCA = PlayerData:GetFactoryData(DataModel.coachHeadInfo.id, "HomeCoachFactory")
  for k, v in pairs(View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.Btn_Locomotivehead) do
    if k ~= "self" then
      v:SetActive(false)
    end
  end
  for k, v in pairs(coachCA.weaponTypeList) do
    local element = View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.Btn_Locomotivehead["Btn_Add" .. k]
    element.self:SetActive(true)
    element.Group_Item.Btn_Item:SetActive(false)
    local uid = DataModel.coachHeadInfo.battery[k]
    if uid and uid ~= "" then
      local id = tonumber(PlayerData:GetBattery()[uid].id)
      element.Group_Item:SetActive(true)
      BtnItem:SetItem(element.Group_Item, {id = id})
    else
      element.Group_Item:SetActive(false)
    end
  end
end

function Controller:RefreshStaticGridTrain(reCalcCount)
  if reCalcCount then
    local width = 3336
    local coachCount = #DataModel.coachInfo
    local newWidth = (coachCount + 1) * 420 + coachCount * 20 + 300
    if width > newWidth then
      newWidth = width
    end
    View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.self:SetWidth(newWidth)
  end
  View.Group_TrainWeapon.ScrollView_Train.Viewport.Content.StaticGrid_Train.grid.self:RefreshAllElement()
end

function Controller:RefreshCoachElement(element, elementIndex)
  local info = DataModel.coachInfo[elementIndex]
  local isHave = info ~= nil
  if isHave then
    element.self:SetActive(true)
    element.Group_Name.Txt_Number:SetText(string.format("%02d", elementIndex + 1))
    element.Group_Name.Btn_Name.self:SetClickParam(elementIndex)
    element.Group_Name.Txt_Name:SetText(info.name)
    element.Group_Name.Txt_Name:SetActive(true)
    element.Group_Box.Btn_Train.Img_Type:SetSprite(info.thumbnail)
    element.Group_Box.Btn_Train:SetClickParam(elementIndex)
    local isCanWeapon = #info.weaponTypeList > 0
    element.Group_Box.Btn_Add.self:SetActive(isCanWeapon)
    if isCanWeapon then
      element.Group_Box.Btn_Add.Group_Item.Btn_Item:SetActive(false)
      local uid = info.battery[1]
      if uid and uid ~= "" then
        local id = tonumber(PlayerData:GetBattery()[uid].id)
        element.Group_Box.Btn_Add.Group_Item:SetActive(true)
        BtnItem:SetItem(element.Group_Box.Btn_Add.Group_Item, {id = id})
      else
        element.Group_Box.Btn_Add.Group_Item:SetActive(false)
      end
    end
    element.Group_Box.Btn_Add:SetClickParam(elementIndex)
  else
    element.self:SetActive(false)
  end
end

function Controller:RefreshAccessoryElement(type, element, elementIndex)
  local infos
  if type == DataModel.OperatorType.Parts then
    infos = DataModel.partsInfo
  elseif type == DataModel.OperatorType.Pendant then
    infos = DataModel.pendantInfo
  end
  local info = infos[elementIndex]
  local isHave = info ~= nil
  if type == DataModel.OperatorType.Pendant then
    local electric_lv = PlayerData:GetHomeInfo().electric_lv
    local needLv = info.needElectricLv
    isHave = electric_lv >= needLv
  end
  element.Group_Have.self:SetActive(isHave)
  element.Group_Have.Btn_Zhaozi:SetClickParam(elementIndex)
  element.Group_Empty.self:SetActive(not isHave)
  local typeWeapon
  if isHave then
    typeWeapon = info.typeWeapon
    if info and info.id and info.id ~= "" then
      element.Group_Have.Group_Item:SetActive(true)
      element.Group_Have.Group_Item.Btn_Item:SetActive(false)
      BtnItem:SetItem(element.Group_Have.Group_Item, {
        id = info.id
      })
    else
      element.Group_Have.Group_Item:SetActive(false)
    end
  else
    typeWeapon = infos[1].typeWeapon
    element.Group_Empty.Btn_Empty:SetClickParam(elementIndex)
  end
  local tagCA = PlayerData:GetFactoryData(typeWeapon, "TagFactory")
  element.Txt_Name:SetText(tagCA.tagName)
end

function Controller:ClickWeapon(type, weaponIdx, coachIdx)
  local cb
  local t = {}
  t.type = type
  t.weaponIdx = weaponIdx
  if type == DataModel.OperatorType.Weapon then
    local info
    if coachIdx == 0 then
      info = DataModel.coachHeadInfo
    else
      info = DataModel.coachInfo[coachIdx]
    end
    t.coachId = info.id
    t.coachUid = info.uid
    t.coachIdx = coachIdx
  elseif type == DataModel.OperatorType.Parts then
  elseif type == DataModel.OperatorType.Pendant then
    t.coachUid = DataModel.coachHeadInfo.uid
  end
  
  function cb()
    DataModel.InitCoachWeaponInfo(true)
    Controller:RefreshCoachHeadWeaponShow()
    Controller:RefreshStaticGridTrain()
    local length = #PlayerData:GetHomeInfo().coach
    for i = 0, length - 1 do
      HomeTrainManager.trains[i]:ReloadWeapon(-1)
    end
    DataModel.InitPartsInfo()
    View.Group_TrainWeapon.Img_AccessoryBg.StaticGrid_Accessory.grid.self:RefreshAllElement()
    DataModel.InitPendantInfo()
    View.Group_TrainWeapon.Img_PendantBg.StaticGrid_Accessory.grid.self:RefreshAllElement()
    Controller:ShowTopElectric()
  end
  
  UIManager:Open("UI/Trainfactory/CoachWeaponSelect", Json.encode(t), cb)
end

function Controller:ShowTopElectric()
  View.Img_HaveelectricBg:SetActive(true)
  View.Img_HaveelectricBg.Txt_Num:SetText(PlayerData:GetHomeInfo().electric_used .. "/" .. PlayerData.GetMaxElectric())
end

return Controller
