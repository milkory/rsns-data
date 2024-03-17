local View = require("UIUseItem/UIUseItemView")
local DataModel = require("UIUseItem/UIUseItemDataModel")
local BtnItem = require("Common/BtnItem")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  View.Img_BG.ScrollGrid_ItemList.grid.self:SetDataCount(#DataModel.CurShowList)
  View.Img_BG.ScrollGrid_ItemList.grid.self:RefreshAllElement()
end

function Controller:SetElement(element, elementIndex)
  local info = DataModel.CurShowList[elementIndex]
  if info.func == "Tips" then
    element.Group_Item:SetActive(false)
    element.Img_Bg:SetActive(false)
    element.Txt_Name:SetActive(false)
    element.Btn_Use:SetActive(false)
    element.Img_None:SetActive(false)
    element.Txt_Tips:SetActive(true)
    element.Txt_Tips:SetText(GetText(info.textId))
  else
    element.Txt_Tips:SetActive(false)
    element.Img_Bg:SetActive(true)
    local num = PlayerData:GetGoodsById(info.id).num
    element.Group_Item:SetActive(true)
    element.Txt_Name:SetActive(true)
    BtnItem:SetItem(element.Group_Item, {
      id = info.id,
      num = num
    })
    element.Group_Item.Btn_Item:SetClickParam(info.id)
    local itemCA = PlayerData:GetFactoryData(info.id)
    element.Txt_Name:SetText(itemCA.name)
    local isShow = 0 < num
    element.Btn_Use:SetActive(isShow)
    element.Img_None:SetActive(not isShow)
    if isShow then
      element.Btn_Use:SetClickParam(elementIndex)
    end
  end
end

function Controller:ElementBtnItemClick(btn, str)
  local id = tonumber(str)
  CommonTips.OpenPreRewardDetailTips(id, nil, true)
end

function Controller:ElementUseClick(btn, str)
  View.self:CloseUI()
  local idx = tonumber(str)
  local info = DataModel.CurShowList[idx]
  if info.func == "RefreshGoods" then
    local callbackStr = {}
    callbackStr.useItemType = "RefreshGoods"
    local t = {}
    t.itemId = info.id
    t.itemNum = PlayerData:GetGoodsById(t.itemId).num
    t.useNum = 1
    local itemCA = PlayerData:GetFactoryData(info.id, "ItemFactory")
    CommonTips.OnItemPromptBatch(string.format(GetText(80600453), itemCA.name), t, function()
      if PlayerData.TempCache.ItemPromptBatchNum == 0 or t.itemNum < PlayerData.TempCache.ItemPromptBatchNum then
        CommonTips.OpenTips(80600488)
        return
      end
      Net:SendProto("station.purchase_order", function(json)
        local useItem = {}
        useItem[info.id] = PlayerData.TempCache.ItemPromptBatchNum
        PlayerData:RefreshUseItems(useItem)
        CommonTips.OpenTips(80601103)
        callbackStr.json = json
        PlayerData.TempCache.PromptCallbackStr = Json.encode(callbackStr)
        View.self:Confirm()
      end, PlayerData.TempCache.ItemPromptBatchNum)
    end)
  elseif info.func == "RefreshBargain" then
    local itemCA = PlayerData:GetFactoryData(info.id, "ItemFactory")
    local param = {}
    param.itemId = info.id
    param.itemNum = PlayerData:GetGoodsById(info.id).num or 0
    param.useNum = 1
    CommonTips.OnItemPrompt(string.format(GetText(80600683), itemCA.name), param, function()
      local callbackStr = {}
      callbackStr.useItemType = "RefreshBargain"
      if DataModel.Params.canBargain then
        Net:SendProto("station.refresh_dicker", function(json)
          local useItem = {}
          useItem[info.id] = 1
          PlayerData:RefreshUseItems(useItem)
          CommonTips.OpenTips(80601998)
          PlayerData.TempCache.PromptCallbackStr = Json.encode(callbackStr)
          View.self:Confirm()
        end)
      else
        CommonTips.OpenTips(80601999)
      end
    end)
  elseif info.func == "BargainItem" then
    if DataModel.Params.isUsedBargainItem then
      CommonTips.OpenTips(80602312)
    else
      local useItem = {}
      useItem[info.id] = 1
      Net:SendProto("item.bargain", function(json)
        local serverHomeSkill = PlayerData.ServerData.home_skills
        local buffId = 0
        for k, v in pairs(json.home_skills) do
          serverHomeSkill[k] = v
          for id, detail in pairs(v.temp) do
            if detail.obtain == "item" then
              buffId = id
            end
          end
        end
        PlayerData:RefreshUseItems(useItem)
        local callbackStr = {}
        callbackStr.useItemType = "BargainItem"
        callbackStr.buffId = buffId
        callbackStr.isOneOfUs = info.isOneOfUs
        PlayerData.TempCache.PromptCallbackStr = Json.encode(callbackStr)
        View.self:Confirm()
      end, info.id)
    end
  end
end

return Controller
