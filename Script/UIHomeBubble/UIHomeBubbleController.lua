local View = require("UIHomeBubble/UIHomeBubbleView")
local DataModel = require("UIHomeBubble/UIHomeBubbleDataModel")
local Controller = {}

function Controller:Init()
  local furCA = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
  local yinuooutputShow = furCA.yinuooutput > 0
  local height = 0
  local innerWasteOut = 0
  View.Group_Panel:SetActive(true)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Title.Group_Name.Txt_Title:SetText(furCA.name)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Title.Group_Name.Txt_Level.Txt_LevelNum:SetText(furCA.Level or 1)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Title.Group_Name.Txt_Level.self:SetActive(0 < furCA.upgrade or furCA.Level > 1)
  height = height + (0 < furCA.comfort and 40 or 0)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute1.self:SetActive(0 < furCA.comfort)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute1.Txt_Scores:SetText(furCA.comfort)
  height = height + (0 < furCA.foodScores and 40 or 0)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute2.self:SetActive(0 < furCA.foodScores)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute2.Txt_Scores:SetText(furCA.foodScores)
  height = height + (0 < furCA.playScores and 40 or 0)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute3.self:SetActive(0 < furCA.playScores)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute3.Txt_Scores:SetText(furCA.playScores)
  height = height + (0 < furCA.plantScores and 40 or 0)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute4.self:SetActive(0 < furCA.plantScores)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute4.Txt_Scores:SetText(furCA.plantScores)
  local petScores = PlayerData.GetFurPetScoreWithAllBuff(DataModel.curFurUfid)
  if DataModel.curFurServerInfo.house then
    for k, v in pairs(DataModel.curFurServerInfo.house.pets) do
      local petInfo = PlayerData:GetHomeInfo().pet[v]
      if petInfo then
        local ca = PlayerData:GetFactoryData(petInfo.id)
        innerWasteOut = innerWasteOut + ca.wasteoutput
      end
    end
  end
  height = height + (0 < petScores and 40 or 0)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute5.self:SetActive(0 < petScores)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute5.Txt_Scores:SetText(petScores)
  local fishScores = PlayerData.GetFurFishScoresWithAllBuff(DataModel.curFurUfid)
  if DataModel.curFurServerInfo.water ~= nil and DataModel.curFurServerInfo.water.fishes ~= nil then
    for k, v in pairs(DataModel.curFurServerInfo.water.fishes) do
      local ca = PlayerData:GetFactoryData(k)
      innerWasteOut = innerWasteOut + ca.fishGarbage * v
    end
  end
  height = height + (0 < fishScores and 40 or 0)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute6.self:SetActive(0 < fishScores)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute6.Txt_Scores:SetText(fishScores)
  local totalMedicalScores = furCA.medicalScores
  if 0 < furCA.medicalScores then
    local furData = PlayerData.ServerData.user_home_info.furniture[DataModel.curFurUfid]
    if furData.roles and furData.roles[1] and furData.roles[1] ~= "" then
      local unitCA = PlayerData:GetFactoryData(furData.roles[1], "UnitFactory")
      totalMedicalScores = totalMedicalScores + unitCA.medicalPoint
    end
  end
  height = height + (0 < furCA.medicalScores and 40 or 0)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute7.self:SetActive(0 < totalMedicalScores)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Attribute7.Txt_Scores:SetText(totalMedicalScores)
  local seatPrice = furCA.seatPrice or 0
  height = height + (0 < seatPrice and 40 or 0)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_SeatPrice.self:SetActive(0 < seatPrice)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_SeatPrice.Txt_Scores:SetText(string.format(GetText(80602069), seatPrice))
  local trustUp = furCA.trustUp or 0
  height = height + (0 < trustUp and 40 or 0)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_TrustUp.self:SetActive(0 < trustUp)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_TrustUp.Txt_Scores:SetText(string.format(GetText(80602068), trustUp))
  local wasteOutput = furCA.wasteoutput
  if DataModel.curFurServerInfo.roles then
    wasteOutput = 0
    for i, v in pairs(DataModel.curFurServerInfo.roles) do
      if v ~= "" then
        local unitCA = PlayerData:GetFactoryData(v, "UnitFactory")
        innerWasteOut = innerWasteOut + unitCA.WasteCoefficient * furCA.wasteoutput
      end
    end
  end
  wasteOutput = wasteOutput + innerWasteOut
  local wasteOutputShow = 0 < wasteOutput
  height = height + (0 < wasteOutput and 40 or 0)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Output1.self:SetActive(0 < wasteOutput)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Output1.Txt_Scores:SetText(string.format(GetText(80600743), wasteOutput))
  height = height + (yinuooutputShow and 40 or 0)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Output2.self:SetActive(yinuooutputShow)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Output2.Txt_Scores:SetText(string.format(GetText(80600744), furCA.yinuooutput))
  if wasteOutputShow or yinuooutputShow then
    height = height + 2
  end
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.Group_Line.self:SetActive(wasteOutputShow or yinuooutputShow)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.self:SetHeight(height)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_Upgrade.self:SetActive(furCA.upgrade ~= nil and 0 < furCA.upgrade)
  Controller:InterfaceShow(furCA)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_CharacterInteractive:SetActive(furCA.movementName and furCA.movementName ~= "")
  if furCA.movementName and furCA.movementName ~= "" then
    if HomeManager:GetFurnitureByUfid(DataModel.curFurUfid).IsUsing then
      if furCA.movementBreakName and furCA.movementBreakName ~= "" then
        View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_CharacterInteractive.Txt_Interactive:SetText(furCA.movementBreakName)
        View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_CharacterInteractive.Img_Icon:SetSprite(furCA.movementBreakIcon)
      end
      View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_CharacterInteractive:SetClickParam(0)
    elseif furCA.movementName and furCA.movementName ~= "" then
      View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_CharacterInteractive.Txt_Interactive:SetText(furCA.movementName)
      View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_CharacterInteractive.Img_Icon:SetSprite(furCA.movementIcon)
      View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_CharacterInteractive:SetClickParam(1)
    end
  end
  Controller:RefreshEmergency(false)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Txt_Des:SetText(furCA.describe)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Txt_Des:SetHeight()
