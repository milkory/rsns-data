local View = require("UIActiveStore/UIActiveStoreView")
local DataModel = require("UIActiveStore/UIActiveStoreDataModel")
local Controller = {}
local npcId = 0
local defaultHeight = 102
local dialogGroup = {
  belongName = "",
  listId = 0,
  curIdx = 0
}
local getDetailText = function(info)
  local text = info.detailTxt
  if text == nil then
    text = GetTextNPCMod(info.id)
  end
  return text
end

function Controller:Init(isFirst)
  DataModel.StoreList = {}
  DataModel.CoinList = {}
  if DataModel.StoreCA.shopList and table.count(DataModel.StoreCA.shopList) > 0 then
    for k, v in pairs(DataModel.StoreCA.shopList) do
      local row = {}
      row.num = 0
      row.id = v.id
      row.ca = PlayerData:GetFactoryData(v.id)
      if PlayerData.ServerData.shops ~= nil then
        local shops = PlayerData.ServerData.shops[tostring(DataModel.ShopId)]
        if shops and shops.items then
          for c, d in pairs(shops.items) do
            if tonumber(d.id) == tonumber(v.id) then
              row.num = d.py_cnt
            end
          end
        end
      end
      row.index = k
      row.isResidual = 0 >= row.ca.purchaseNum - row.num and true or false
      row.residue = 0 < row.ca.purchaseNum - row.num and row.ca.purchaseNum - row.num or 0
      row.isMax_index = row.isResidual == true and 2 or 1
      table.insert(DataModel.StoreList, row)
    end
    table.sort(DataModel.StoreList, function(a, b)
      if a.isMax_index == b.isMax_index then
        return a.index < b.index
      end
      return a.isMax_index < b.isMax_index
    end)
    if isFirst then
      View.Group_Right.NewScrollGrid_CommodityList.grid.self:StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        View.Group_Right.NewScrollGrid_CommodityList.grid.self:SetDataCount(table.count(DataModel.StoreList))
        View.Group_Right.NewScrollGrid_CommodityList.grid.self:RefreshAllElement()
        View.Group_Right.NewScrollGrid_CommodityList.grid.self:MoveToTop()
      end))
    else
      View.Group_Right.NewScrollGrid_CommodityList.grid.self:SetDataCount(table.count(DataModel.StoreList))
      View.Group_Right.NewScrollGrid_CommodityList.grid.self:RefreshAllElement()
      View.Group_Right.NewScrollGrid_CommodityList.grid.self:MoveToTop()
    end
  else
    print_r("策划缺少配置StoreCA.shopList")
  end
  if DataModel.StoreCA.currencyShow and 0 < table.count(DataModel.StoreCA.currencyShow) then
    for k, v in pairs(DataModel.StoreCA.currencyShow) do
      local row = {}
      row = v
      local ca = PlayerData:GetFactoryData(v.id)
      row.buyPath = ca.buyPath
      row.num = PlayerData:GetGoodsById(v.id).num
      table.insert(DataModel.CoinList, row)
    end
    View.StaticGrid_Coin.grid.self:SetDataCount(table.count(DataModel.CoinList))
    View.StaticGrid_Coin.grid.self:RefreshAllElement()
  else
    print_r("策划缺少配置StoreCA.currencyShow")
  end
  if isFirst then
    DataModel.NpcId = PlayerData:GetFactoryData(DataModel.ActivityId).npcId
    Controller:SetNPCSpine(View.Group_NPC, DataModel.NpcId)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
  end
end

function Controller:SetNPCSpine(element, id)
  npcId = id
  local npcConfig = PlayerData:GetFactoryData(id, "NPCFactory")
  element.self:SetActive(true)
  if npcConfig.spineUrl ~= "" then
    element.SpineAnimation_Character:SetActive(true)
    element.Img_Role:SetActive(false)
    element.SpineAnimation_Character:SetData(npcConfig.spineUrl)
    local offset = Vector2(npcConfig.spineOffsetX, npcConfig.spineOffsetY)
    element.SpineAnimation_Character:SetAnchoredPosition(offset)
    if npcConfig.spineScale ~= nil then
      element.SpineAnimation_Character:SetLocalScale(Vector3(npcConfig.spineScale * 100, npcConfig.spineScale * 100, npcConfig.spineScale))
    end
  else
    element.SpineAnimation_Character:SetActive(false)
    element.Img_Role:SetActive(true)
    element.Img_Role:SetSprite(npcConfig.resUrl)
    local offset = Vector2(npcConfig.offsetX, npcConfig.offsetY)
    element.Img_Role:SetAnchoredPosition(offset)
  end
  element.Img_Name.Txt_Name:SetText(npcConfig.name)
  dialogGroup.belongName = ""
  dialogGroup.listId = 0
  dialogGroup.curIdx = 0
end

local setNpcText = function(element, txt)
  element.Img_Dialog.self:SetActive(true)
  element.Img_Dialog.Txt_Talk:SetText(txt)
  local height = element.Img_Dialog.Txt_Talk:GetHeight()
  element.Img_Dialog.Txt_Talk:SetHeight(height)
  element.Img_Dialog.self:SetHeight(defaultHeight + height)
  element.Img_Dialog.Txt_Talk:SetTweenContent(txt)
end

function Controller:SetNPCText(element, txtTable, tableName)
  if txtTable == nil or #txtTable <= 0 then
    return
  end
  if dialogGroup.belongName == tableName and dialogGroup.listId ~= 0 then
    local listCA = PlayerData:GetFactoryData(dialogGroup.listId, "ListFactory")
    local dialogList = listCA.dialogList
    if #dialogList > dialogGroup.curIdx then
      dialogGroup.curIdx = dialogGroup.curIdx + 1
      local info = dialogList[dialogGroup.curIdx]
      local text = getDetailText(info)
      setNpcText(element, text)
      return
    end
  end
  dialogGroup.belongName = tableName
  dialogGroup.listId = 0
  dialogGroup.curIdx = 0
  local totalWeight = 0
  for k, v in pairs(txtTable) do
    if not v.isHide then
      totalWeight = totalWeight + v.weight
    end
  end
  local randomWeight = math.random(1, totalWeight)
  local detailTxt = ""
  for k, v in pairs(txtTable) do
    if not v.isHide then
      randomWeight = randomWeight - v.weight
      if randomWeight <= 0 then
        local factoryName = DataManager:GetFactoryNameById(v.id)
        if factoryName == "ListFactory" then
          do
            local listCA = PlayerData:GetFactoryData(v.id, factoryName)
            local dialogList = listCA.dialogList
            if listCA.listType == NPCDiagGroupEnum.Mutex then
              for k1, v1 in pairs(dialogList) do
                if not v1.isHide then
                  detailTxt = getDetailText(v1)
                  break
                end
              end
              break
            end
            if listCA.listType == NPCDiagGroupEnum.Order then
              dialogGroup.listId = v.id
              dialogGroup.curIdx = 1
              local info = dialogList[dialogGroup.curIdx]
              detailTxt = getDetailText(info)
            end
          end
          break
        end
        detailTxt = getDetailText(v)
        break
      end
    end
  end
  if detailTxt == "" then
    element.Img_Dialog.self:SetActive(false)
    return
  end
  setNpcText(element, detailTxt)
end

function Controller:ShowNPCTalk(dialogEnum)
  local npcConfig = PlayerData:GetFactoryData(DataModel.NpcId, "NPCFactory")
  local textTable = npcConfig[dialogEnum]
  if textTable == nil then
    return
  end
  Controller:SetNPCText(View.Group_NPC, textTable, dialogEnum)
end

return Controller
