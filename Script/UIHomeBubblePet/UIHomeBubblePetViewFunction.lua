local View = require("UIHomeBubblePet/UIHomeBubblePetView")
local DataModel = require("UIHomeBubblePet/UIHomeBubblePetDataModel")
local ViewFunction = {
  HomeBubblePet_Btn_Close_Click = function(btn, str)
    View.self:CloseUI()
    View.self:Confirm()
  end,
  HomeBubblePet_Group_Panel_Img_BubbleBG_Btn_PetInteractive_Click = function(btn, str)
    UIManager:Open("UI/HomePet/PetInfo", Json.encode({
      petList = {
        DataModel.uId
      },
      selectIndex = 1
    }))
    View.self:Confirm()
  end
}
return ViewFunction
