local View = require("UIHomeCarriageeditor/UIHomeCarriageeditorView")
local DataModel = require("UIHomeCarriageeditor/UIEditDataModel")
local MainDataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
local MainController = require("UIHomeCarriageeditor/UIHomeCarriageeditorController")
local Controller = {}

function Controller:InitView()
  MainDataModel.isTrainMoved = false
  DataModel.InitEditData()
  Controller:RefreshTopElectric()
  View.Img_Black:SetActive(true)
  View.Img_Glass:SetActive(true)
  View.Img_Basepicture:SetActive(true)
  View.Group_Edit.Btn_All:SetActive(true)
  Controller:RefreshSaveEditShow(false)
  View.Group_Edit.ScrollView_Train.Viewport.Content.Group_Name.Txt_Number:SetText("01")
  View.Group_Edit.ScrollView_Train.Viewport.Content.Group_Name.Btn_Name.self:SetClickParam(0)
  View.Group_Edit.ScrollView_Train.Viewport.Content.Group_Name.Btn_Name.self:SetActive(true)
  View.Group_Edit.ScrollView_Train.Viewport.Content.Group_Name.Btn_Name.Img_Name:SetActive(false)
  View.Group_Edit.ScrollView_Train.Viewport.Content.Group_Name.Btn_Name.Img_Tips:SetActive(true)
  View.Group_Edit.ScrollView_Train.Viewport.Content.Btn_Locomotivehead:SetSprite(DataModel.coachHeadInfo.thumbnail)
  View.Group_Edit.ScrollView_Train.Viewport.Content.Group_Name.Txt_Name:SetText(DataModel.coachHeadInfo.name)
  Controller:RefreshStaticGridTrain(true)
  View.Group_Edit.ScrollView_Train.Viewport.Content.self:SetAnchoredPositionX(0)
  View.Group_Edit.NewScrollGrid_CoachList.self:SetActive(false)
  Controller:RefreshCoachSpaceShow()
  View.Group_ChangeName.self:SetActive(false)
  View.Group_Tips:SetActive(false)
  View.Btn_CloseTips:SetActive(false)
  View.Group_Edit.Group_Overview:SetActive(false)
  View.Group_Edit.Btn_CloseOverview:SetActive(false)
  View.Group_Edit.Img_Help:SetActive(false)
  Controller:RefreshBuildAboutShow()
  DataModel.curCoachTypeSelect = 0
  Controller:SelectCoachType(-1)
end

function Controller:RefreshStaticGridTrain(reCalcCount)
  if reCalcCount then
    local width = 3336
    local coachCount = #DataModel.coachInfo
    if DataModel.isEditMode then
      local homeInfo = PlayerData:GetHomeInfo()
      if coachCount + 1 < MainDataModel.maxCoachNum and homeInfo.electric_used < PlayerData.GetMaxElectric() then
        coachCount = coachCount + 1
      end
    end
    local newWidth = (coachCount + 2) * 420 + coachCount * 20 + 300
    if width > newWidth then
      newWidth = width
    end
    View.Group_Edit.ScrollView_Train.Viewport.Content.self:SetWidth(newWidth)
  end
  DataModel.IsCanAddNewCoach = false
  View.Group_Edit.ScrollView_Train.Viewport.Content.StaticGrid_Train.grid.self:RefreshAllElement()
end

function Controller:RefreshBuildAboutShow()
  local building = PlayerData:GetHomeInfo().building
  local isBuilding = table.count(building) > 0
  local isComplete = false
  View.Group_Edit.Group_Build.Img_BuildDetail.Group_Building.self:SetActive(false)
  DataModel.isBuilding = false
  if isBuilding then
    for k, v in pairs(building) do
      local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
      isComplete = v.create_time + coachCA.waittime <= TimeUtil:GetServerTimeStamp()
    end
    if isComplete then
      View.Group_Edit.Group_Build.Img_BuildDetail.Txt_NoBuild:SetActive(true)
      View.Group_Edit.Group_Build.Img_BuildDetail.Txt_NoBuild:SetText(GetText(80601056))
    else
      DataModel.isBuilding = true
      View.Group_Edit.Group_Build.Img_BuildDetail.Txt_NoBuild:SetActive(false)
      View.Group_Edit.Group_Build.Img_BuildDetail.Group_Building.self:SetActive(true)
      Controller:RefreshBuildTimeShow()
    end
  else
    View.Group_Edit.Group_Build.Img_BuildDetail.Txt_NoBuild:SetActive(true)
    View.Group_Edit.Group_Build.Img_BuildDetail.Txt_NoBuild:SetText(GetText(80601055))
  end
  View.Group_Edit.Group_Build.Btn_Build.self:SetActive(not isBuilding)
  View.Group_Edit.Group_Build.Btn_Building.self:SetActive(isBuilding and not isComplete)
  View.Group_Edit.Group_Build.Btn_Built.self:SetActive(isBuilding and isComplete)
end

