local View = require("UIEngineCore/UIEngineCoreView")
local DataModel = require("UIEngineCore/UIEngineCoreDataModel")
local BtnItem = require("Common/BtnItem")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  DataModel.Dragging = false
  DataModel.ComeBack = false
  DataModel.DeltaCachePos = nil
  DataModel.DragScreenCenterPos = View.Group_Engine.Group_Core:GetScreenPos()
  for i, v in ipairs(DataModel.EngineCoreTypeToLeftElementName) do
    local element = View.Group_Engine.Group_Core[v]
    element.Img_Limit:SetActive(not DataModel.EngineCoreInfo[i].isUnlock)
    if DataModel.EngineCoreInfo[i].effectPath ~= "" then
      element:SetDynamicGameObject(DataModel.EngineCoreInfo[i].effectPath, 0, 0)
    end
  end
  View.Img_EffectBg:SetActive(false)
  Controller:InitAnim()
end

function Controller:InitAnim()
  DataModel.isNowNextChange = false
  DataModel.NowElement = View.Group_Now
  DataModel.NextElement = View.Group_Next
  if DataModel.Data then
    DataModel.CurEngineCoreType = DataModel.Data.autoClickCoreType
  else
    DataModel.CurEngineCoreType = 1
  end
  local changeAngle = (DataModel.CurEngineCoreType - 1) * DataModel.PerAngle
  DataModel.CurCoreAngleZ = DataModel.CoreDefaultAngleZ + changeAngle
  DataModel.CurGearAngleZ = DataModel.GearDefaultAngleZ - changeAngle
  DataModel.NextEngineCoreType = 0
  DataModel.NowHeight = DataModel.startY
  DataModel.NextHeight = DataModel.endY
  View.Group_Engine.Group_Core:SetLocalEulerAngles(DataModel.CurCoreAngleZ)
  View.Group_Engine.Img_Gear:SetLocalEulerAngles(DataModel.CurGearAngleZ)
  DataModel.NowElement:SetLocalPositionY(DataModel.startY)
  DataModel.NextElement:SetLocalPositionY(DataModel.endY)
  DataModel.NowElement:SetAlpha(1)
  DataModel.NextElement:SetAlpha(0)
  DataModel.NowElement:SetActive(true)
  DataModel.NextElement:SetActive(false)
  Controller:ShowRightByType(DataModel.NowElement, DataModel.CurEngineCoreType)
end

