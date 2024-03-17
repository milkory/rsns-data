local View = require("UIPassenger/UIPassengerView")
local DataModel = require("UIPassenger/UIPassengerDataModel")
local ViewFunction = {
  Passenger_ScrollGrid_List_SetGrid = function(element, elementIndex)
    if DataModel.passengerList[elementIndex] then
      local info = DataModel.passengerList[elementIndex][1]
      if info then
        local passengerCfg = PlayerData:GetFactoryData(info.psgData.id, "PassageFactory")
        if passengerCfg then
          element.Img_Bottom:SetSprite("UI/Passenger/passage_" .. passengerCfg.star)
          element.GroupIcon.Img_IconBg:SetSprite("UI/Passenger/hard_bottom_" .. passengerCfg.star)
          element.GroupIcon.Img_IconBg.Btn_herd.Img_Icon:SetSprite(passengerCfg.resUrl)
          element.Group_Name.Txt_Name:SetText(passengerCfg.type)
          element.GroupIcon.Group_gender.Img_women:SetActive(passengerCfg.gender == 12600653)
          element.GroupIcon.Group_gender.Img_male:SetActive(passengerCfg.gender == 12600646)
          element.GroupIcon.Group_gender.Img_neutral:SetActive(passengerCfg.gender == 12600667)
          local tag = ""
          if info.psgData.psg_tag ~= "" then
            tag = PlayerData:GetFactoryData(info.psgData.psg_tag, "ListFactory").name
          end
          element.Group_.Img_Tag.Txt_:SetText(tag)
          local career = PlayerData:GetFactoryData(passengerCfg.career, "TagFactory").leafletPlace
          element.Group_.Img_Career.Txt_:SetText(career)
          local age = PlayerData:GetFactoryData(passengerCfg.age, "TagFactory").leafletPlace
          element.Group_.Img_Age.Txt_:SetText(age)
          element.GroupIcon.Group_num.Txt_Num:SetText(table.count(DataModel.passengerList[elementIndex]) .. "名")
          element.Txt_Passage:SetText(GetText(passengerCfg.passageDesc))
          element.Group_destination.Group_firstPlace.Txt_first:SetText(PlayerData:GetFactoryData(info.startStationId, "HomeStationFactory").name)
          element.Group_destination.Group_destination.Txt_Destination:SetText(PlayerData:GetFactoryData(info.endStationId, "HomeStationFactory").name)
        end
      end
    end
  end,
  Passenger_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
    View.self:Confirm()
  end,
  Passenger_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
    View.self:Confirm()
  end,
  Passenger_Group_TopLeft_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Passenger_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80301465}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  Passenger_Group_TopRight_Btn_Star_Click = function(btn, str)
    View.Group_TopRight.Btn_Star.Img_Select:SetActive(true)
    View.Group_TopRight.Btn_Star.Img_UnSelect:SetActive(false)
    View.Group_TopRight.Btn_Place.Img_Select:SetActive(false)
    View.Group_TopRight.Btn_Place.Img_UnSelect:SetActive(true)
    DataModel.SetPassengerListByLevel()
    View.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.passengerList))
    View.ScrollGrid_List.grid.self:RefreshAllElement()
  end,
  Passenger_Group_TopRight_Btn_Place_Click = function(btn, str)
    View.Group_TopRight.Btn_Star.Img_Select:SetActive(false)
    View.Group_TopRight.Btn_Star.Img_UnSelect:SetActive(true)
    View.Group_TopRight.Btn_Place.Img_Select:SetActive(true)
    View.Group_TopRight.Btn_Place.Img_UnSelect:SetActive(false)
    DataModel.SetPassengerListByDistance()
    View.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.passengerList))
    View.ScrollGrid_List.grid.self:RefreshAllElement()
  end,
  Passenger_Group_TopRight_Btn_Screen_Click = function(btn, str)
  end,
  Passenger_Group_TopRight_Group_PassengerCapacity_Btn_Add_Click = function(btn, str)
  end,
  Passenger_Group_TopRight_Group_PassengerCapacity_Btn_Icon_Click = function(btn, str)
  end,
  Passenger_ScrollGrid_List_Group_Passenger_GroupIcon_Img_IconBg_Btn_herd_Click = function(btn, str)
  end,
  Passenger_Btn_Passenger_Click = function(btn, str)
    CommonTips.OpenNoteBook(3)
  end
}
return ViewFunction