function Controller:RefreshBuildTimeShow()
  local coachCA = PlayerData:GetFactoryData(DataModel.coachId, "HomeCoachFactory")
  local time = coachCA.waittime
  local remainTime = 0
  local building = PlayerData:GetHomeInfo().building
  local isBuilding = 0 < table.count(building)
  if isBuilding then
    for k, v in pairs(building) do
      remainTime = v.create_time + time - TimeUtil:GetServerTimeStamp()
      break
    end
  end
  if 0 < remainTime then
    local timeTable = TimeUtil:SecondToTable(remainTime)
    View.Group_Edit.Group_Build.Img_BuildDetail.Group_Building.Txt_Time:SetText(string.format("%02d:%02d:%02d", timeTable.hour, timeTable.minute, timeTable.second))
    local percent = 1 - remainTime / time
    if percent < 0 then
      percent = 0
    end
    View.Group_Edit.Group_Build.Img_BuildDetail.Group_Building.Img_Bg.Img_Line:SetFilledImgAmount(percent)
  else
    Controller:RefreshBuildAboutShow()
  end
end

function Controller:ResetGridShow(element)
  element.self:SetActive(true)
  element.Group_Name.Btn_Name.Img_Name:SetActive(false)
  element.Group_Name.Btn_Name.Img_Tips:SetActive(true)
  element.Group_Box.Btn_close:SetActive(false)
  element.Group_Box.Btn_add:SetActive(false)
  element.Group_Box.Btn_change:SetActive(false)
  element.Group_Connect.self:SetActive(false)
  element.Group_Box.Btn_Train.Img_Type:SetColor("#FFFFFF")
  element.Group_Empty:SetActive(false)
end

function Controller:ResetGridEditShow(element)
  element.self:SetActive(true)
  element.Group_Name.Btn_Name.Img_Name:SetActive(true)
  element.Group_Name.Btn_Name.Img_Tips:SetActive(false)
  element.Group_Box.Btn_close:SetActive(false)
  element.Group_Box.Btn_add:SetActive(false)
  element.Group_Box.Btn_change:SetActive(false)
  element.Group_Connect.self:SetActive(true)
  element.Group_Connect.Img_ConnectLight:SetActive(false)
  element.Group_Box.Btn_Train.Img_Type:SetColor("#7F7F7F")
  element.Group_Empty:SetActive(false)
end

function Controller:RefreshCoachElement(element, elementIndex)
  local info = DataModel.coachInfo[elementIndex]
  if DataModel.isEditMode then
    Controller:ResetGridEditShow(element)
  else
    Controller:ResetGridShow(element)
  end
  local isHave = info ~= nil
  element.Group_Name.self:SetActive(isHave)
  if isHave then
    element.Group_Name.Txt_Name:SetText(info.name)
    element.Group_Name.Txt_Name:SetActive(true)
  end
  element.Group_Name.Txt_Number:SetText(string.format("%02d", elementIndex + 1))
  element.Group_Name.Btn_Name.self:SetClickParam(elementIndex)
  if DataModel.isEditMode then
    if isHave then
      local path = info.thumbnail
      local isDragCoach = not DataModel.dragIsCoachBag and DataModel.dragIdx == elementIndex
      if isDragCoach then
        path = DataModel.emptyPath
      end
      element.Group_Box.Btn_Train.Img_Type:SetSprite(path)
      element.Group_Box.Btn_Train:SetClickParam(elementIndex)
      if not DataModel.isDrag then
        element.Group_Box.Btn_close:SetActive(true)
        element.Group_Box.Btn_close:SetClickParam(elementIndex)
      else
        element.Group_Box.Btn_change:SetActive(not isDragCoach)
      end
    else
      local coachCount = #DataModel.coachInfo
      local homeInfo = PlayerData:GetHomeInfo()
      if elementIndex == coachCount + 1 and elementIndex < MainDataModel.maxCoachNum and homeInfo.electric_used < PlayerData.GetMaxElectric() then
        DataModel.IsCanAddNewCoach = true
        element.Group_Box.Btn_Train.Img_Type:SetSprite(DataModel.emptyPath)
        element.Group_Name.Btn_Name.Img_Name:SetActive(false)
        element.Group_Name.Txt_Name:SetActive(false)
        element.Group_Box:SetActive(true)
        element.Group_Box.Btn_add:SetActive(true)
      elseif (not DataModel.IsCanAddNewCoach and elementIndex == coachCount + 1 or DataModel.IsCanAddNewCoach and elementIndex == coachCount + 2) and MainDataModel.UnlockNextCoachLv > 0 then
        element.Group_Empty:SetActive(true)
        element.Group_Box:SetActive(false)
        element.Group_Connect:SetActive(false)
        element.Group_Empty.Img_Electriclevelbg.Txt_Text:SetText(string.format(GetText(80601814), MainDataModel.UnlockNextCoachLv))
      else
        element.self:SetActive(false)
      end
    end
  elseif isHave then
    element.Group_Box.Btn_Train.Img_Type:SetSprite(info.thumbnail)
    element.Group_Box.Btn_Train:SetClickParam(elementIndex)
  else
    element.self:SetActive(false)
  end
end

