local View = require("UIGroup_BuyItem/UIGroup_BuyItemView")
local DataModel = require("UIGroup_BuyItem/UIGroup_BuyItemDataModel")
local ViewFunction = {
  Group_BuyItem_Btn_BG_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Group_BuyItem_Btn_Confirm_Click = function(btn, str)
    if DataModel.Price > PlayerData:GetGoodsById(DataModel.MoneyId).num then
      local callback = function()
        CommonTips.OpenStoreBuy()
      end
      CommonTips.OnPrompt(80600147, GetText(80600068), GetText(80600067), callback)
    else
      Net:SendProto("shop.buy", function(json)
        local row = json.reward
        row.Title = "获得道具"
        CommonTips.OpenShowItem(json.reward, function()
          UIManager:GoBack()
        end)
      end, tostring(40300005), 1, DataModel.NeedNum, DataModel.Id)
    end
  end,
  Group_BuyItem_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Group_BuyItem_Group_Middle_Group_Item1_Btn_Item_Click = function(btn, str)
  end
}
return ViewFunction
