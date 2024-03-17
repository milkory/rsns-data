local View = require("UIHomeLive/UIHomeLiveView")
local DataModel = require("UIHomeLive/UIHomeLiveDataModel")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  Controller:RefreshBedInfo()
  Controller:RefreshRightTopShow()
end

function Controller:RefreshBedInfo()
  local bedCount = #DataModel.curCharacter
  for i = 1, bedCount do
    View["Group_Bed" .. i].self:SetActive(true)
    local id = DataModel.curCharacter[i]
    if id ~= "" then
      local unitCA = PlayerData:GetFactoryData(id, "UnitFactory")
      local unitViewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
      local profilePhotoCA = PlayerData:GetFactoryData(unitViewCA.profilePhotoID, "ProfilePhotoFactory")
      View["Group_Bed" .. i].Btn_Character.Img_Character:SetSprite(profilePhotoCA.imagePath)
      View["Group_Bed" .. i].Img_1.Txt_Name:SetText(unitCA.name)
    else
      View["Group_Bed" .. i].Img_1.Txt_Name:SetText("")
    end
    View["Group_Bed" .. i].Btn_Empty.self:SetActive(id == "")
    View["Group_Bed" .. i].Btn_Character.self:SetActive(id ~= "")
    View["Group_Bed" .. i].Btn_Empty.self:SetClickParam(i)
    View["Group_Bed" .. i].Btn_Character.self:SetClickParam(i)
  end
  for i = bedCount + 1, 2 do
    View["Group_Bed" .. i].self:SetActive(false)
  end
end

function Controller:RefreshRightTopShow()
  View.Group_1.Txt_Home:SetText(DataModel.allCoachCharacterCurNum .. "/" .. DataModel.allCoachCharacterMaxNum)
end

function Controller:ClickBedBtn(idx)
  local id = DataModel.curCharacter[idx]
  if id == "" and DataModel.allCoachCharacterCurNum == DataModel.allCoachCharacterMaxNum then
    CommonTips.OpenTips(80600360)
    return
  end
  DataModel.curSelectBedIdx = idx
  DataModel.GetAllCanCheckInCharacter(idx)
  View.Group_replace.self:SetActive(true)
  Controller:RefreshRoleLH()
  View.Group_replace.ScrollGrid_TH.grid.self:SetDataCount(#DataModel.allCanCheckInCharacter)
  View.Group_replace.ScrollGrid_TH.grid.self:RefreshAllElement()
end

function Controller:RefreshRoleLH()
  local isSelect = DataModel.curSelectCharacterIdx ~= 0
  View.Group_replace.Txt_Empty:SetActive(not isSelect)
  View.Group_replace.Img_LH:SetActive(isSelect)
  if isSelect then
    local data = DataModel.allCanCheckInCharacter[DataModel.curSelectCharacterIdx]
    View.Group_replace.Img_LH:SetSprite(data.resUrl)
  end
end

function Controller:RefreshElement(element, index)
  local data = DataModel.allCanCheckInCharacter[index]
  element.Group_InRoom.self:SetActive(data.checkInInfo ~= nil)
  if data.checkInInfo ~= nil then
    local serverData = PlayerData.ServerData.user_home_info.furniture[data.checkInInfo.ufid]
    local coachInfo, idx
    for k, v in pairs(PlayerData.ServerData.user_home_info.coach) do
      if v.u_cid == serverData.u_cid then
        coachInfo = v
        idx = k
        break
      end
    end
    if idx ~= nil then
      element.Group_InRoom.Img_2.Txt_XH:SetText("0" .. idx)
      local coachCA = PlayerData:GetFactoryData(coachInfo.id, "HomeCoachFactory")
      element.Group_InRoom.Img_2.Txt_FJ:SetText("0" .. coachCA.name)
    end
  end
  element.Img_Bottom:SetSprite(UIConfig.CharacterBottom[data.qualityInt])
  element.Group_Character.Img_Character:SetSprite(data.roleListResUrl)
  element.Img_Decorate:SetSprite(UIConfig.CharacterDecorate[data.qualityInt])
  element.Txt_Name:SetText(data.name)
  element.Txt_LVNum:SetText(data.lv)
  element.Img_Rarity:SetSprite(UIConfig.TipConfig[data.qualityInt + 1])
  element.Img_Selected:SetActive(index == DataModel.curSelectCharacterIdx)
  element.Group_Awake.Img_Awake:SetSprite(UIConfig.AwakeCommon[data.resonance_lv + 1])
  DataModel.curRefreshBreakLv = data.awake_lv
  element.Group_Break.StaticGrid_BK.grid.self:RefreshAllElement()
  element.Btn_Item:SetClickParam(index)
end

return Controller