function Controller:RefreshBagTitleElement(element, elementIndex)
  local coachType = DataModel.coachTypes[elementIndex]
  local tagCA = PlayerData:GetFactoryData(coachType, "TagFactory")
  element.Btn_Custom.self:SetClickParam(elementIndex)
  local isSelect = coachType == DataModel.curCoachTypeSelect
  element.Btn_Custom.Img_CustomLight.self:SetActive(isSelect)
  element.Btn_Custom.Group_Custom.self:SetActive(not isSelect)
  if isSelect then
    element.Btn_Custom.Img_CustomLight.Img_Customselect:SetSprite(tagCA.carriageIcon)
    element.Btn_Custom.Img_CustomLight.Txt_Customselect:SetText(tagCA.typeName)
  else
    element.Btn_Custom.Group_Custom.Img_Custom:SetSprite(tagCA.carriageIcon)
    element.Btn_Custom.Group_Custom.Txt_Custom:SetText(tagCA.typeName)
  end
end

function Controller:RefreshCoachBagElement(element, elementIndex)
  local info = DataModel.GetCurCoachBagInfo(elementIndex)
  local isHave = info ~= nil
  local isAdd = elementIndex == DataModel.MaxElementCount
  element.Group_Item.Btn_Item.Img_Bg:SetActive(isHave)
  element.Group_Item.Btn_Item.Txt_Item:SetActive(isHave)
  element.Group_Item.Btn_Item.Img_Item:SetActive(isHave)
  element.Group_Item.Btn_Item.Img_Empty:SetActive(not isHave and not isAdd)
  element.Group_Item.Btn_Item.Img_Add:SetActive(not isHave and isAdd)
  element.Group_Item.Btn_Item.Img_Electric:SetActive(isHave)
  element.Group_Item.Btn_Item.Btn_Tips:SetActive(isHave)
  if info ~= nil then
    element.Group_Item.Btn_Item.Txt_Item:SetText(info.name)
    element.Group_Item.Btn_Item.Img_Item:SetSprite(info.thumbnail)
    local electric = info.electricCost
    element.Group_Item.Btn_Item.Img_Electric.Txt_Num:SetText(electric)
  end
  element.Group_Item.Btn_Item.self:SetClickParam(elementIndex)
  element.Group_Item.Btn_Item.Btn_Tips:SetClickParam(elementIndex)
end

function Controller:RefreshCoachBag()
  local maxSpace = PlayerData:GetHomeInfo().max_coach_space
  local count = 0
  if 0 < DataModel.curCoachTypeSelect then
    local curSpace = 0
    for k, v in pairs(DataModel.coachBagInfo) do
      curSpace = curSpace + #v
    end
    count = #DataModel.coachBagInfo[DataModel.curCoachTypeSelect] + maxSpace - curSpace
  else
    count = maxSpace
  end
  if DataModel.CanExpand then
    count = count + 1
    DataModel.MaxElementCount = count
  end
  View.Group_Edit.NewScrollGrid_CoachList.grid.self:SetDataCount(count)
  View.Group_Edit.NewScrollGrid_CoachList.grid.self:RefreshAllElement()
end

function Controller:SelectCoachType(type)
  if DataModel.curCoachTypeSelect == type then
    return
  end
  DataModel.curCoachTypeSelect = type
  View.Group_Edit.Group_BoxBtn.Img_Mask.StaticGrid_Type.grid.self:RefreshAllElement()
  View.Group_Edit.Btn_NormalTrain.Img_NormalTrain.self:SetActive(type ~= -1)
  View.Group_Edit.Btn_NormalTrain.Img_NormalTrainLight.self:SetActive(type == -1)
  View.Group_Edit.NewScrollGrid_CoachList.self:SetActive(true)
  View.self:StartC(LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
    Controller:RefreshCoachBag()
  end))
end

function Controller:RefreshSaveEditShow(isEdit)
  View.Group_Edit.Btn_EditMode.self:SetActive(not isEdit)
  View.Group_Edit.Btn_hold.self:SetActive(isEdit)
  Controller:ShowInformation(not isEdit)
  if DataModel.isEditMode ~= isEdit then
    DataModel.isEditMode = isEdit
    View.Group_Edit.Img_Help:SetActive(isEdit)
    Controller:RefreshStaticGridTrain(true)
    View.Group_Edit.ScrollView_Train.Viewport.Content.Group_Name.Btn_Name.Img_Name:SetActive(DataModel.isEditMode)
    View.Group_Edit.ScrollView_Train.Viewport.Content.Group_Name.Btn_Name.Img_Tips:SetActive(not DataModel.isEditMode)
    View.Group_Edit.Btn_All:SetActive(not DataModel.isEditMode)
    Controller:RefreshTopElectric()
  end
end

function Controller:BagToUse(bagIdx, toIdx)
  local complete = DataModel.BagToUse(bagIdx, toIdx)
  if not complete then
    return
  end
  Controller:RefreshStaticGridTrain(true)
  Controller:RefreshCoachSpaceShow()
  Controller:RefreshCoachBag()
  Controller:RefreshTopElectric()
end

