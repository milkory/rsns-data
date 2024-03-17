local View = require("UIRainforestJar/UIRainforestJarView")
local DataModel = require("UIRainforestJar/UIRainforestJarDataModel")
local ViewFunction = {
  RainforestJar_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
    local mainUIView = require("UIMainUI/UIMainUIView")
    mainUIView.self:SetRaycastBlock(false)
    HomeManager:CamFocusEnd(function()
      mainUIView.self:SetRaycastBlock(true)
    end)
  end,
  RainforestJar_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
    local mainUIView = require("UIMainUI/UIMainUIView")
    mainUIView.self:SetRaycastBlock(false)
    HomeManager:CamFocusEnd(function()
      mainUIView.self:SetRaycastBlock(true)
    end)
  end,
  RainforestJar_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  RainforestJar_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  RainforestJar_Group_Details_Group_state_Btn_change_Click = function(btn, str)
    local skin_ufid = DataModel.skin_list[DataModel.select_Index].skin_ufid
    Net:SendProto("furniture.redecorate", function()
      HomeManager:ChangeFurnitureSkin(-1, DataModel.u_fid, DataModel.skin_list[DataModel.select_Index].id)
      DataModel.RefreshSkinData(DataModel.select_Index)
      View.Group_Details.ScrollGrid_.grid.self:RefreshAllElement()
      View.Group_Details.Group_state.Btn_change:SetActive(false)
      View.Group_Details.Group_state.Img_showing:SetActive(true)
    end, DataModel.u_fid, skin_ufid)
  end,
  RainforestJar_Group_Details_ScrollGrid__SetGrid = function(element, elementIndex)
    local skin_cfg = PlayerData:GetFactoryData(DataModel.skin_list[elementIndex].id)
    element.Img_plant:SetSprite(skin_cfg.SecondtipsPath)
    element.Txt_name:SetText(skin_cfg.name)
    element.Group_num.Txt_num:SetText(DataModel.skin_list[elementIndex].num)
    element.Btn_:SetClickParam(elementIndex)
    element.Img_selected:SetActive(elementIndex == DataModel.select_Index)
    element.Img_using:SetActive(DataModel.now_skin == DataModel.skin_list[elementIndex].id)
  end,
  RainforestJar_Group_Details_ScrollGrid__Group_plant_Btn__Click = function(btn, str)
    DataModel.select_Index = tonumber(str)
    View.Group_Details.ScrollGrid_.grid.self:RefreshAllElement()
    View.Group_Details.Group_state.Btn_change:SetActive(DataModel.now_skin ~= DataModel.skin_list[DataModel.select_Index].id)
    View.Group_Details.Group_state.Img_showing:SetActive(DataModel.now_skin == DataModel.skin_list[DataModel.select_Index].id)
  end
}
return ViewFunction
