local DataModel = {
  drinkBuff = {},
  bargainBuff = {},
  preMouseDown = false
}

function DataModel:RefreshBuffGroup(group, buff)
  if group == nil then
    return
  end
  if buff == nil then
    group.self:SetActive(false)
    return
  end
  DataModel.buffNum = DataModel.buffNum + 1
  group.self:SetActive(true)
  local buffCA = PlayerData:GetFactoryData(buff.id, "HomeBuffFactory")
  local desc = buffCA.desc
  if buffCA.mod == "喝酒相关" then
    local oneForAll = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.OneForAll)
    if 0 < oneForAll then
      desc = buffCA.intensifyDesc
    end
  end
  if buffCA.buffType == EnumDefine.HomeSkillEnum.AddSpeedPercentage or buffCA.buffType == EnumDefine.HomeSkillEnum.AccelerationBrakingPerformance then
    desc = string.format(desc, math.floor(buff.param * 100))
  end
  if buffCA.name ~= nil and buffCA.name ~= "" then
    group.Txt_Tips1:SetText(buffCA.name)
  end
  group.Txt_Dec:SetText(desc)
  if buff.endTime and 0 < buff.endTime then
    local remainTime = buff.endTime - TimeUtil:GetServerTimeStamp()
    group.Txt_Time:SetText(string.format(GetText(80600773), math.ceil(remainTime / 60)))
  end
end

return DataModel