function Controller:ShowRightByType(element, engineCoreType)
  local info = DataModel.EngineCoreInfo[engineCoreType]
  local caId = info.caId
  local ca = PlayerData:GetFactoryData(caId)
  if info.isUnlock then
    element.Txt_Record:SetText(string.format(GetText(ca.record), info.num))
  else
    element.Txt_Record:SetText(GetText(80602071))
  end
  element.Group_Check.Btn_:SetClickParam(engineCoreType)
  element.Group_Check.Img_RedPoint:SetActive(RedpointTree:GetRedpointCnt(info.redName) > 0)
  element.Img_Icon:SetSprite(ca.coreIconPath)
  element.Txt_EngName:SetText(GetText(ca.nameEN))
  element.Txt_Name:SetText(GetText(ca.name))
  element.Group_BreakShow.Txt_Num:SetText(string.format(GetText(80602007), info.lv or 0, info.breakLv or 0))
  for i = 1, 5 do
    local breakElement = element.Group_BreakShow["Img_Break" .. i]
    local isShow = i <= info.breakCnt
    breakElement:SetActive(isShow)
    if isShow then
      breakElement:SetSprite(ca.breakPath)
    end
  end
  element.Img_Di:SetSprite(ca.informationPath)
  element.Group_Upgrade:SetActive(info.isUnlock and not info.canBreak)
  element.Group_Break:SetActive(info.canBreak)
  element.Group_Limit:SetActive(not info.isUnlock)
  if not info.isUnlock then
    element.Group_Limit.Txt_Grade:SetText(string.format(GetText(80601959), info.unlockLv))
  elseif info.canBreak then
    element.Group_Break.Txt_Before:SetText(info.breakLv)
    element.Group_Break.Txt_Next:SetText(info.nextBreakLv)
    element.Group_Break.Btn_Break:SetClickParam(engineCoreType)
    local listCA = PlayerData:GetFactoryData(info.breakId)
    for i = 1, 3 do
      local breakInfo = listCA.breakItemList[i]
      local itemElement = element.Group_Break.Group_Need.Group_Item["Group_Consume" .. i]
      itemElement:SetActive(breakInfo ~= nil)
      if breakInfo ~= nil then
        itemElement.Group_Item.Btn_Item:SetClickParam(breakInfo.id)
        BtnItem:SetItem(itemElement.Group_Item, {
          id = breakInfo.id
        })
        local curNum = PlayerData:GetGoodsById(breakInfo.id).num
        itemElement.Group_Cost.Txt_Have:SetText(PlayerData:TransitionNum(curNum))
        if curNum < breakInfo.num then
          itemElement.Group_Cost.Txt_Have:SetColor("#FF0000")
        else
          itemElement.Group_Cost.Txt_Have:SetColor("#FFFFFF")
        end
        itemElement.Group_Cost.Txt_Need:SetText(PlayerData:TransitionNum(breakInfo.num))
      end
    end
  else
    if 0 < info.unitId then
      local unitCA = PlayerData:GetFactoryData(info.unitId)
      local unitViewCA = PlayerData:GetFactoryData(unitCA.viewId)
      element.Group_Upgrade.Group_Monster.Img_Mask.Img_Icon:SetSprite(unitViewCA.face)
      element.Group_Upgrade.ScrollView_Describe.Viewport.Txt_Describe:SetText(unitCA.safeInformation)
      element.Group_Upgrade.Txt_Name:SetText(unitCA.name)
    end
    element.Group_Upgrade.Btn_Challenge:SetClickParam(engineCoreType)
    local isLvMax = info.lv == info.breakLv
    element.Group_Upgrade.StaticGrid_List.self:SetActive(not isLvMax)
    element.Group_Upgrade.Group_Max:SetActive(isLvMax)
    if not isLvMax then
      element.Group_Upgrade.StaticGrid_List.grid.self:RefreshAllElement()
    end
  end
end

function Controller:ShowConditionTxt(element, elementIndex, parentElement)
  local engineCoreType = DataModel.CurEngineCoreType
  if parentElement == DataModel.NextElement then
    engineCoreType = DataModel.NextEngineCoreType
  end
  local info = DataModel.EngineCoreInfo[engineCoreType]
  element:SetText(info.conditionTxt)
end

function Controller:ShowLevelDetail(str)
  local info = DataModel.EngineCoreInfo[tonumber(str)]
  if not info.isUnlock then
    CommonTips.OpenTips(80602045)
    return
  end
  local t = {}
  t.caId = info.caId
  UIManager:Open("UI/EngineCore/CoreGradeTips", Json.encode(t))
end

function Controller:BreakClick(str)
  local engineCoreType = tonumber(str)
  local info = DataModel.EngineCoreInfo[engineCoreType]
  local listCA = PlayerData:GetFactoryData(info.breakId)
  local useItems = {}
  for i = 1, 3 do
    local breakInfo = listCA.breakItemList[i]
    useItems[breakInfo.id] = breakInfo.num
    if PlayerData:GetGoodsById(breakInfo.id).num < breakInfo.num then
      CommonTips.OpenTips(80602013)
      return
    end
  end
  Net:SendProto("core.upgrade", function(json)
    PlayerData:RefreshUseItems(useItems)
    local serverInfo = PlayerData.ServerData.engines[tostring(info.caId)]
    serverInfo.lv = serverInfo.lv + 1
    serverInfo.num = 0
    local ca = PlayerData:GetFactoryData(info.caId, "EngineCoreFactory")
    local expInfo = ca.coreExpList[serverInfo.lv]
    if expInfo and 0 < expInfo.id then
      local tempListCA = PlayerData:GetFactoryData(expInfo.id)
      if tempListCA and 0 < #tempListCA.EngineRewardList then
        local redName = RedpointTree.NodeNames.Core .. "|" .. info.caId .. "|" .. serverInfo.lv
        RedpointTree:InsertNode(redName)
        RedpointTree:ChangeRedpointCnt(redName, 1)
      end
    end
    local t = {}
    t.caId = info.caId
    t.curLv = info.lv
    DataModel.EngineCoreInfo[engineCoreType] = DataModel.InitDataByCaId(info.caId)
    info = DataModel.EngineCoreInfo[engineCoreType]
    t.nextLv = info.breakLv
    DataModel.BreakEffectObj = View.self:GetRes(DataModel.BreakEffectPath, View.Img_Effect.transform)
    local cb = function()
      Controller:ShowRightByType(DataModel.NowElement, DataModel.CurEngineCoreType)
      UIManager:Open("UI/EngineCore/BreakTips/BreakTips", Json.encode(t))
      View.Img_EffectBg:SetActive(false)
      DataModel.BreakEffectObj:SetActive(false)
    end
    View.Img_EffectBg:SetActive(true)
    View.self:SelectPlayAnim(DataModel.BreakEffectObj:GetComponent(typeof(CS.Seven.UIBase)), "BreakEffect", cb)
  end, info.caId)
