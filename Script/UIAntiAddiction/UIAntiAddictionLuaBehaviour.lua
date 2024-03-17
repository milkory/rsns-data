local View = require("UIAntiAddiction/UIAntiAddictionView")
local DataModel = require("UIAntiAddiction/UIAntiAddictionDataModel")
local ViewFunction = require("UIAntiAddiction/UIAntiAddictionViewFunction")
local lastIndex, index
local InitCheckInTip = function()
  if DataModel.grow < 18 then
    View.Group_CheckInTip.self:SetActive(true)
    for i = 0, 2 do
      local txt = "Txt_Des_" .. i
      View.Group_CheckInTip[txt]:SetActive(false)
    end
    if DataModel.grow < 8 then
      View.Group_CheckInTip["Txt_Des_" .. 0]:SetActive(true)
    elseif DataModel.grow < 16 then
      View.Group_CheckInTip["Txt_Des_" .. 1]:SetActive(true)
    else
      View.Group_CheckInTip["Txt_Des_" .. 2]:SetActive(true)
    end
  end
end
local InitTimeTip = function()
  View.Group_TimeTip.Txt_Des_0:SetActive(false)
  View.Group_TimeTip.Txt_Des_1:SetActive(false)
  if PlayerData.AdministrationsAddictionHolidays == true then
    View.Group_TimeTip.Txt_Des_1:SetActive(true)
  else
    View.Group_TimeTip.Txt_Des_0:SetActive(true)
  end
  View.Group_TimeTip.Txt_Time:SetText(TimeUtil:GetAntiAddicitionCommonDesc(TimeUtil:SecondToTable(DataModel.param.time)))
end
local InitTimeUpTip = function()
  View.Group_TimeUpTip.Txt_Time:SetText(TimeUtil:GetAntiAddicitionCommonDesc(TimeUtil:SecondToTable(PlayerData.growTime)))
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      DataModel.param = Json.decode(initParams)
      index = DataModel.param.index
    end
    for k, v in pairs(DataModel.IndexAndSelect) do
      View[v].self:SetActive(false)
    end
    if PlayerData:GetUserInfo() and PlayerData:GetUserInfo().real_info.id_card then
      DataModel.grow = PlayerData:IsCheckYearOld(PlayerData:GetUserInfo().real_info.id_card)
    end
    if DataModel.IndexAndSelect[index] then
      View[DataModel.IndexAndSelect[index]].self:SetActive(true)
      if index == 1 then
        View.Group_CheckIn.Group_Name.InputField_Name.self:SetText("")
        View.Group_CheckIn.Group_ID.InputField_ID.self:SetText("")
      end
      if index == 2 then
        InitCheckInTip()
      end
      if index == 4 then
        InitTimeTip()
      end
      if index == 5 then
        InitTimeUpTip()
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
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
