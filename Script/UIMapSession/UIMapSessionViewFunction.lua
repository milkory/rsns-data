local View = require("UIMapSession/UIMapSessionView")
local DataModel = require("UIMapSession/UIMapSessionDataModel")
local MapEventController = require("UIMapSession/Controller_MapEventController")
local DataModelController = require("UIMapSession/UIMapSessionDataModelController")
local ViewFunction = {
  MapSession_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if MapEventController.GetClassMod() ~= nil then
      MapEventController.RecycleCurrent()
      return
    end
    if DataModel.isOnLeaveInited ~= true and DataModel.sessionCA.onLeaveId ~= nil and DataModel.sessionCA.onLeaveId > 0 then
      local continueAction = DataModelController.OnLeave()
      if continueAction == false then
        return
      end
    end
    DataModelController.Goback()
  end,
  MapSession_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  MapSession_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  MapSession_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end
}
return ViewFunction