end

function Controller:RefreshEmergency(state)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Working:SetActive(state)
  if not state then
    return
  end
  local furData = PlayerData.ServerData.user_home_info.furniture[DataModel.curFurUfid]
  if furData.roles and furData.roles[1] and furData.roles[1] ~= "" then
    local unitCA = PlayerData:GetFactoryData(furData.roles[1], "UnitFactory")
    local portraitId = PlayerData:GetRoleById(furData.roles[1]).current_skin[1]
    local unitViewCA = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Working.Group_change.Group_Member.Btn_Change.Img_Head.Img_member:SetSprite(unitViewCA.face)
    View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Working.Group_change:SetActive(true)
    View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Working.Group_add:SetActive(false)
    View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Working.Group_change.Img_Point.Group_Contain.Txt_Num:SetText(unitCA.medicalPoint)
  else
    View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Working.Group_change:SetActive(false)
    View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Working.Group_add:SetActive(true)
  end
end

function Controller:InterfaceShow(furCA)
  local interfaceShow = furCA.interfaceUrl ~= nil and furCA.interfaceUrl ~= ""
  View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_Interactive.self:SetActive(interfaceShow)
  if interfaceShow then
    View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_Interactive.Txt_Interactive:SetText(furCA.interfaceName)
    View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_Interactive.Img_Icon:SetSprite(furCA.interfaceIcon)
  else
    local skinId = PosClickHandler.GetFurnitureSkinId(DataModel.curFurUfid)
    local homeSkinCA = PlayerData:GetFactoryData(skinId, "HomeFurnitureSkinFactory")
    local animationStateCount = #homeSkinCA.animationList
    interfaceShow = 0 < animationStateCount
    if homeSkinCA.banswitchAnimation then
      local tradeDataModel = require("UIHome/UIHomeTradeDataModel")
      interfaceShow = interfaceShow and not tradeDataModel.GetInTravel()
    end
    View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_Interactive.self:SetActive(interfaceShow)
    if interfaceShow then
      if DataModel.CurHomeFurniture == nil then
        DataModel.CurHomeFurniture = HomeManager:GetFurnitureByUfid(DataModel.curFurUfid)
      end
      local curState = DataModel.CurHomeFurniture:GetCurAnimState()
      DataModel.ToAnimationState = curState + 1
      if animationStateCount < DataModel.ToAnimationState + 1 then
        DataModel.ToAnimationState = 0
      end
      local animationStateInfo = homeSkinCA.animationList[DataModel.ToAnimationState + 1]
      View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_Interactive.Txt_Interactive:SetText(animationStateInfo.buttonName)
      View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_Interactive.Img_Icon:SetSprite(animationStateInfo.icon)
    end
  end
end

function Controller:SwitchShow(showInfo)
  if showInfo == nil then
    showInfo = true
    if View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Title.Img_InfoOpen.IsActive then
      showInfo = false
    end
  end
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Title.Img_InfoClose:SetActive(not showInfo)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_Title.Img_InfoOpen:SetActive(showInfo)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Txt_Des:SetActive(showInfo)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_TxtSpace1:SetActive(showInfo)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_TxtSpace2:SetActive(showInfo)
  View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.self:SetActive(not showInfo)
  DataModel.UpdateLayout = true
end

return Controller