end

function Controller:ChallengeClick(str)
  local info = DataModel.EngineCoreInfo[tonumber(str)]
  local status = {
    Current = "Chapter",
    squadIndex = PlayerData.BattleInfo.squadIndex,
    hasOpenThreeView = false,
    coreId = info.caId
  }
  PlayerData.BattleInfo.battleStageId = info.battleId
  PlayerData.BattleCallBackPage = "UI/Home/HomeElectric"
  if PlayerData.Last_Chapter_Parms == nil then
    PlayerData.Last_Chapter_Parms = {}
  end
  PlayerData.Last_Chapter_Parms.autoClickCoreType = DataModel.CurEngineCoreType
  UIManager:Open("UI/Squads/Squads", Json.encode(status))
end

function Controller:ClickItem(str)
  local itemId = tonumber(str)
  CommonTips.OpenItem({itemId = itemId})
end

function Controller:DraggingAnim()
  if DataModel.ComeBack then
    Controller:ComeBackAnim()
    return
  end
  if not DataModel.Dragging then
    return
  end
  if DataModel.DeltaCachePos == nil then
    return
  end
  local moveRotate = DataModel.DeltaCachePos.y * DataModel.rotateSpeedRatio
  if DataModel.BeginDragAngle <= 45 then
    moveRotate = DataModel.DeltaCachePos.x * (45 - DataModel.BeginDragAngle) / 90 - DataModel.DeltaCachePos.y
  elseif DataModel.BeginDragAngle <= 90 then
    moveRotate = DataModel.DeltaCachePos.x - DataModel.DeltaCachePos.y * (90 - DataModel.BeginDragAngle) / 90
  elseif DataModel.BeginDragAngle <= 135 then
    moveRotate = DataModel.DeltaCachePos.x + DataModel.DeltaCachePos.y * (DataModel.BeginDragAngle - 90) / 90
  elseif DataModel.BeginDragAngle <= 180 then
    moveRotate = DataModel.DeltaCachePos.x * (180 - DataModel.BeginDragAngle) / 90 + DataModel.DeltaCachePos.y
  elseif DataModel.BeginDragAngle <= 225 then
    moveRotate = -DataModel.DeltaCachePos.x * (DataModel.BeginDragAngle - 180) / 90 + DataModel.DeltaCachePos.y
  elseif DataModel.BeginDragAngle <= 270 then
    moveRotate = -DataModel.DeltaCachePos.x + DataModel.DeltaCachePos.y * (270 - DataModel.BeginDragAngle) / 90
  elseif DataModel.BeginDragAngle <= 315 then
    moveRotate = -DataModel.DeltaCachePos.x - DataModel.DeltaCachePos.y * (DataModel.BeginDragAngle - 270) / 90
  else
    moveRotate = -DataModel.DeltaCachePos.x * (360 - DataModel.BeginDragAngle) / 90 - DataModel.DeltaCachePos.y
  end
  moveRotate = -moveRotate * DataModel.rotateSpeedRatio
  Controller:DoAnim(moveRotate)
  DataModel.DeltaCachePos = nil
end