function Controller:UseToBag(useIdx)
  local maxSpace = PlayerData:GetHomeInfo().max_coach_space
  local curSpace = 0
  for k, v in pairs(DataModel.coachBagInfo) do
    curSpace = curSpace + #v
  end
  if maxSpace < curSpace + 1 then
    CommonTips.OpenTips(80600390)
    return
  end
  local complete = DataModel.UseToBag(useIdx)
  if complete then
    Controller:RefreshStaticGridTrain(true)
    Controller:RefreshCoachSpaceShow()
    Controller:RefreshCoachBag()
    Controller:RefreshTopElectric()
  end
end

function Controller:UseChangeIdx(useIdx, toIdx)
  local complete = DataModel.UseChangeIdx(useIdx, toIdx)
  if not complete then
    return
  end
  Controller:RefreshStaticGridTrain(false)
end

function Controller:SwapCoachAndBag(bagIdx, useIdx)
  local complete = DataModel.SwapCoachAndBag(bagIdx, useIdx)
  if complete then
    Controller:RefreshStaticGridTrain(false)
    Controller:RefreshCoachSpaceShow()
    Controller:RefreshCoachBag()
    Controller:RefreshTopElectric()
  end
end

function Controller:UsePreset()
  Net:SendProto("home.load_template", function(json)
    DataModel.UsePreset()
    View.Group_Edit.ScrollGrid_Btn_Preset.grid.self:RefreshAllElement()
  end, DataModel.curPresetIdx - 1)
end

function Controller:SaveEdit(cb)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if #DataModel.coachInfo + 1 < homeConfig.trainlong then
    CommonTips.OpenTips(80601303)
    return
  end
  local isHavePassenger = false
  local str = DataModel.coachHeadUid
  for k, v in pairs(DataModel.coachInfo) do
    str = str .. ","
    str = str .. v.uid
    isHavePassenger = isHavePassenger or v.coachType == 12600167
  end
  if not isHavePassenger then
    CommonTips.OpenTips(80601302)
    return
  end
  if not DataModel.CompareIsEdit() then
    Controller:RefreshSaveEditShow(false)
    CommonTips.OpenTips(80601801)
    return
  end
  Net:SendProto("home.save_coach", function(json)
    PlayerData:GetHomeInfo().speed = json.speed
    local t = {}
    table.insert(t, DataModel.coachHeadUid)
    for k, v in pairs(DataModel.coachInfo) do
      table.insert(t, v.uid)
    end
    Controller.RefreshFurSkillData(t)
    PlayerData:GetHomeInfo().coach_template = t
    DataModel.UsePreset()
    Controller:RefreshSaveEditShow(false)
    local homeController = require("UIMainUI/UIMainUIController")
    homeController.InitTrain(false)
    if cb ~= nil then
      cb()
    end
    CommonTips.OpenTips(80601801)
  end, DataModel.curPresetIdx - 1, str)
end

function Controller.RefreshFurSkillData(newCoaches)
  local addCoach = {}
  for _, v in pairs(newCoaches) do
    local find = false
    for _, v1 in pairs(PlayerData:GetHomeInfo().coach_template) do
      if v1 == v then
        find = true
        break
      end
    end
    if not find then
      addCoach[v] = v
    end
  end
  for i, v in pairs(PlayerData:GetFurniture()) do
    if addCoach[v.u_cid] then
      PlayerData.RefreshFurSkillData(v)
    end
  end
  local removeCoach = {}
  for _, v in pairs(PlayerData:GetHomeInfo().coach_template) do
    local find = false
    for _, v1 in pairs(newCoaches) do
      if v1 == v then
        find = true
        break
      end
    end
    if not find then
      removeCoach[v] = v
    end
  end
  for i, v in pairs(PlayerData:GetFurniture()) do
    if removeCoach[v.u_cid] then
      PlayerData.RefreshFurSkillData(v, true)
    end
  end
end

function Controller:BeginDrag(isCoachBag, idx)
  if MainDataModel.curFrameMouseUp then
    return
  end
  local info
  if idx == 0 then
    info = {}
    local coachInfo = PlayerData:GetHomeInfo().coach_store[DataModel.coachHeadUid]
    DataModel.AddCAInfo(info, coachInfo.id, DataModel.coachHeadUid)
  elseif isCoachBag then
    info = DataModel.GetCurCoachBagInfo(idx)
  else
    info = DataModel.coachInfo[idx]
  end
  if info == nil then
    return
  end
  View.Group_Edit.NewScrollGrid_CoachList.self:SetEnable(false)
  View.Group_Edit.ScrollView_Train.ScrollRect.enabled = false
  DataModel.isDrag = true
  DataModel.dragIdx = idx
  DataModel.dragIsCoachBag = isCoachBag
  DataModel.dragShowMode = 0
  local pos = Input.mousePosition
  View.Group_TempTrain.self:SetAnchoredPosition(Vector2(pos.x, pos.y))
  View.Group_TempTrain.Img_Train:SetSprite(info.thumbnail)
  View.Group_TempTrain.self:SetActive(true)
  View.Group_Edit.Img_TakeBack.self:SetActive(true)
  Controller:RefreshStaticGridTrain(false)
end

