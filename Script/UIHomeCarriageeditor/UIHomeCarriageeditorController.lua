local View = require("UIHomeCarriageeditor/UIHomeCarriageeditorView")
local DataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
local Controller = {}

function Controller:Init()
  DataModel.InitData()
  Controller:RefreshResources()
  Controller:SelectTag(DataModel.CurrTag)
end

function Controller:SelectTag(idx)
  if DataModel.curSelectIdx == idx then
    return
  end
  local editSelected = idx == DataModel.TagType.Edit
  local weaponSelected = idx == DataModel.TagType.Weapon
  local fixSelected = idx == DataModel.TagType.Fix
  local skinSelected = idx == DataModel.TagType.Skin
  local refitSelected = idx == DataModel.TagType.Refit
  local lastSelectIdx = DataModel.curSelectIdx
  if lastSelectIdx == DataModel.TagType.Skin then
    local skinController = require("UIHomeCarriageeditor/UITrainSkinController")
    skinController:ExitTrainSkin()
  end
  DataModel.curSelectIdx = idx
  View.Btn_editselect.self:SetActive(editSelected)
  View.Btn_fixselect.self:SetActive(fixSelected)
  View.Btn_skinselect.self:SetActive(skinSelected)
  View.Btn_repairselect.self:SetActive(refitSelected)
  View.Btn_weaponselect.self:SetActive(weaponSelected)
  local detailDo = function()
    View.Group_Edit.self:SetActive(editSelected)
    View.Group_Fix.self:SetActive(fixSelected)
    View.Group_TrainRefit.self:SetActive(refitSelected)
    View.Group_TrainWeapon.self:SetActive(weaponSelected)
    View.Group_TrainSkin.self:SetActive(skinSelected)
    View.Img_Basepicture:SetActive(false)
    View.Img_Glass:SetActive(false)
    View.Img_Black:SetActive(false)
    View.Img_HavemoneyBg:SetActive(false)
    View.Img_HaveelectricBg:SetActive(false)
    if editSelected or weaponSelected then
      Controller:RemoveCurTimeLine()
    end
    if editSelected then
      UIManager:LoadSplitPrefab(View, "UI/Trainfactory/HomeCarriageeditor", "Group_Edit")
      local EditController = require("UIHomeCarriageeditor/UIEditController")
      EditController:InitView(lastSelectIdx == 0)
    elseif weaponSelected then
      UIManager:LoadSplitPrefab(View, "UI/Trainfactory/HomeCarriageeditor", "Group_TrainWeapon")
      local weaponController = require("UIHomeCarriageeditor/UIWeaponController")
      weaponController:InitView()
    elseif fixSelected then
      UIManager:LoadSplitPrefab(View, "UI/Trainfactory/HomeCarriageeditor", "Group_Fix")
      local FixController = require("UIHomeCarriageeditor/UIFixController")
      FixController:InitView(DataModel.ChildTag)
    elseif refitSelected then
      UIManager:LoadSplitPrefab(View, "UI/Trainfactory/HomeCarriageeditor", "Group_TrainRefit")
      local RefitController = require("UIHomeCarriageeditor/UIRefitController")
      RefitController:InitView()
    elseif skinSelected then
      UIManager:LoadSplitPrefab(View, "UI/Trainfactory/HomeCarriageeditor", "Group_TrainSkin")
      local skinController = require("UIHomeCarriageeditor/UITrainSkinController")
      skinController:InitView()
    end
  end
  local curPlayAnim = ""
  local curView = ""
  if lastSelectIdx == DataModel.TagType.Edit then
    curPlayAnim = "edit_out"
    curView = View.Group_Edit.self
  elseif lastSelectIdx == DataModel.TagType.Fix then
    curPlayAnim = "fix_out"
    curView = View.Group_Fix.self
  elseif lastSelectIdx == DataModel.TagType.Refit then
    curPlayAnim = "TrainMaintenance_out"
    curView = View.Group_TrainRefit.self
  elseif lastSelectIdx == DataModel.TagType.Skin then
    curPlayAnim = "Train_out"
    curView = View.Group_TrainSkin.self
  elseif lastSelectIdx == DataModel.TagType.Weapon then
    curPlayAnim = "TrainWeapon_out"
    curView = View.Group_TrainWeapon.self
  end
  if curPlayAnim == "" or curView.IsActive == false then
    detailDo()
  else
    View.self:SelectPlayAnim(curView, curPlayAnim, function()
      detailDo()
    end)
  end
