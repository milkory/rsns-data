local Controller = {}
local DataModel = require("UIHome_MachiningLathe/HomeMakeFurModel")
local CommonItem = require("Common/BtnItem")
local View
local GetItemIcon = function(itemId)
  local factoryName = DataManager:GetFactoryNameById(itemId)
  local caData = PlayerData:GetFactoryData(itemId, factoryName)
  local iconPath = ""
  if factoryName == "UnitFactory" then
    local unit = PlayerData:GetFactoryData(caData.viewId)
    iconPath = unit.face
  elseif factoryName == "HomeCoachFactory" then
    iconPath = caData.thumbnailone
  elseif factoryName == "UnitViewFactory" then
    iconPath = caData.iconPath
  else
    iconPath = caData.iconPath or caData.imagePath
  end
  return iconPath
end

function Controller.Init(view, initParams)
  View = view
  local data = Json.decode(initParams)
  local ufid = data.ufid
  DataModel.isGoback = data.isGoback
  DataModel.ufid = ufid
  local furniture = PlayerData.ServerData.user_home_info.furniture[ufid]
  DataModel.Init(furniture)
  Controller.OpenChoosePanel()
  DataModel.isGoback = false
end

function Controller.OpenMakePanel(pormulaId)
  View.Img_Right.Group_Choose:SetActive(false)
  View.Img_Right.Group_Make:SetActive(true)
  DataModel.nowPormulaId = pormulaId
  local Group_Make = View.Img_Right.Group_Make
  local pormulaCfg = PlayerData:GetFactoryData(pormulaId)
  DataModel.costList = pormulaCfg.drawForm
  DataModel.nowCoreList = pormulaCfg.unlockenergyCondition
  local getInfo = pormulaCfg.draw[1]
  local itemCfg = PlayerData:GetFactoryData(getInfo.id)
  Group_Make.Group_Product.Img_Contain.Txt_Name:SetText(itemCfg.name)
  Group_Make.Group_Product.Img_Contain.Btn_Staff:SetSprite(GetItemIcon(getInfo.id))
  local numInfo = getInfo.numMin == getInfo.numMax and string.format(GetText(80601982), getInfo.numMin) or string.format(GetText(80601876), getInfo.numMin, getInfo.numMax)
  Group_Make.Group_Product.Img_Contain.Img_Sum.Txt_Num:SetText(numInfo)
  local text = Group_Make.Group_Product.Img_Contain.ScrollView_Des.Viewport.Content.Txt_Des
  text:SetText(itemCfg.des)
  Group_Make.Group_Product.Img_Contain.ScrollView_Des:SetContentHeight(text:GetHeight())
  Group_Make.Group_Product.Img_Contain.ScrollView_Des:SetVerticalNormalizedPosition(1)
  local result = DataModel.CalExtraCost(pormulaId)
  if result.maxMoveEnergyNum ~= -1 then
    Group_Make.Img_Cost.Group_HomeEnergy.Txt_Num:SetText(result.moveEnergyCost)
    Group_Make.Img_Cost.Group_HomeEnergy:SetActive(true)
  else
    Group_Make.Img_Cost.Group_HomeEnergy:SetActive(false)
  end
  if result.maxGoldNum ~= -1 then
    Group_Make.Img_Cost.Group_GoldCoin.Txt_Num:SetText(result.goldCost)
    Group_Make.Img_Cost.Group_GoldCoin:SetActive(true)
  else
    Group_Make.Img_Cost.Group_GoldCoin:SetActive(false)
  end
  if result.maxEnergyNum ~= -1 then
    Group_Make.Img_Cost.Group_Energy.Txt_Num:SetText(result.energyCost)
    Group_Make.Img_Cost.Group_Energy:SetActive(true)
  else
    Group_Make.Img_Cost.Group_Energy:SetActive(false)
  end
  Group_Make.Group_Material.StaticGrid_Material.grid.self:RefreshAllElement()
  Group_Make.Img_Extra.Group_Enging.StaticGrid_Corelist.grid.self:RefreshAllElement()
  Group_Make.Img_Extra.Group_Probability.Txt_num:SetText(DataModel.FormatNum(pormulaCfg.added[1].chance * 100) .. "%")
  DataModel.CalMaxCompoundNum()
  Group_Make.Img_Count.Txt_Count:SetText(DataModel.selectNum)
  local isEnough = DataModel.MaterialIsEnough(DataModel.nowPormulaId)
  View.Img_Right.Group_Make.Group_unAble:SetActive(not isEnough)
  DataModel.UpdateNewFormula(pormulaId)