function Controller:SelectPreset(idx)
  local cb = function()
    DataModel.SelectPreset(idx)
    Controller:RefreshSaveEditShow(false)
    View.Group_Edit.ScrollGrid_Btn_Preset.grid.self:RefreshAllElement()
  end
  if DataModel.isEditMode then
    CommonTips.OnPrompt(80600388, nil, nil, function()
      Controller:SaveEdit(cb)
    end, function()
      cb()
    end, nil, true)
  else
    cb()
    View.Group_Edit.StaticGrid_Carriage.grid.self:RefreshAllElement()
    Controller:RefreshStaticGridTrain(true)
  end
end

function Controller:LongPressTrain(isCoachBag, idx)
  if DataModel.isEditMode then
    Controller:BeginDrag(isCoachBag, idx)
  else
  end
end

function Controller:CalcDragingPos()
  local pos = View.Group_Edit.transform:InverseTransformPoint(View.Group_TempTrain.self.transform.position)
  local rect = View.Group_Edit.Img_TakeBack.self.Rect.rect
  local viewPos = View.Group_Edit.transform:InverseTransformPoint(View.Group_Edit.Img_TakeBack.self.transform.position)
  local limitLeftX = viewPos.x - rect.width * 0.5
  local limitRightX = viewPos.x + rect.width * 0.5
  local limitTopY = viewPos.y + rect.height * 0.5
  local limitBottomY = viewPos.y - rect.height * 0.5
  if limitBottomY < pos.y and limitTopY > pos.y and limitLeftX < pos.x and limitRightX > pos.x then
    if DataModel.dragIsCoachBag then
    else
      return 1, DataModel.dragIdx
    end
    return -1
  end
  pos = View.Group_Edit.ScrollView_Train.Viewport.Content.StaticGrid_Train.self.transform:InverseTransformPoint(View.Group_TempTrain.self.transform.position)
  limitTopY = DataModel.trainSize.y * 0.5
  limitBottomY = -DataModel.trainSize.y * 0.5
  if limitBottomY > pos.y or limitTopY < pos.y then
    return -1
  end
  local halfX = DataModel.trainSize.x * 0.5
  local endIdx = -1
  local toIdx = -1
  local preLeftX = View.Group_Edit.ScrollView_Train.Viewport.Content.StaticGrid_Train.self.transform:InverseTransformPoint(View.Group_Edit.ScrollView_Train.Viewport.Content.Btn_Locomotivehead.transform.position).x - 45
  local coachCount = #DataModel.coachInfo
  local maxCount = coachCount + 1 > MainDataModel.maxCoachNum - 1 and MainDataModel.maxCoachNum - 1 or coachCount + 1
  for i = 1, maxCount do
    local grid = View.Group_Edit.ScrollView_Train.Viewport.Content.StaticGrid_Train.grid[i]
    if grid ~= nil then
      local gridPos = grid.self.transform.localPosition
      local leftX = gridPos.x - halfX
      local rightX = gridPos.x + halfX
      if leftX < pos.x and rightX > pos.x then
        endIdx = i
        break
      elseif rightX < pos.x and preLeftX > pos.x then
        toIdx = i
        break
      end
      preLeftX = leftX
    end
  end
  return 2, toIdx, endIdx
end

function Controller:Draging()
  local res, toIdx, endIdx = Controller:CalcDragingPos()
  local mode = 0
  if res == -1 then
    mode = 1
  elseif res == 1 then
    mode = 1
  elseif res == 2 then
    if toIdx ~= -1 then
      mode = 2
    elseif endIdx ~= -1 then
      mode = 3
    else
      mode = 1
    end
  end
  if mode == DataModel.dragShowMode then
    return
  end
  Controller:ResetHighLightElement()
  DataModel.dragShowMode = mode
  if mode == 2 then
    local grid = View.Group_Edit.ScrollView_Train.Viewport.Content.StaticGrid_Train.grid[toIdx]
    local showElement = grid.Group_Connect.Img_ConnectLight
    showElement:SetActive(true)
    local t = {}
    t.element = showElement
    t.active = true
    table.insert(DataModel.lastHighLightElement, t)
  else
    if mode == 3 then
      local grid = View.Group_Edit.ScrollView_Train.Viewport.Content.StaticGrid_Train.grid[endIdx]
      local showElement = grid.Group_Box.Btn_Train.Img_Type
      showElement:SetColor("#FFFFFF")
      local t = {}
      t.element = showElement
      t.active = false
      table.insert(DataModel.lastHighLightElement, t)
      local otherShow = false
      if grid.Group_Box.Btn_add.self.IsActive then
        showElement = grid.Group_Box.Btn_add.Img_addLight
        showElement:SetActive(true)
        otherShow = true
      elseif grid.Group_Box.Btn_change.self.IsActive then
        showElement = grid.Group_Box.Btn_change.Img_changeLight
        showElement:SetActive(true)
        otherShow = true
      end
      if otherShow then
        t = {}
        t.element = showElement
        t.active = true
        table.insert(DataModel.lastHighLightElement, t)
      end
    else
    end
  end
end

