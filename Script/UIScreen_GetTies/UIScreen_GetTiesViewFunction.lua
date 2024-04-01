local View = require("UIScreen_GetTies/UIScreen_GetTiesView")
local DataModel = require("UIScreen_GetTies/UIScreen_GetTiesDataModel")
local ViewFunction = {
  Screen_GetTies_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  Screen_GetTies_Btn_Confirm_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  Screen_GetTies_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  Screen_GetTies_ScrollGrid_GetTies_SetGrid = function(element, elementIndex)
    local data = DataModel.NewBuffList[elementIndex]
    element:SetActive(false)
    if data then
      element:SetActive(true)
      element.Txt_:SetText(string.format(GetText(80601011), data.petName, data.roleName, data.tiesName))
    end
  end
}
return ViewFunction
