local View = require("UIHomeBubblePassenger/UIHomeBubblePassengerView")
local DataModel = require("UIHomeBubblePassenger/UIHomeBubblePassengerDataModel")
local ViewFunction = require("UIHomeBubblePassenger/UIHomeBubblePassengerViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      DataModel.uId = Json.decode(initParams).uId
      local passengerData
      for i, v in pairs(PlayerData:GetHomeInfo().passenger) do
        for passengerUid1, passengerInfo in pairs(v) do
          if passengerUid1 == DataModel.uId then
            passengerData = passengerInfo
            break
          end
        end
        if passengerData then
          break
        end
      end
      if passengerData.id ~= "" then
        local passengerCA = PlayerData:GetFactoryData(passengerData.id, "PassageFactory")
        View.Group_Panel.Group_Title.Txt_Title:SetText(passengerCA.type)
        local tag = ""
        tag = PlayerData:GetFactoryData(passengerData.psg_tag, "ListFactory").name
        View.Group_Panel.Group_Title.Txt_Title2:SetText(tag)
        local desCA = PlayerData:GetFactoryData(passengerCA.passageDesc, "TextFactory")
        View.Group_Panel.Img_BubbleBG.Txt_Des:SetText(desCA.text)
      end
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
