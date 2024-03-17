local View = require("UIcargocompartment/UIcargocompartmentView")
local DataModel = require("UIcargocompartment/UIcargocompartmentDataModel")
local ViewFunction = require("UIcargocompartment/UIcargocompartmentViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.Index = tonumber(initParams)
    DataModel.WareHouse = {
      Rubbish = {
        id = 82900012,
        data = PlayerData:GetFactoryData(82900012, "HomeGoodsFactory"),
        serverData = {num = 0}
      },
      Goods = {}
    }
    local coach = PlayerData.ServerData.user_home_info.coach
    local space = 0
    for i, v in ipairs(coach) do
      local coachData = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
      if coachData.coachType and coachData.coachType ~= "" and 12600247 == coachData.coachType then
        space = coachData.space + space
      end
    end
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local total = 0
    local rubbishCount = 0
    for i, v in pairs(PlayerData.ServerData.user_home_info.warehouse) do
      local data = PlayerData:GetFactoryData(i, "HomeGoodsFactory")
      if data.mod == "垃圾" then
        DataModel.WareHouse.Rubbish = {
          id = i,
          serverData = v,
          data = data
        }
        rubbishCount = math.ceil(v.num / homeConfig.stackingquantity)
        total = total + rubbishCount
      else
        table.insert(DataModel.WareHouse.Goods, {
          id = i,
          serverData = v,
          data = data
        })
        total = total + v.num
      end
    end
    View.ScrollGrid_list.grid.self:SetDataCount(#DataModel.WareHouse.Rubbish)
    View.ScrollGrid_list.grid.self:RefreshAllElement()
    View.Img_rubbish:SetSprite(DataModel.WareHouse.Rubbish.data.imagePath)
    View.Txt_rubbishname:SetText(DataModel.WareHouse.Rubbish.data.name .. "(" .. DataModel.WareHouse.Rubbish.serverData.num .. ")")
    View.Txt_rubbishnumber:SetText("X" .. rubbishCount)
    View.Txt_capacity:SetText("容量:" .. total .. "/" .. math.floor(space))
    local text = PlayerData:GetFactoryData(80600374, "TextFactory").text .. "\n" .. PlayerData:GetFactoryData(80600375, "TextFactory").text .. "\n" .. PlayerData:GetFactoryData(80600376, "TextFactory").text
    View.Group_Tips.Txt_text:SetText(text)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
