local View = require("UIPickGender/UIPickGenderView")
local DataModel = require("UIPickGender/UIPickGenderDataModel")
local Controller = {}
local isFirstClick = true
local isOpenInputNameView = false
local characterLimit = 18
local OpenInputNameView = function(isMale)
  DataModel.genderInt = 0
  if isMale then
    DataModel.genderInt = 1
  end
  if isOpenInputNameView then
    return
  end
  View.self:PlayAnim("Window", function()
  end)
  View.Group_PickGender:SetActive(false)
  isFirstClick = false
  isOpenInputNameView = true
  View.Group_InputName:SetActive(true)
  View.Group_InputName.Btn_Confirm:SetActive(false)
  View.Group_InputName.InputField_Name.self:SetText("")
  View.Group_InputName.InputField_Name.self:SetCharacterLimit(characterLimit)
  if next(DataModel.FirstName) == nil then
    local data = GetCA(99900011)
    DataModel.FirstName = {}
    DataModel.LastName = {}
    for k, v in pairs(data.firstNameList) do
      DataModel.FirstName[k] = v.firstName
    end
    for k, v in pairs(data.secondNameList) do
      DataModel.LastName[k] = v.secondName
    end
  end
  View.Group_InputName.InputField_Name.self:OnValueChange(function()
    View.Group_InputName.Btn_Confirm:SetActive(true)
    View.self:PlayAnim("Confirm", function()
    end)
    View.Group_InputName.InputField_Name.self:RemoveAllListeners()
  end)
end
local isModifying
local ModifyGender = function()
  Net:SendProto("main.set_gender", function(json)
    SdkReporter.TrackCreateRole()
  end, DataModel.genderInt)
end

function Controller.ModifyName()
  if View.Group_InputName.InputField_Name.self:GetText() == "" then
    CommonTips.OpenTips(GetText(80600225))
    return
  end
  local result = View.Group_InputName.InputField_Name.self:CheckText(characterLimit)
  if result == 0 then
    if isModifying then
      return
    end
    isModifying = true
    Net:SendProto("main.set_rolename", function(json)
      SdkHelper.CreateRole(PlayerData:GetUserInfo().uid, LoginGV.GetUsername())
      ModifyGender()
      PlayerData:GetUserInfo().rename_cnt = PlayerData:GetUserInfo().rename_cnt + 1
    end, View.Group_InputName.InputField_Name.self:GetText(), function()
      isModifying = false
    end)
  elseif result == 1 then
    CommonTips.OpenTips(GetText(80600088))
  elseif result == 2 or result == 3 then
    CommonTips.OpenTips(GetText(80600087))
  end
end

function Controller.RandomName()
  local firstRandom = math.random(1, #DataModel.FirstName)
  local lastRandom = math.random(1, #DataModel.LastName)
  View.Group_InputName.InputField_Name.self:SetText(DataModel.FirstName[firstRandom] .. DataModel.LastName[lastRandom])
end

local ClickPlayVoice = function(isMale)
  if DataModel.sound then
    DataModel.sound:Stop()
  end
  local cfg = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local voice
  if isFirstClick then
    voice = isMale and cfg.maleSwitchVoice or cfg.femaleSwitchVoice
  else
    if DataModel.genderInt == 0 and isMale then
      voice = cfg.maleSwitchVoice
    end
    if DataModel.genderInt == 1 and not isMale then
      voice = cfg.femaleSwitchVoice
    end
  end
  if voice then
    DataModel.sound = SoundManager:CreateSound(voice)
    DataModel.sound:Play()
  end
end

function Controller.ClickMale()
  if isFirstClick then
    View.SpineAnimation_PickGender:SetAction("state02_01", false, true)
    View.SpineAnimation_PickGender:SetAction("state02_02", true, false)
  else
    View.SpineAnimation_PickGender:SetAction("state02_02", true, true)
  end
  ClickPlayVoice(true)
  OpenInputNameView(true)
end

function Controller.ClickFemale()
  if isFirstClick then
    View.SpineAnimation_PickGender:SetAction("state03_01", false, true)
    View.SpineAnimation_PickGender:SetAction("state03_02", true, false)
  else
    View.SpineAnimation_PickGender:SetAction("state03_02", true, true)
  end
  ClickPlayVoice(false)
  OpenInputNameView(false)
end

local OpenPickView = function()
  View.Video_Ocean:SetActive(true)
  View.Video_Ocean:Play(DataModel.videoOcean)
  View.Img_WindowBG:SetActive(true)
  View.Group_Cloud:SetActive(true)
  View.Img_WhiteLine:SetActive(true)
  View.SpineAnimation_PickGender:SetActive(true)
  View.Group_PickGender:SetActive(true)
  View.Img_White:SetActive(true)
  View.Img_Mask:SetActive(true)
  View.Img_BG:SetActive(true)
  local sound = SoundManager:CreateSound(30000866)
  if sound ~= nil then
    sound:Play()
  end
  View.SpineAnimation_PickGender:SetData(DataModel.spinePick, "state01")
  View.self:PlayAnim("White", function()
    View.Img_White:SetActive(false)
    View.Btn_Male:SetActive(true)
    View.Btn_Female:SetActive(true)
    View.self:PlayAnim("Tip", function()
    end)
  end)
end

function Controller.Init()
  LoadingManager:CloseLoading()
  isFirstClick = true
  isOpenInputNameView = false
  local data = GetCA(99900001)
  DataModel.videoOcean = data.pickGenderBG
  DataModel.videoIntro = data.pickGenderIntro
  DataModel.spinePick = data.pickGenderSpine
  isModifying = false
  DataModel.isDelay = true
  DataModel.DelayTimer = 10
  View.Video_Ocean:SetActive(false)
  View.Img_WindowBG:SetActive(false)
  View.Group_Cloud:SetActive(false)
  View.Img_WhiteLine:SetActive(false)
  View.SpineAnimation_PickGender:SetActive(false)
  View.Group_PickGender:SetActive(false)
  View.Img_White:SetActive(false)
  View.Btn_Male:SetActive(false)
  View.Btn_Female:SetActive(false)
  View.Group_InputName:SetActive(false)
  View.Img_Mask:SetActive(false)
  View.Img_BG:SetActive(false)
  View.Btn_Male:SetActive(false)
  View.Btn_Female:SetActive(false)
  View.Video_Intro:SetActive(true)
  View.Video_Intro:Play(DataModel.videoIntro, false, false, true, function()
    OpenPickView()
  end)
end

return Controller