end

function Controller.OpenChoosePanel()
  View.Img_Right.Group_Choose:SetActive(true)
  View.Img_Right.Group_Make:SetActive(false)
  View.Group_Title.Group_LV.Txt_Num:SetText("Lv" .. DataModel.furLevel)
  View.Group_Title.Group_Name.Group_name.Txt_Chs:SetText(DataModel.furName)
  View.Group_CoreLevel.Img_Contain.StaticGrid_Corelist.grid.self:RefreshAllElement()
  local homeCommon = require("Common/HomeCommon")
  homeCommon.SetMoveEnergyElement(View.Group_TopRight.Group_HomeEnergy)
  homeCommon.SetLoadageElement(View.Group_TopRight.Group_Loadage)
  View.Group_TopRight.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
  View.Group_TopRight.Btn_Energy.Txt_Num:SetText(PlayerData:GetUserInfo().energy .. "/" .. PlayerData:GetUserInfo().max_energy)
  View.Img_Right.Group_Choose.Img_Top.ScrollGrid_Toplist.grid.self:SetDataCount(#DataModel.formulaGroupList)
  View.Img_Right.Group_Choose.Img_Top.ScrollGrid_Toplist.grid.self:RefreshAllElement()
  if not DataModel.isGoback then
    View.Img_Right.Group_Choose.Img_Top.ScrollGrid_Toplist.grid.self:MoveToTop()
  end
  View.Img_Right.Group_Choose.ScrollGrid_LevelList.grid.self:SetDataCount(#DataModel.formulaList)
  View.Img_Right.Group_Choose.ScrollGrid_LevelList.grid.self:RefreshAllElement()
  if not DataModel.isGoback then
    View.Img_Right.Group_Choose.ScrollGrid_LevelList.grid.self:MoveToTop()
  end
end

function Controller.RefreshMakePanel(selectNum)
  DataModel.UpdateNowSelectNum(selectNum)
  View.Img_Right.Group_Make.Img_Count.Txt_Count:SetText(DataModel.selectNum)
  View.Img_Right.Group_Make.Group_Material.StaticGrid_Material.grid.self:RefreshAllElement()
  local pormulaCfg = PlayerData:GetFactoryData(DataModel.nowPormulaId)
  local getInfo = pormulaCfg.draw[1]
  local numInfo = getInfo.numMin == getInfo.numMax and string.format(GetText(80601982), getInfo.numMin * DataModel.selectNum) or string.format(GetText(80601876), getInfo.numMin * DataModel.selectNum, getInfo.numMax * DataModel.selectNum)
  View.Img_Right.Group_Make.Group_Product.Img_Contain.Img_Sum.Txt_Num:SetText(numInfo)
  local numInfo
  local result = DataModel.CalExtraCost(DataModel.nowPormulaId)
  if result.maxMoveEnergyNum ~= -1 then
    local needNum = result.moveEnergyCost * DataModel.selectNum
    local colorInfo = result.maxMoveEnergyNum >= DataModel.selectNum and "#FFFFFF" or "#ff7750"
    numInfo = string.format("<color=%s>%d</color>", colorInfo, needNum)
    View.Img_Right.Group_Make.Img_Cost.Group_HomeEnergy.Txt_Num:SetText(numInfo)
    View.Img_Right.Group_Make.Img_Cost.Group_HomeEnergy:SetActive(true)
  else
    View.Img_Right.Group_Make.Img_Cost.Group_HomeEnergy:SetActive(false)
  end
  if result.maxGoldNum ~= -1 then
    local needNum = result.goldCost * DataModel.selectNum
    local colorInfo = result.maxGoldNum >= DataModel.selectNum and "#FFFFFF" or "#ff7750"
    numInfo = string.format("<color=%s>%d</color>", colorInfo, needNum)
    View.Img_Right.Group_Make.Img_Cost.Group_GoldCoin.Txt_Num:SetText(numInfo)
    View.Img_Right.Group_Make.Img_Cost.Group_GoldCoin:SetActive(true)
  else
    View.Img_Right.Group_Make.Img_Cost.Group_GoldCoin:SetActive(false)
  end
  if result.maxEnergyNum ~= -1 then
    local needNum = result.energyCost * DataModel.selectNum
    local colorInfo = result.maxEnergyNum >= DataModel.selectNum and "#FFFFFF" or "#ff7750"
    numInfo = string.format("<color=%s>%d</color>", colorInfo, needNum)
    View.Img_Right.Group_Make.Img_Cost.Group_Energy.Txt_Num:SetText(numInfo)
    View.Img_Right.Group_Make.Img_Cost.Group_Energy:SetActive(true)
  else
    View.Img_Right.Group_Make.Img_Cost.Group_Energy:SetActive(false)
  end
  local isEnough = DataModel.MaterialIsEnough(DataModel.nowPormulaId)
  View.Img_Right.Group_Make.Group_unAble:SetActive(not isEnough)
end

function Controller.Goback()
  if View.Img_Right.Group_Make.IsActive then
    DataModel.selectNum = 1
    View.Img_Right.Group_Choose:SetActive(true)
    View.Img_Right.Group_Make:SetActive(false)
    View.Img_Right.Group_Choose.ScrollGrid_LevelList.grid.self:RefreshAllElement()
    View.Img_Right.Group_Choose.Img_Top.ScrollGrid_Toplist.grid.self:RefreshAllElement()
    return
  end
  UIManager:GoBack()
end

function Controller.OpenMoveEnergyPanel()
  local homeCommon = require("Common/HomeCommon")
  homeCommon.OpenMoveEnergyUseItem(function()
    homeCommon.SetMoveEnergyElement(View.Group_TopRight.Group_HomeEnergy)
  end)
end

function Controller.LongPress(isAdd, btn)
  local param = 1
  if isAdd == false then
    param = -1
  end
  View.self:StartC(LuaUtil.cs_generator(function()
    while btn.Btn.isHandled do
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
      if isAdd then
        if DataModel.selectNum >= DataModel.maxCompoundNum then
          return
        end
      elseif DataModel.selectNum <= 1 then
        return
      end
      Controller.RefreshMakePanel(DataModel.selectNum + 1 * param)
    end
  end))
end

function Controller.StartMake()
  local formulaId = DataModel.nowPormulaId
  local num = DataModel.selectNum
  local addCapacity = 0
  for k, v in pairs(DataModel.costList) do
    local type = PlayerData:GetRewardType(v.id)
    if type == "GoodsTips" then
      addCapacity = addCapacity - v.num * DataModel.selectNum
    end
  end
  local pormulaCfg = PlayerData:GetFactoryData(formulaId)
  local getInfo = pormulaCfg.draw[1]
  local type = PlayerData:GetRewardType(getInfo.id)
  if type == "GoodsTips" then
    addCapacity = addCapacity + getInfo.numMin * DataModel.selectNum
  end
  local maxGoodsNum = PlayerData.GetMaxTrainGoodsNum()
  local nowGoodsNum = PlayerData:GetUserInfo().space_info.now_train_goods_num
  local callback = function()
    Net:SendProto("furniture.compound", function(json)
      CommonTips.OpenShowItem(json.reward, nil, GetText(80601984))
      for k, v in pairs(DataModel.costList) do
        local nowNum = PlayerData:GetGoodsById(v.id).num
        PlayerData:GetGoodsById(v.id).num = nowNum - v.num * DataModel.selectNum > 0 and nowNum - v.num * DataModel.selectNum or 0
      end
      DataModel.maxCompoundNum = DataModel.maxCompoundNum - DataModel.selectNum
      DataModel.maxCompoundNum = 0 < DataModel.maxCompoundNum and DataModel.maxCompoundNum or 1
      Controller.RefreshMakePanel(1)
      local homeCommon = require("Common/HomeCommon")
      homeCommon.SetMoveEnergyElement(View.Group_TopRight.Group_HomeEnergy)
      homeCommon.SetLoadageElement(View.Group_TopRight.Group_Loadage)
      View.Group_TopRight.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
    end, DataModel.ufid, formulaId, num)
  end
  if maxGoodsNum < addCapacity + nowGoodsNum and 0 < addCapacity then
    CommonTips.OnPrompt(80602099, nil, nil, callback)
  else
    callback()
  end
end

function Controller.UpdateFormulaGroupInfo(element, elementIndex)
  local data = DataModel.formulaGroupList[elementIndex]
  local cfg = PlayerData:GetFactoryData(data.id)
  element.Btn_Choose.Group_Name:SetActive(true)
  element.Btn_Choose.Group_Name.Txt_Name:SetText(cfg.name)
  local startposx = element.Btn_Choose.Group_Name.Rect.rect.width
  local txtWidth = element.Btn_Choose.Group_Name.Txt_Name:GetWidth()
  element.Btn_Choose.Group_Name.Txt_Name:SetAnchoredPositionX((startposx - txtWidth) / 2)
  DOTweenTools.Kill(element.Btn_Choose.Group_Name.Txt_Name.transform)
  if startposx < txtWidth then
    element.Btn_Choose.Group_Name.Txt_Name:SetLocalPositionX(0)
    element.Btn_Choose.Group_Name.Txt_Name:SetText(cfg.name .. "    " .. cfg.name)
    local spaceWidth = math.floor(element.Btn_Choose.Group_Name.Txt_Name.Txt.fontSize / 5) + 1
    local spaceNum = 4
    local txtWidth = element.Btn_Choose.Group_Name.Txt_Name:GetWidth()
    local endposx = txtWidth / 2 + spaceWidth * spaceNum / 2
    DOTweenTools.DOLocalMoveX(element.Btn_Choose.Group_Name.Txt_Name.transform, -endposx, 8):SetLoops(-1):SetEase(CS.DG.Tweening.Ease.Linear)
  end
  element.Btn_Choose.Img_Item:SetSprite(cfg.iconPath)
  element.Btn_Choose.Img_Select:SetActive(elementIndex == DataModel.selectGroupIdx)
  element.Btn_Choose.Img_Mask:SetActive(elementIndex ~= DataModel.selectGroupIdx)
  element.Btn_Choose:SetClickParam(elementIndex)
  element.Btn_Choose.Img_RedPoint:SetActive(0 < data.newCount)
  element.Group_Lock:SetActive(not data.isOwn)
  element.Group_Lock.Btn_Getway:SetClickParam(elementIndex)
end

function Controller.SelectFormulaGroup(index)
  if index == DataModel.selectGroupIdx or DataModel.formulaGroupList[index].isOwn == false then
    return
  end
  DataModel.UpdateSelectGroupInfo(index)
  View.Img_Right.Group_Choose.Img_Top.ScrollGrid_Toplist.grid.self:RefreshAllElement()
  View.Img_Right.Group_Choose.ScrollGrid_LevelList.grid.self:SetDataCount(#DataModel.formulaList)
  View.Img_Right.Group_Choose.ScrollGrid_LevelList.grid.self:RefreshAllElement()
  View.Img_Right.Group_Choose.ScrollGrid_LevelList.grid.self:MoveToTop()
end

function Controller.UpdateFormulaInfo(element, elementIndex)
  local id = DataModel.formulaList[elementIndex].id
  local pormulaCfg = PlayerData:GetFactoryData(id)
  local getInfo = pormulaCfg.draw[1]
  local itemCfg = PlayerData:GetFactoryData(getInfo.id)
  element.Txt_name:SetText(itemCfg.name)
  element.Btn_Get.Img_Get:SetSprite(GetItemIcon(getInfo.id))
  local num = getInfo.numMin == getInfo.numMax and getInfo.numMin or string.format("%d~%d", getInfo.numMin, getInfo.numMax)
  element.Btn_Get.Img_Num.Txt_Num:SetText(num)
  element.Btn_Get:SetClickParam(getInfo.id)
  local isEnough = DataModel.MaterialIsEnough(id)
  local unLock, lvUnLock, coreUnLock = DataModel.FormulaIsUnLock(id)
  if lvUnLock then
    element.Img_Lock:SetActive(false)
    local newGet = PlayerData:GetPlayerPrefs("int", id) == 0
    element.Img_RedPoint:SetActive(newGet and isEnough)
  else
    element.Img_RedPoint:SetActive(false)
    element.Img_Lock:SetActive(true)
    element.Img_Lock.Group_Warm.Group_Down.Txt_num:SetText(pormulaCfg.unlock)
  end
  if coreUnLock then
    element.Img_Core:SetActive(false)
  else
    element.Img_RedPoint:SetActive(false)
    element.Img_Core:SetActive(lvUnLock)
  end
  local result = DataModel.CalExtraCost(id)
  local extracostEnough = true
  if result.maxMoveEnergyNum ~= -1 then
    local needNum = result.moveEnergyCost * DataModel.selectNum
    local colorInfo = result.maxMoveEnergyNum >= DataModel.selectNum and "#FFFFFF" or "#ff7750"
    local numInfo = string.format("<color=%s>%d</color>", colorInfo, needNum)
    element.Img_Cost.Group_HomeEnergy.Txt_Num:SetText(numInfo)
    element.Img_Cost.Group_HomeEnergy:SetActive(true)
    element.Group_unAble.Btn_AddPL:SetActive(false)
    extracostEnough = result.maxMoveEnergyNum >= DataModel.selectNum
    element.Group_unAble.Btn_AddPL:SetActive(not extracostEnough and coreUnLock)
  else
    element.Img_Cost.Group_HomeEnergy:SetActive(false)
    element.Group_unAble.Btn_AddPL:SetActive(false)
  end
  if result.maxGoldNum ~= -1 then
    local needNum = result.goldCost * DataModel.selectNum
    local colorInfo = result.maxGoldNum >= DataModel.selectNum and "#FFFFFF" or "#ff7750"
    local numInfo = string.format("<color=%s>%d</color>", colorInfo, needNum)
    element.Img_Cost.Group_GoldCoin.Txt_Num:SetText(numInfo)
    element.Img_Cost.Group_GoldCoin:SetActive(true)
  else
    element.Img_Cost.Group_GoldCoin:SetActive(false)
  end
  if result.maxEnergyNum ~= -1 then
    local needNum = result.energyCost * DataModel.selectNum
    local colorInfo = result.maxEnergyNum >= DataModel.selectNum and "#FFFFFF" or "#ff7750"
    local numInfo = string.format("<color=%s>%d</color>", colorInfo, needNum)
    element.Img_Cost.Group_Energy.Txt_Num:SetText(numInfo)
    element.Img_Cost.Group_Energy:SetActive(true)
    extracostEnough = result.maxEnergyNum >= DataModel.selectNum
    element.Group_unAble.Btn_AddCM:SetActive(not extracostEnough and coreUnLock)
  else
    element.Img_Cost.Group_Energy:SetActive(false)
    element.Group_unAble.Btn_AddCM:SetActive(false)
  end
  DataModel.costList = pormulaCfg.drawForm
  element.StaticGrid_Material.grid.self:RefreshAllElement()
  if isEnough and unLock then
    element.Group_unAble:SetActive(false)
    element.Group_Able:SetActive(true)
    element.Group_Able.Btn_Start:SetClickParam(id)
  else
    element.Group_unAble:SetActive(unLock)
    element.Group_unAble.Img_LackStaff:SetActive(extracostEnough and unLock)
    element.Group_Able:SetActive(false)
  end
  DataModel.nowCoreList = pormulaCfg.unlockenergyCondition
  element.Img_Core.StaticGrid_Core.grid.self:RefreshAllElement(#DataModel.nowCoreList)
end

function Controller.UpdateCoreInfo(element, elementIndex, coreType)
  if coreType == 1 then
    local coreId = DataModel.coreList[elementIndex].id
    local lv = PlayerData.ServerData.engines[tostring(coreId)].lv
    local cfg = PlayerData:GetFactoryData(coreId)
    element.Img_Contain.Img_Icon:SetSprite(cfg.coreIconPath)
    element.Img_Name.Txt_Name:SetText(GetText(cfg.name))
    element.Img_Contain.Group_LV.Txt_Num:SetText("Lv" .. lv)
  elseif coreType == 2 then
    local data = DataModel.nowCoreList[elementIndex]
    element:SetActive(false)
    if data and 1 < data.num then
      element:SetActive(true)
      local cfg = PlayerData:GetFactoryData(data.id)
      element.Img_Core:SetSprite(cfg.coreIconPath)
      local color = "#FFFFFF"
      local engines = PlayerData.ServerData.engines
      if data.num > engines[tostring(data.id)].lv then
        color = "#ff7750"
      end
      element.Group_LV.Txt_LV:SetText(data.num)
      element.Group_LV.Txt_LV:SetColor(color)
      element.Group_LV.Txt_1:SetColor(color)
    end
  elseif coreType == 3 then
    local data = DataModel.nowCoreList[elementIndex]
    local cfg = PlayerData:GetFactoryData(data.id)
    element.Img_icon:SetSprite(cfg.coreIconPath)
    element.Img_LV.Txt_num:SetText(data.num)
  end
end

function Controller.UpdateFormulaMaterialInfo(element, elementIndex, materialType)
  local Group_Item, Img_Num
  if materialType == 1 then
    Group_Item = element.Group_Item
    element.Img_Num:SetActive(false)
    Img_Num = element.Img_Num
  else
    Group_Item = element.Group_ON.Group_Item
    element.Group_ON:SetActive(false)
    element.Group_OFF:SetActive(true)
    Img_Num = element.Group_ON.Img_Num
  end
  local costList = DataModel.costList
  Group_Item:SetActive(false)
  local data = costList[elementIndex]
  if data then
    if materialType == 1 then
      element.Img_Num:SetActive(true)
    else
      element.Group_ON:SetActive(true)
      local name = PlayerData:GetFactoryData(data.id).name
      element.Group_ON.Txt_Name:SetText(name)
      element.Group_OFF:SetActive(false)
    end
    Group_Item:SetActive(true)
    CommonItem:SetItem(Group_Item, {
      id = data.id,
      num = data.num
    }, EnumDefine.ItemType.Item)
    Group_Item.Txt_Num:SetActive(false)
    Group_Item.Btn_Item:SetClickParam(costList[elementIndex].id)
    local numInfo
    local holdNum = PlayerData:GetGoodsById(data.id).num
    local needNum = materialType == 1 and data.num or data.num * DataModel.selectNum
    local colorInfo = holdNum >= needNum and "#FFFFFF" or "#ff7750"
    numInfo = string.format("<color=%s>%d/%d</color>", colorInfo, holdNum, needNum)
    Img_Num.Txt_Num:SetText(numInfo)
  end
end

function Controller.OpenGetWayPanel(idx, posx)
  local data = {}
  local id = DataModel.formulaGroupList[idx].id
  local cfg = PlayerData:GetFactoryData(id)
  data.itemID = cfg.unlock
  if posx then
    local scalex = UIManager:GetCanvas().transform.localScale.x
    local maxPox = View.Img_Right.transform.position.x / scalex - 322
    if posx > maxPox then
      posx = maxPox
    end
  end
  data.posX = posx or 270
  data.posY = -180
  UIManager:Open("UI/Common/Group_GetWay", Json.encode(data))
end

return Controller