end

function Controller:RefreshResources()
  View.Img_HavemoneyBg:SetActive(true)
  View.Img_HavemoneyBg.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
end

function Controller:MoveTrain()
  if not DataModel.isTrainMoved then
    HomeCoachFactoryManager:MoveTrain(9920, 10000, 1)
    DataModel.isTrainMoved = true
  end
end

function Controller:HideTrain()
  HomeCoachFactoryManager:MoveTrain(1000, 1000, 0)
end

function Controller:ShowCoachTip(info, btn, xChangePos)
  if xChangePos == nil then
    xChangePos = 0
  end
  View.Btn_CloseTips:SetActive(true)
  View.Group_Tips.self:SetActive(true)
  View.Group_Tips.Img_Base.Txt_Name:SetText(info.name)
  View.Group_Tips.Img_Base.Group_Speed.Txt_Num:SetText(math.floor(info.speedEffect + 0.5) .. "km/h")
  View.Group_Tips.Img_Base.Group_Passenger.Txt_Num:SetText(info.passengerCapacity)
  View.Group_Tips.Img_Base.Group_Goods.Txt_Num:SetText(math.floor(info.space + 0.5))
  View.Group_Tips.Img_Base.Group_Durable.Txt_Num:SetText(info.carriagedurability)
  View.Group_Tips.Img_Base.Group_Weapon.Txt_Num:SetText(info.weaponNum)
  View.Group_Tips.Img_Base.Group_Armor.Txt_Num:SetText(info.armor)
  View.Group_Tips:SetPosition(btn.transform.position)
  local curPos = View.Group_Tips.self.Rect.anchoredPosition
  local rightBound = 370
  local toX = curPos.x + xChangePos
  local delta = toX + rightBound - Screen.width * 0.5
  if 0 <= delta then
    View.Group_Tips.Img_Arrow:SetLocalScale(Vector3(-1, 1, 1))
    View.Group_Tips.Img_Arrow:SetAnchoredPosition(Vector2(563, 0))
    toX = toX - 370
  else
    View.Group_Tips.Img_Arrow:SetLocalScale(Vector3(1, 1, 1))
    View.Group_Tips.Img_Arrow:SetAnchoredPosition(Vector2(181, 0))
  end
  if curPos.x ~= toX then
    View.Group_Tips:SetAnchoredPosition(Vector2(toX, curPos.y))
  end
end

function Controller:RemoveCurTimeLine()
  if DataModel.TimeLineId > 0 then
    if DataModel.TimeLineSound then
      DataModel.TimeLineSound:Recycle()
      DataModel.TimeLineSound = nil
    end
    local timeLine = require("Common/TimeLine")
    timeLine.RemoveTimeLine(DataModel.TimeLineId)
    DataModel.TimeLineId = 0
  end
end

function Controller:OpenRubbishView()
  local ufid = ""
  for k, v in pairs(PlayerData:GetFurniture()) do
    local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furCA.functionType == 12600474 then
      ufid = k
    end
  end
  if ufid ~= "" then
    UIManager:Open("UI/HomeRubbish/HomeRubbish", Json.encode({ufid = ufid, noChangeSkin = true}))
  end
end

function Controller:RemoveCurScene()
  if DataModel.NeedRemoveScene then
    if MainManager.bgSceneName == "Home" then
      HomeTrainManager.trainTran = nil
    end
    MainManager:SetTrainViewFilter(0, true)
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    CBus:RemoveSceneAsync(homeConfig.TrainFactoryScenes)
    MainManager.curSceneName = ""
    MainManager:SetTrainViewFilter(30, false)
  end
end

return Controller
