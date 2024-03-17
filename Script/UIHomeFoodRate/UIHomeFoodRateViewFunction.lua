local View = require("UIHomeFoodRate/UIHomeFoodRateView")
local DataModel = require("UIHomeFoodRate/UIHomeFoodRateDataModel")
local MainUIController = require("UIMainUI/UIMainUIController")
local LocalRefreshUI = function()
  local starNum = DataModel.starNum
  View.Group_NotRated.self:SetActive(starNum <= 0)
  local groupStars = View.Group_Stars
  for i = 1, starNum do
    groupStars["Img_Yellow" .. i]:SetActive(true)
  end
  for i = starNum + 1, 5 do
    groupStars["Img_Yellow" .. i]:SetActive(false)
  end
  local groupRated = View.Group_Rated
  groupRated.self:SetActive(0 < starNum)
  if 0 < starNum then
    groupRated.Group_Letter.Txt_Words:SetText(GetText(DataModel.starDescList[starNum].id))
  end
end
local ViewFunction = {
  HomeFoodRate_Group_Rated_Btn_Confirm_Click = function(btn, str)
    Net:SendProto("meal.mark_score", function(json)
      UIManager:GoBack()
      UIManager:Open("UI/HomeFurniture/HomeFood")
      local heroCA = PlayerData:GetFactoryData(DataModel.hid, "UnitFactory")
      local tipStr = string.format(GetText(80601499), heroCA.name)
      CommonTips.OpenTips(tipStr)
    end, DataModel.mealId, DataModel.starNum)
  end,
  HomeFoodRate_Group_Stars_Btn_Star1_Click = function(btn, str)
    DataModel.starNum = 1
    LocalRefreshUI()
  end,
  HomeFoodRate_Group_Stars_Btn_Star2_Click = function(btn, str)
    DataModel.starNum = 2
    LocalRefreshUI()
  end,
  HomeFoodRate_Group_Stars_Btn_Star3_Click = function(btn, str)
    DataModel.starNum = 3
    LocalRefreshUI()
  end,
  HomeFoodRate_Group_Stars_Btn_Star4_Click = function(btn, str)
    DataModel.starNum = 4
    LocalRefreshUI()
  end,
  HomeFoodRate_Group_Stars_Btn_Star5_Click = function(btn, str)
    DataModel.starNum = 5
    LocalRefreshUI()
  end,
  HomeFoodRate_Btn_Skip_Click = function(btn, str)
    UIManager:GoBack()
    UIManager:Open("UI/HomeFurniture/HomeFood")
  end,
  RefreshUI = LocalRefreshUI
}
return ViewFunction
