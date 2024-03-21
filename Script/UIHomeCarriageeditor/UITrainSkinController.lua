local View = require("UIHomeCarriageeditor/UIHomeCarriageeditorView")
local DataModel = require("UIHomeCarriageeditor/UITrainSkinDataModel")
local MainDataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
local MainController = require("UIHomeCarriageeditor/UIHomeCarriageeditorController")
local Controller = {}

function Controller:InitView()
  MainDataModel.isTrainMoved = false
  TrainCameraManager:SetCameraDragEnable(4, false)
  MainController:HideTrain()
  DataModel.InitTrainSkinData()
  View.Group_TrainSkin.Group_QuickJump.ScrollGrid_QuickJump.grid.self:SetDataCount(#DataModel.coachData)
  View.Group_TrainSkin.Group_QuickJump.ScrollGrid_QuickJump.grid.self:MoveToTop()
  Controller:SelectCoach(1, true)
end

function Controller:ExitTrainSkin()
  if DataModel.lastShowSkinIdx > 0 then
    HomeCoachFactoryManager:RemoveTempSkin(DataModel.lastShowSkinIdx)
  end
  DataModel.lastShowSkinIdx = 0
  Controller:ReloadTrainSkin()
  TrainCameraManager:SetCameraDragEnable(4, true)
end

function Controller:ReloadTrainSkin()
  local isChangeSkin = false
  for i, uid in ipairs(PlayerData:GetHomeInfo().coach_template) do
    local serverCoachInfo = PlayerData:GetHomeInfo().coach_store[uid]
    if serverCoachInfo.skin ~= DataModel.cacheUsedSkin[i] then
      isChangeSkin = true
      break
    end
  end
  if isChangeSkin then
    local homeController = require("UIMainUI/UIMainUIController")
    homeController.InitTrain(false)
    homeController:InitCheDengLight()
    homeController:InitTrainEffect()
  end
end

function Controller:RefreshCoachElement(element, elementIndex)
  local isSelected = DataModel.curSelectCoachIdx == elementIndex
  element.Group_Carriage.Btn_Off:SetActive(not isSelected)
  element.Group_Carriage.Btn_On:SetActive(isSelected)
  if isSelected then
    element.Group_Carriage.Btn_On:SetClickParam(elementIndex)
    element.Group_Carriage.Btn_On.Txt_Num:SetText(string.format("%02d", elementIndex))
  else
    element.Group_Carriage.Btn_Off:SetClickParam(elementIndex)
    element.Group_Carriage.Btn_Off.Txt_Num:SetText(string.format("%02d", elementIndex))
  end
end

function Controller:ClickCoachElement(str)
  local idx = tonumber(str)
  Controller:SelectCoach(idx)
end

function Controller:SelectCoach(idx, force)
  if DataModel.curSelectCoachIdx == idx and not force then
    return
  end
  DataModel.curSelectCoachIdx = idx
  local info = DataModel.coachData[idx]
  View.Group_TrainSkin.Group_Preview.Img_PreviewBg.Txt_Preview:SetText(string.format(GetText(80602061), info.name))
  local coachShowTxt = string.format("%02d", idx)
  View.Group_TrainSkin.Group_Preview.Txt_Num:SetText(coachShowTxt)
  View.Group_TrainSkin.Group_SkinIcon.Txt_CarriageNum:SetText(coachShowTxt)
  View.Group_TrainSkin.Group_QuickJump.ScrollGrid_QuickJump.grid.self:RefreshAllElement()
  DataModel.curCoachData = info
  DataModel.tempCo = View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:StartC(LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:SetDataCount(#DataModel.curCoachData.skins)
    Controller:SelectSkin(1, true)
    View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:StopC(DataModel.tempCo)
  end))
end

function Controller:RefreshSkinElement(element, elementIndex)
  local info = DataModel.curCoachData.skins[elementIndex]
  local skinCA = PlayerData:GetFactoryData(info.id)
  element.Group_CarriageSkin.Img_Bg.Txt_Name:SetText(skinCA.name)
  element.Group_CarriageSkin.Img_mengban.Img_Skin:SetSprite(skinCA.skinDisplay)
  element.Group_CarriageSkin.Img_UsingSkin:SetActive(info.used)
  element.Group_CarriageSkin.Img_Shadow:SetActive(not info.isUnlock)
  element.Group_CarriageSkin.Img_Select:SetActive(DataModel.curSelectSkinIdx == elementIndex)
  element.Group_CarriageSkin.Btn_Button:SetClickParam(elementIndex)
end

function Controller:ClickSkinElement(str)
  local idx = tonumber(str)
  Controller:SelectSkin(idx)
end

function Controller:SelectSkin(idx, force)
  if DataModel.curSelectSkinIdx == idx and not force then
    return
  end
  DataModel.curSelectSkinIdx = idx
  local coachInfo = DataModel.coachData[DataModel.curSelectCoachIdx]
  local skinInfo = coachInfo.skins[idx]
  View.Group_TrainSkin.Btn_Use:SetActive(skinInfo.isUnlock and not skinInfo.used)
  View.Group_TrainSkin.Btn_Unlock:SetActive(not skinInfo.isUnlock)
  View.Group_TrainSkin.Group_SkinIcon.Img_Collected.Txt_Collected:SetText(string.format(GetText(80602062), coachInfo.unlockCount, #coachInfo.skins))
  View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:RefreshAllElement()
  if DataModel.lastShowSkinIdx > 0 then
    HomeCoachFactoryManager:RemoveTempSkin(DataModel.lastShowSkinIdx)
  end
  local skinId = skinInfo.id
  DataModel.lastShowSkinIdx = skinId
  local coachSkin = HomeCoachFactoryManager:GenerateTempSkin(skinId)
  local camera = TrainCameraManager:GetCamera(4)
  if camera == nil or camera:IsNull() then
    coachSkin:SetPosition(Vector3(10000, 0, 0))
  end
end

function Controller:UseSkin()
  local skinId = DataModel.curCoachData.skins[DataModel.curSelectSkinIdx].id
  Net:SendProto("home.update_skin", function(json)
    local serverSkinInfo = PlayerData:GetHomeInfo().coach_store[DataModel.curCoachData.uid]
    serverSkinInfo.skin = tostring(skinId)
    local skinInfo = DataModel.curCoachData.skins[DataModel.curSelectSkinIdx]
    DataModel.curCoachData.skins[1].used = false
    skinInfo.used = true
    DataModel.SortSkinTable(DataModel.curCoachData.skins)
    DataModel.curSelectSkinIdx = 1
    View.Group_TrainSkin.Btn_Use:SetActive(false)
    View.Group_TrainSkin.Btn_Unlock:SetActive(false)
    View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:RefreshAllElement()
    CommonTips.OpenTips(80602063)
  end, skinId, DataModel.curCoachData.uid)
end

function Controller:UnlockSkin()
  local t = {}
  local coachInfo = DataModel.coachData[DataModel.curSelectCoachIdx]
  local skinInfo = DataModel.curCoachData.skins[DataModel.curSelectSkinIdx]
  t.coachId = coachInfo.id
  t.coachUid = coachInfo.uid
  t.skinId = skinInfo.id
  UIManager:Open("UI/Trainfactory/BuyCoachSkin", Json.encode(t), function()
    skinInfo.isUnlock = true
    DataModel.curCoachData.unlockCount = DataModel.curCoachData.unlockCount + 1
    local skinCA = PlayerData:GetFactoryData(skinInfo.id)
    CommonTips.OnPrompt(string.format(GetText(80602064), skinCA.name), nil, nil, function()
      Controller:UseSkin()
    end, function()
      DataModel.SortSkinTable(DataModel.curCoachData.skins)
      for i, v in ipairs(DataModel.curCoachData.skins) do
        if v.id == skinInfo.id then
          DataModel.curSelectSkinIdx = i
          break
        end
      end
      View.Group_TrainSkin.Btn_Use:SetActive(true)
      View.Group_TrainSkin.Btn_Unlock:SetActive(false)
      View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:RefreshAllElement()
    end)
  end)
end

return Controller
