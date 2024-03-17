local View = require("UILifeSkillTips/UILifeSkillTipsView")
local DataModel = require("UILifeSkillTips/UILifeSkillTipsDataModel")
local ViewFunction = {
  LifeSkillTips_Btn_Close_Click = function(btn, str)
    UIManager:CloseTip("UI/LifeSkillTips/LifeSkillTips")
  end,
  LifeSkillTips_Group_skillFrame_StaticGrid__SetGrid = function(element, elementIndex)
    local cfg = DataModel.life_list[elementIndex]
    local isEmpty = cfg == nil
    element.Group_SkillAdvance:SetActive(false)
    element.Group_None:SetActive(isEmpty)
    if not isEmpty then
      if cfg.count > 1 then
        element.Group_SkillAdvance:SetActive(true)
        element.Group_SkillAdvance.Group_1.Btn_level1:SetClickParam(elementIndex .. "|" .. cfg[1].id .. "|" .. cfg[1].desc)
        element.Group_SkillAdvance.Group_2.Btn_level1:SetClickParam(elementIndex .. "|" .. cfg[2].id .. "|" .. cfg[2].desc)
        element.Group_SkillAdvance.Group_1.Btn_level1.Img_lockIcon:SetActive(1 > cfg.unlock_level)
        element.Group_SkillAdvance.Group_1.Img_Off.Img_lockIcon:SetActive(1 > cfg.unlock_level)
        element.Group_SkillAdvance.Group_2.Img_Off.Img_lockIcon:SetActive(2 > cfg.unlock_level)
        element.Group_SkillAdvance.Group_2.Btn_level1.Img_lockIcon:SetActive(2 > cfg.unlock_level)
        element.Group_SkillAdvance.Group_1.Img_Off:SetActive(1 < cfg.unlock_level)
        element.Group_SkillAdvance.Group_2.Img_Off:SetActive(1 >= cfg.unlock_level)
      end
      element.Img_mask:SetActive(cfg.unlock_level == 0)
      local now_index = cfg.unlock_level == 0 and 1 or cfg.unlock_level
      local life_info = PlayerData:GetFactoryData(cfg[now_index].id)
      element.Txt_SkillDesc:SetText(cfg[now_index].desc)
      element.Group_SkillName.Txt_:SetText(life_info.name)
      element.Group_SkillName.Img_.Txt_:SetText(string.format(GetText(80600419), cfg[now_index].resonance_lv))
      if View.element == nil then
        View.element = {}
      end
      element.Img_SkillBg.Img_tradeTag:SetActive(life_info.tag == 1)
      element.Img_SkillBg.Img_produceTag:SetActive(life_info.tag == 2)
      element.Img_SkillBg.Img_homeTag:SetActive(life_info.tag == 3)
      element.Img_SkillBg.Img_otherTag:SetActive(life_info.tag == 4)
      View.element[elementIndex] = element
    end
  end,
  LifeSkillTips_Group_skillFrame_StaticGrid__Group_item_Group_SkillAdvance_Group_1_Btn_level1_Click = function(btn, str)
    local result = string.split(str, "|")
    local index = tonumber(result[1])
    local id = result[2]
    View.element[index].Group_SkillAdvance.Group_1.Img_Off:SetActive(false)
    View.element[index].Group_SkillAdvance.Group_2.Img_Off:SetActive(true)
    local life_info = PlayerData:GetFactoryData(id)
    View.element[index].Txt_SkillDesc:SetText(result[3])
    View.element[index].Group_SkillName.Txt_:SetText(life_info.name)
    local cfg = DataModel.life_list[index]
    View.element[index].Group_SkillName.Img_.Txt_:SetText(string.format(GetText(80600419), cfg[1].resonance_lv))
  end,
  LifeSkillTips_Group_skillFrame_StaticGrid__Group_item_Group_SkillAdvance_Group_2_Btn_level1_Click = function(btn, str)
    local result = string.split(str, "|")
    local index = tonumber(result[1])
    local id = result[2]
    View.element[index].Group_SkillAdvance.Group_1.Img_Off:SetActive(true)
    View.element[index].Group_SkillAdvance.Group_2.Img_Off:SetActive(false)
    local life_info = PlayerData:GetFactoryData(id)
    View.element[index].Txt_SkillDesc:SetText(result[3])
    View.element[index].Group_SkillName.Txt_:SetText(life_info.name)
    local cfg = DataModel.life_list[index]
    View.element[index].Group_SkillName.Img_.Txt_:SetText(string.format(GetText(80600419), cfg[2].resonance_lv))
  end
}
return ViewFunction
