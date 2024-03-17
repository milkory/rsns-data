local View = require("UIPetAcquire/UIPetAcquireView")
local DataModel = require("UIPetAcquire/UIPetAcquireDataModel")
local ViewFunction = {
  PetAcquire_Img_Back_Img_Info_Btn__Click = function(btn, str)
    View.Img_Back.Img_Info.InputField_:FocusInputField()
  end,
  PetAcquire_Btn_Confirm_Click = function(btn, str)
    local name = View.Img_Back.Img_Info.InputField_:GetText()
    if name == "" then
      CommonTips.OpenTips(GetText(80600225))
      return
    end
    local result = View.Img_Back.Img_Info.InputField_:CheckText(18)
    if result == 0 then
      Net:SendProto("pet.rename", function(json)
        PlayerData:GetHomeInfo().pet[DataModel.PetInfo.uid].name = name
        View.self:CloseUI()
      end, DataModel.PetInfo.uid, name)
    elseif result == 1 then
      CommonTips.OpenTips(GetText(80600088))
    elseif result == 2 then
      CommonTips.OpenTips(GetText(80600790))
    elseif result == 3 then
      CommonTips.OpenTips(GetText(80600087))
    end
  end
}
return ViewFunction