function Controller:DragEnd()
  local res, toIdx, endIdx = Controller:CalcDragingPos()
  if res == -1 then
    View.Group_TempTrain.self:SetActive(false)
  elseif res == 1 then
    Controller:UseToBag(toIdx)
  elseif res == 2 then
    if toIdx ~= -1 then
      if DataModel.dragIsCoachBag then
        Controller:BagToUse(DataModel.dragIdx, toIdx)
      else
        Controller:UseChangeIdx(DataModel.dragIdx, toIdx)
      end
    elseif endIdx ~= -1 then
      if DataModel.dragIsCoachBag then
        Controller:SwapCoachAndBag(DataModel.dragIdx, endIdx)
      else
        Controller:SwapCoach(DataModel.dragIdx, endIdx)
      end
    end
  end
  DataModel.dragIdx = 0
  View.Group_Edit.NewScrollGrid_CoachList.self:SetEnable(true)
  View.Group_Edit.ScrollView_Train.ScrollRect.enabled = true
  View.Group_TempTrain.self:SetActive(false)
  View.Group_Edit.Img_TakeBack.self:SetActive(false)
  Controller:ResetHighLightElement()
  Controller:RefreshStaticGridTrain(true)
end

function Controller:ResetHighLightElement()
  for k, v in pairs(DataModel.lastHighLightElement) do
    if not v.element:IsNull() then
      if v.active then
        v.element:SetActive(false)
      else
        v.element:SetColor("#7F7F7F")
      end
    end
  end
  DataModel.lastHighLightElement = {}
end

function Controller:SwapCoach(idx1, idx2)
  if idx1 == idx2 then
    return
  end
  local count = #DataModel.coachInfo
  if idx1 > count or idx2 > count then
    return
  end
  DataModel.SwapCoach(idx1, idx2)
  Controller:RefreshStaticGridTrain(false)
end

function Controller:ReloadTrain()
  local coachIds = PlayerData:GetHomeInfo().coach_template
  local isReload = false
  if #coachIds ~= #DataModel.recordEnterCoachIds then
    isReload = true
  else
    for k, v in pairs(coachIds) do
      if v ~= DataModel.recordEnterCoachIds[k] then
        isReload = true
        break
      end
    end
  end
  if isReload then
    local homeController = require("UIMainUI/UIMainUIController")
    homeController.InitTrain(false)
  end
end

function Controller:ClickBuildCoach(isBuilding)
  if isBuilding then
    local id = 0
    for k, v in pairs(PlayerData:GetHomeInfo().building) do
      id = tonumber(v.id)
    end
    local coachCA = PlayerData:GetFactoryData(id, "HomeCoachFactory")
    local items = {}
    local num = 0
    local isEnough = true
    local skip_count = PlayerData:GetHomeInfo().skip_num or 0
    local text = ""
    if skip_count == 0 then
      text = GetText(80601980)
      num = 0
    else
      for k, v in pairs(coachCA.JumptimeList) do
        items[v.id] = v.num
        num = v.num
        if num > PlayerData:GetGoodsById(v.id).num then
          isEnough = false
          break
        end
      end
    end
    CommonTips.OnPrompt(string.format(GetText(80601269) .. text, num), nil, nil, function()
      if not isEnough then
        CommonTips.OpenTips(80601046)
        return
      end
      Net:SendProto("home.skip", function(json)
        if PlayerData:GetHomeInfo().skip_num == nil then
          PlayerData:GetHomeInfo().skip_num = 1
        else
          PlayerData:GetHomeInfo().skip_num = PlayerData:GetHomeInfo().skip_num + 1
        end
        PlayerData:GetHomeInfo().building = json.building
        PlayerData:RefreshUseItems(items)
        if json.reward then
          json.reward.furniture = nil
          CommonTips.OpenCoachReward(json.reward)
          Controller:DetailGetCoach(json.reward.coach)
        else
          CommonTips.OpenTips(80601270)
        end
      end)
    end)
  else
    UIManager:Open("UI/Trainfactory/BuildWindow", nil, function()
      Controller:RefreshBuildAboutShow()
      if DataModel.GetCoachInfo ~= nil then
        Controller:DetailGetCoach(DataModel.GetCoachInfo)
        DataModel.GetCoachInfo = nil
      end
    end)
  end
end

function Controller:ConfirmGetCoach()
  local maxCoachSpace = PlayerData:GetHomeInfo().max_coach_space
  local curSpace = 0
  for k, v in pairs(DataModel.coachBagInfo) do
    curSpace = curSpace + #v
  end
  if maxCoachSpace <= curSpace then
    CommonTips.OpenTips(80601270)
    return
  end
  Net:SendProto("home.get_coach", function(json)
    json.reward.furniture = nil
    PlayerData:GetHomeInfo().building = {}
    CommonTips.OpenCoachReward(json.reward)
    Controller:RefreshBuildAboutShow()
    Controller:DetailGetCoach(json.reward.coach)
  end)
end

function Controller:DetailGetCoach(coach)
  for k, v in pairs(coach) do
    local t = {}
    t.id = tonumber(v.id)
    t.uid = k
    DataModel.AddCAInfo(t, t.id, t.uid)
    t.name = v.name
    table.insert(DataModel.coachBagInfo[t.coachType], t)
  end
  Controller:RefreshCoachSpaceShow()
  Controller:RefreshCoachBag()
end