function Controller:DoAnim(moveRotate)
  DataModel.CacheRotateAngle = DataModel.CacheRotateAngle + moveRotate
  DataModel.CurCoreAngleZ = DataModel.CurCoreAngleZ + moveRotate
  DataModel.CurGearAngleZ = DataModel.CurGearAngleZ - moveRotate
  View.Group_Engine.Group_Core:SetLocalEulerAngles(DataModel.CurCoreAngleZ)
  View.Group_Engine.Img_Gear:SetLocalEulerAngles(DataModel.CurGearAngleZ)
  local defaultZ = DataModel.CurCoreAngleZ - DataModel.CoreDefaultAngleZ
  while defaultZ < 0 do
    defaultZ = defaultZ + 360
  end
  defaultZ = defaultZ % 360
  local idx, percent = math.modf(defaultZ / DataModel.PerAngle)
  local curIdx, nextIdx
  idx = idx + 1
  if idx > DataModel.EngineCoreCount then
    idx = 1
  end
  if math.abs(DataModel.CacheRotateAngle) + 1.0E-4 >= DataModel.PerAngle then
    if DataModel.CacheRotateAngle < 0 then
      DataModel.CacheRotateAngle = DataModel.CacheRotateAngle + DataModel.PerAngle
    else
      DataModel.CacheRotateAngle = DataModel.CacheRotateAngle - DataModel.PerAngle
    end
    if 0.5 < percent then
      curIdx = idx + 1
      nextIdx = idx
    else
      curIdx = idx
      nextIdx = idx + 1
      percent = 1 - percent
    end
  else
    curIdx = DataModel.CurEngineCoreType
    if idx == curIdx then
      nextIdx = idx + 1
      percent = 1 - percent
    else
      nextIdx = idx
    end
  end
  if curIdx > DataModel.EngineCoreCount then
    curIdx = 1
  end
  if nextIdx > DataModel.EngineCoreCount then
    nextIdx = 1
  end
  if DataModel.CurEngineCoreType ~= curIdx then
    DataModel.CurEngineCoreType = curIdx
    local temp = DataModel.NowElement
    DataModel.NowElement = DataModel.NextElement
    DataModel.NextElement = temp
  end
  if DataModel.NextEngineCoreType ~= nextIdx then
    DataModel.NextEngineCoreType = nextIdx
    Controller:ShowRightByType(DataModel.NextElement, nextIdx)
  end
  local deltaY = DataModel.endY - DataModel.startY
  DataModel.NowElement:SetLocalPositionY(deltaY * (1 - percent), 0)
  DataModel.NowElement:SetAlpha(percent)
  DataModel.NextElement:SetLocalPositionY(deltaY * percent, 0)
  DataModel.NextElement:SetAlpha(1 - percent)
  if 0.5 <= percent then
    percent = 1 - percent
  end
  View.Group_Engine.Img_Select:SetAlpha(1 - percent * 2)
end

function Controller:ComeBackAnim()
  local absDefaultZ = math.abs(DataModel.CurCoreAngleZ)
  local idx, percent = math.modf(absDefaultZ / DataModel.PerAngle)
  local speed = DataModel.comebackSpeed
  if 0.5 <= percent then
    local deltaAngle = DataModel.PerAngle * (idx + 1) - absDefaultZ
    if deltaAngle <= DataModel.comebackSpeed then
      speed = deltaAngle
      DataModel.ComeBack = false
    end
  else
    local deltaAngle = absDefaultZ - DataModel.PerAngle * idx
    if deltaAngle <= DataModel.comebackSpeed then
      speed = deltaAngle
      DataModel.ComeBack = false
    end
    speed = -speed
  end
  if DataModel.CurCoreAngleZ < 0 then
    speed = -speed
  end
  self:DoAnim(speed)
  if not DataModel.ComeBack then
    DataModel.NowElement:SetActive(true)
    DataModel.NextElement:SetActive(false)
    while DataModel.CurCoreAngleZ < 0 do
      DataModel.CurCoreAngleZ = DataModel.CurCoreAngleZ + 360
    end
    while 0 > DataModel.CurGearAngleZ do
      DataModel.CurGearAngleZ = DataModel.CurGearAngleZ + 360
    end
    View.Group_Engine.Group_Core:SetLocalEulerAngles(DataModel.CurCoreAngleZ)
    View.Group_Engine.Img_Gear:SetLocalEulerAngles(DataModel.CurGearAngleZ)
  end
end

return Controller