function Controller:RefreshCoachSpaceShow()
  local maxCoachSpace = PlayerData:GetHomeInfo().max_coach_space
  local curSpace = 0
  for k, v in pairs(DataModel.coachBagInfo) do
    curSpace = curSpace + #v
  end
  View.Group_Edit.Group_Expand.Group_Num.Txt_Num1:SetText(string.format("%02d", curSpace))
  View.Group_Edit.Group_Expand.Group_Num.Txt_Num2:SetText(string.format("%02d", maxCoachSpace))
  local toSpace = maxCoachSpace + 1
  DataModel.MaxElementCount = -1
  DataModel.CanExpand = false
  local config = PlayerData:GetFactoryData(99900040, "ConfigFactory")
  for k, v in pairs(config.CarriagehouseList) do
    if v.no == toSpace then
      DataModel.CanExpand = true
      break
    end
  end
end

function Controller:ExpandCoachBag()
  local config = PlayerData:GetFactoryData(99900040, "ConfigFactory")
  local toSpace = PlayerData:GetHomeInfo().max_coach_space + 1
  local costInfo = {}
  local isFind = false
  for k, v in pairs(config.CarriagehouseList) do
    if v.no == toSpace then
      costInfo.id = v.id
      costInfo.num = v.num
      isFind = true
      break
    end
  end
  if not isFind then
    return
  end
  CommonTips.OnPrompt(string.format(GetText(80601057), costInfo.num), nil, nil, function()
    if PlayerData:GetGoodsById(costInfo.id).num < costInfo.num then
      CommonTips.OpenTips(80601025)
      return
    end
    Net:SendProto("home.expand", function(json)
      PlayerData:GetHomeInfo().max_coach_space = PlayerData:GetHomeInfo().max_coach_space + 1
      local t = {}
      t[costInfo.id] = costInfo.num
      PlayerData:RefreshUseItems(t)
      Controller:RefreshCoachSpaceShow()
      Controller:RefreshCoachBag()
    end)
  end)
end

function Controller:OpenChangeName(idx)
  DataModel.RenameIdx = idx
  UIManager:LoadSplitPrefab(View, "UI/Trainfactory/HomeCarriageeditor", "Group_ChangeName")
  View.Group_ChangeName.self:SetActive(true)
  if idx == 0 then
    local serverHeadCoach = PlayerData:GetHomeInfo().coach[1]
    local name = serverHeadCoach.name
    View.Group_ChangeName.InputField_ChangeName.self:SetText(name)
  else
    local info = DataModel.coachInfo[idx]
    View.Group_ChangeName.InputField_ChangeName.self:SetText(info.name)
  end
end

function Controller:ConfirmRename()
  local result = View.Group_ChangeName.InputField_ChangeName.self:CheckText(15)
  if result == 0 then
    local name = View.Group_ChangeName.InputField_ChangeName:GetText()
    local uid
    local checkName = ""
    if DataModel.RenameIdx == 0 then
      uid = PlayerData:GetHomeInfo().coach_template[1]
    else
      local info = DataModel.coachInfo[DataModel.RenameIdx]
      uid = info.uid
    end
    Net:SendProto("home.update_coach_name", function(json)
      PlayerData:GetHomeInfo().coach_store[uid].name = name
      View.Group_ChangeName.self:SetActive(false)
      if DataModel.RenameIdx > 0 then
        DataModel.coachInfo[DataModel.RenameIdx].name = name
        DataModel.coachInfo[DataModel.RenameIdx].checkName = name
        Controller:RefreshStaticGridTrain(false)
      else
        DataModel.coachHeadInfo.name = name
        View.Group_Edit.ScrollView_Train.Viewport.Content.Group_Name.Txt_Name:SetText(name)
      end
    end, name, uid)
  else
    CommonTips.OpenTips(80601080)
  end
end

function Controller:ShowCoachDetailPanel(type, btn, str)
  local idx = tonumber(str)
  local info
  if type == 2 then
    info = DataModel.GetCurCoachBagInfo(idx)
  elseif idx ~= 0 then
    info = DataModel.coachInfo[idx]
  else
    info = DataModel.coachHeadInfo
  end
  if info == nil then
    return
  end
  MainController:ShowCoachTip(info, btn, type == 1 and 122 or 0)
end

function Controller:ShowCoachAllInfo()
  View.Group_Edit.Btn_CloseOverview:SetActive(true)
  View.Group_Edit.Group_Overview.self:SetActive(true)
  local serverRepairInfo = PlayerData:GetHomeInfo().readiness.repair
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Durable.Txt_Num:SetText(serverRepairInfo.current_durable .. "/" .. PlayerData.GetCoachMaxDurability())
  local homeInfo = PlayerData:GetHomeInfo()
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Electric.Txt_Num:SetText(homeInfo.electric_used .. "/" .. PlayerData.GetMaxElectric())
  local home_info = PlayerData:GetHomeInfo()
  local curSpeed = home_info.speed
  local homeSkillSpeed = math.floor(PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddSpeed) + 0.5)
  local drinkBuffSpeed = math.floor(PlayerData:GetDrinkBuffIncrease(EnumDefine.HomeSkillEnum.AddSpeed) + 0.5)
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  local weightGoodsSpeed = PlayerData:GetUserInfo().space_info.now_train_goods_num / initConfig.goodsSlowDown
  weightGoodsSpeed = math.floor(weightGoodsSpeed + 0.5)
  local weightPassengerSpeed = PlayerData:GetCurPassengerNum() / initConfig.passengerSlowDown
  weightPassengerSpeed = math.floor(weightPassengerSpeed + 0.5)
  local maintenanceSpeed = 0
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local maxUpkeepDis = homeConfig.maintaindistance
  if maxUpkeepDis <= home_info.readiness.maintain.maintain_distance then
    maintenanceSpeed = math.floor(curSpeed * homeConfig.slowdown + 0.5)
  end
  local coachSpeedEffect = DataModel.coachHeadInfo.speedEffect
  local armor = DataModel.coachHeadInfo.armor
  for k, v in pairs(DataModel.coachInfo) do
    coachSpeedEffect = coachSpeedEffect + v.speedEffect
    armor = armor + v.armor
  end
  coachSpeedEffect = math.floor(coachSpeedEffect + 0.5)
  armor = armor + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainHP, armor)
  local deterrence = PlayerData:GetUserInfo().deterrence + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddDeterrence) + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AddDeterrence, PlayerData:GetUserInfo().deterrence)
  local coloudness = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddColoudness) + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AddColoudness, 0)
  local trainAccessoriesSpeed = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainSpeed, curSpeed, "accessories")
  trainAccessoriesSpeed = trainAccessoriesSpeed + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainSpeed, curSpeed, "pendant")
  local height = 60
  if 0 < homeSkillSpeed then
    height = height + 40
  end
  if 0 < drinkBuffSpeed then
    height = height + 40
  end
  if 0 < weightGoodsSpeed then
    height = height + 40
  end
  if 0 < weightPassengerSpeed then
    height = height + 40
  end
  if 0 < maintenanceSpeed then
    height = height + 40
  end
  if trainAccessoriesSpeed ~= 0 then
    height = height + 40
  end
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed:SetHeight(height + 10)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange:SetHeight(height + 10)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Skill:SetActive(0 < homeSkillSpeed)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Drink:SetActive(0 < drinkBuffSpeed)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Weight:SetActive(0 < weightPassengerSpeed)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Goods:SetActive(0 < weightGoodsSpeed)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Maintenance:SetActive(0 < maintenanceSpeed)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Carriage:SetActive(coachSpeedEffect < 0)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Weapon:SetActive(trainAccessoriesSpeed ~= 0)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_All.Txt_Num:SetText(curSpeed + trainAccessoriesSpeed + coachSpeedEffect + homeSkillSpeed + drinkBuffSpeed - weightPassengerSpeed - weightGoodsSpeed - maintenanceSpeed .. "km/h")
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Skill.Txt_Num:SetText(homeSkillSpeed .. "km/h")
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Drink.Txt_Num:SetText(drinkBuffSpeed .. "km/h")
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Weight.Txt_Num:SetText(-weightPassengerSpeed .. "km/h")
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Goods.Txt_Num:SetText(-weightGoodsSpeed .. "km/h")
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Maintenance.Txt_Num:SetText(-maintenanceSpeed .. "km/h")
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Carriage.Txt_Num:SetText(coachSpeedEffect .. "km/h")
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Speed.Img_SpeedChange.Group_Weapon.Txt_Num:SetText(trainAccessoriesSpeed .. "km/h")
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Armor.Txt_Num:SetText(armor)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Weishe.Txt_Num:SetText(deterrence)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Xiexiang.Txt_Num:SetText(coloudness)
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Passenger.Txt_Num:SetText(PlayerData:GetCurPassengerNum() .. "/" .. PlayerData:GetMaxPassengerNum())
  View.Group_Edit.Group_Overview.Img_Glass.Img_Base.Group_Good.Txt_Num:SetText(math.floor(PlayerData:GetUserInfo().space_info.now_train_goods_num or 0.5) .. "/" .. PlayerData.GetMaxTrainGoodsNum())
end

function Controller:RefreshTopElectric()
  View.Img_HaveelectricBg:SetActive(true)
  View.Img_HaveelectricBg.Txt_Num:SetText(DataModel.GetCurPowCost() .. "/" .. PlayerData.GetMaxElectric())
end

function Controller:ShowInformation(isShow)
  if isShow == nil then
    isShow = true
  end
  View.Group_Edit.Img_Information:SetActive(isShow)
  if isShow then
    View.Group_Edit.Img_Information.Group_Information.Txt_Text1:SetText(string.format(GetText(80601891), #DataModel.coachInfo + 1, MainDataModel.maxCoachNum))
    local showTxt2 = MainDataModel.UnlockNextCoachLv > 0
    View.Group_Edit.Img_Information.Group_Information.Txt_Text2:SetActive(showTxt2)
    if showTxt2 then
      View.Group_Edit.Img_Information.Group_Information.Txt_Text2:SetText(string.format(GetText(80601892), MainDataModel.UnlockNextCoachLv, MainDataModel.maxCoachNum + 1))
    end
  end
end

return Controller
